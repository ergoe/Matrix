<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta content="text/html;charset=utf-8" http-equiv="Content-Type">
  <meta content="utf-8" http-equiv="encoding">

  <spring:url value="/resources/js/main.js" var="mainJs" />
  <spring:url value="/resources/js/colResizable-1.5.min.js" var="colResizable" />
  <spring:url value="/resources/css/mainStyle.css" var="mainCss" />

  <title>
  </title>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
  <script src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>

  <script src="${mainJs}"></script>
  <link href="${mainCss}" rel="stylesheet" />

  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.10/css/jquery.dataTables.min.css">

  <script>
    var testCaseId = "";
    var testCaseName = "";
    var optiplexIPAddress = "10.7.35.158";

    testCaseId = $.urlParam('testCaseId');
    testCaseName = $.urlParam('testName');

    $(document).ready(function() {

      $.getJSON("http://" + optiplexIPAddress + ":3000/testCaseLog?testId=" + testCaseId, function( dataSet ) {
        //console.log(dataSet);
        console.log("test case Id: " + testCaseId);
        var stckTrace = "";
        var lgMessage = "";

        $('#example').dataTable( {
          "iDisplayLebgth" : 100,
          "aLengthMenu": [[-1], ["All"]],
          "data": dataSet,
          "aoColumnDefs": [
            {
                "aTargets": [0],
                "mData": function ( source, type, val ) {
                    var entryTime = getNormalDatetime(source.entryTime);
                    return '<div class="entryTime">' + entryTime + '</div>';
                }
            }, {
              "aTargets": [3],
              "mData": "logLevel"
            }, {
              // added to handle special stupid case
              // class="lb_overlay js_lb_overlay"
              "aTargets": [4],
//              "mData": "logMessage"
              "mData": function (source, type, val) {
                if (source.logMessage == null) {
                  lgMessage = "";
                } else if (source.logMessage.toString().includes("<div")) {
                  lgMessage = source.logMessage.toString().replace("<div", "");
                } else {
                  lgMessage = source.logMessage;
                }
                return lgMessage;
              }

            }, {
              "aTargets": [5],
//              "mData": "stackTrace"
              // added to handle special stupid case
              // class="lb_overlay js_lb_overlay"
              "mData": function (source, type, val) {
                if (source.stackTrace == null) {
                  stckTrace = "";
                } else if (source.stackTrace.toString().includes("<div")) {
                  stckTrace = source.stackTrace.toString().replace("<div", "");
                } else {
                  stckTrace = source.stackTrace;
                }
                return stckTrace;
              }
            }, {
              "aTargets": [1],
              "mData": function (source, type, val) {
                var mainServerUrl = "http://boiapp204.body.local/testresults";

                if (source.screenShotLink) {
                  var link = '<a href=' + mainServerUrl + source.screenShotLink + '>' +
                          '<img src=' + mainServerUrl + source.screenShotLink + ' alt=image ' + 'style="width:200px">' + '</a>';

                  return '<div class="screenShotLink">' + link + '</div>';
                } else {
                  return '';
                }
              }
            }, {
              "aTargets": [2],
              "mData": function (source, type, val) {
                var mainServerUrl = "http://boiapp204.body.local/testresults";

                if (source.htmlSourceLink) {
                    var link = '<a href=' + mainServerUrl + source.htmlSourceLink + '>' + 'html' + '</a>';

                    return '<div class="htmlSourceLink">' +  link + '</div>';
                } else {
                    return '';
                }
              }
            }
          ],
          "aoColumns": [
            { "bSortable": false }

          ]

        });
      });
        $("p").text(testCaseName);
      $.getJSON("http://" + optiplexIPAddress + ":8080/AllSpark/testCaseHistory/mobileAccountLogin?environment=stage", function( dataSet ) {
          console.log(dataSet);
          console.log(dataSet[0].caseName);
      });
    });

  </script>
</head>
<body>
<div>
  <p></p>
</div>
<table id="example" class="display" width="100%">
  <thead>
  <tr>
    <th>Entry Time</th>
    <th>Screen Shot</th>
      <th>HTML Source</th>
    <th>Log Level</th>
    <th>Log Message</th>
    <th>Stack Trace</th>
  </tr>
  </thead>
</table>
