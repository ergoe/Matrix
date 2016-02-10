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
        var testRunId = "";

        function getBaseUrl() {
            var re = new RegExp(/^.*\//);
            return re.exec(window.location.href);
        }

        var baseUrl = getBaseUrl();

        testRunId = $.urlParam('testRunId')
        console.log("TestRunId: " + testRunId);
        $(document).ready(function() {

            $.getJSON("http://eric-OptiPlex-980:3000/testCaseResults?testRunId=" + testRunId, function( dataSet ) {
                //console.log(dataSet);

                $('#example').dataTable( {
                    "iDisplayLebgth" : 100,
                    "aLengthMenu": [[200, 300, 400, -1], [200, 300, 400, "All"]],

                    "data": dataSet,
                    "aoColumnDefs": [
                        {   "aTargets": [0],
                            "mData": function ( source, type, val ) {
                                var testId = source.testCaseId;
                                var testName = source.caseName;
                                // Debugging in IDE
                                var link = '<a href=' + baseUrl + 'TestLog?testCaseId=' + testId + '&testName=' + testName + '>' + testId + '</a>';
                                // Deployed to Production
                                //var link = '<a href=' + baseUrl + 'Matrix' + '/TestLog?testCaseId=' + testId + '&testName=' + testName + '>' + testId + '</a>';
                                console.log(link);
                                return link;
                            }


//                        }, {
//                            "aTargets": [1],
//                            "mData": function ( source, type, val ) {
//                                var startTime = getNormalDatetime(source.startTime);
//                                return '<div id="startTime">' + startTime + '</div>';
//                            }
////                            "mData": "startTime"
//                        }, {
//                            "aTargets": [2],
//                            "mData": function ( source, type, val ) {
//                                var endTime = getNormalDatetime(source.endTime);
//                                return '<div id="colEndTime">' + endTime + '</div>';
//                            }
////                            "mData": "endTime"
                        }, {
                            "aTargets": [1],
                            "mData": function ( source, type, val ) {
                                var caseName = source.caseName;
                                return '<div id="colCaseName">' + caseName + '</div>';
                            }
//                            "mData": "caseName"
                        }, {
//                            "aTargets": [2],
//                            "mData": "result"
//                        }, {
//                            "aTargets": [2],
//                            "mData": "executionNode"
//                        }, {
                            "aTargets": [2],
                            "mData": "errorMessage"
//                        }, {
//                            "aTargets": [4],
//                            "mData": "testClassExecutionId"
//                        }, {
//                            "aTargets": [5],
//                            "mData": "browser"
//                        }, {
//                            "aTargets": [6],
//                            "mData": "className"
//                        }, {
//                            "aTargets": [7],
//                            "mData": "testRunId"
                        }
                    ],
                    "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                        if ( aData['result'] == "FAILED") {
                            $('td', nRow).css('background-color', 'Red');
                        } else if ( aData['result'] == "PASS") {
                            $('td', nRow).css('background-color', 'GREEN');
                        }
                    }

                });
            });
        });
    </script>
</head>


<body>
<div id="container">


    <div id="testResultsGroup">

    </div>
    <table id="example" class="display" width="100%">
      <thead>
      <tr>
        <th>Test ID</th>
        <%--<th>Start Time</th>--%>
        <%--<th>End Time</th>--%>
        <th>Case Name</th>
        <%--<th>Result</th>--%>
        <%--<th>Execution Node</th>--%>
        <th>Error Message</th>
        <%--<th>Test Class ID</th>--%>
        <%--<th>Browser</th>--%>
        <%--<th>Class Name</th>--%>
        <%--<th>Test Run</th>--%>
      </tr>
      </thead>
    </table>
</div> <%-- container id --%>

