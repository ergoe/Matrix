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
//    $.urlParam = function(name) {
//      var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
//      if (results == null) {
//        return null;
//      } else {
//        return results[1] || 0;
//      }
//    }

    testCaseId = $.urlParam('testCaseId');
    testCaseName = $.urlParam('testName');
    $(document).ready(function() {

      $.getJSON("http://eric-OptiPlex-980:3000/testCaseLog?testId=" + testCaseId, function( dataSet ) {
        //console.log(dataSet);
        console.log("test case Id: " + testCaseId);

        $('#example').dataTable( {
          "iDisplayLebgth" : 100,
          "aLengthMenu": [[-1], ["All"]],
          "data": dataSet,
          "aoColumnDefs": [
            {
                "aTargets": [0],
                "mData": function ( source, type, val ) {
                    var entryTime = getNormalDatetime(source.entryTime);
                    return '<div id="entryTime">' + entryTime + '</div>';
                }
            }, {
              "aTargets": [3],
              "mData": "logLevel"
            }, {
              "aTargets": [4],
              "mData": "logMessage"
            }, {
              "aTargets": [5],
              "mData": "stackTrace"
            }, {
              "aTargets": [1],
              "mData": function (source, type, val) {
                var mainServerUrl = "http://boiapp204.body.local/testresults";

                if (source.screenShotLink) {
                  var link = '<a href=' + mainServerUrl + source.screenShotLink + '>' +
                          '<img src=' + mainServerUrl + source.screenShotLink + ' alt=image ' + 'style="width:240px">' + '</a>';

                  return link;
                } else {
                  return '';
                }
              }
            }, {
              "aTargets": [2],
              "mData": function (source, type, val) {
                var mainServerUrl = "http://boiapp204.body.local/testresults";

                if (source.htmlSourceLink) {
                    var link = '<a href=' + "view-source:" + mainServerUrl + source.htmlSourceLink + '>' + 'html' + '</a>';

                    return link;
                } else {
                    return '';
                }
              }
              //"mData": "htmlSourceLink"
            }
          ],
          "aoColumns": [
            { "bSortable": false }

          ]

        });
      });
        $("p").text(testCaseName);
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
    <%--<th>HTML Source</th>--%>
    <%--<th>Test Case Execution ID</th>--%>
  </tr>
  </thead>
</table>
