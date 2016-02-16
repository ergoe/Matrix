<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta content="text/html;charset=utf-8" http-equiv="Content-Type">
  <meta content="utf-8" http-equiv="encoding">
    <spring:url value="/resources/js/main.js" var="mainJs" />
    <spring:url value="/resources/js/colResizable-1.5.min.js" var="colResizable" />
    <spring:url value="/resources/js/jquery.dataTables.rowGrouping.js" var="rowGroupJs" />
    <spring:url value="/resources/js/jquery.sparkline.min.js" var="sparkline" />
    <spring:url value="/resources/css/mainStyle.css" var="mainCss" />

  <title>
  </title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>

    <%--<script src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>--%>
    <script src="https://cdn.datatables.net/t/dt/jq-2.2.0,dt-1.10.11,b-1.1.2,b-colvis-1.1.2,b-html5-1.1.2,cr-1.3.1,fc-3.2.1,kt-2.1.1,rr-1.1.1,sc-1.4.1,se-1.1.2/datatables.min.js"></script>
    <%--<script src="${rowGroupJs}"></script>--%>
    <script src="${mainJs}"></script>
    <script src="${colResizable}"></script>
    <script src="${sparkline}"></script>


    <link href="${mainCss}" rel="stylesheet" />
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.10/css/jquery.dataTables.min.css">

    <script>
        var testRunId = "";

        function getBaseUrl() {
            var re = new RegExp(/^.*\//);
            return re.exec(window.location.href);
        }

        var baseUrl = getBaseUrl();
        var oTable;
        testRunId = $.urlParam('testRunId')
//        console.log("TestRunId: " + testRunId);
        $(document).ready(function() {

            $.getJSON("http://eric-OptiPlex-980:3000/testCaseResults?testRunId=" + testRunId, function( dataSet ) {
                //console.log(dataSet);

                oTable = $('#example').dataTable( {

                    "iDisplayLebgth" : 100,
                    "aLengthMenu": [[200, 300, 400, -1], [200, 300, 400, "All"]],

                    "data": dataSet,
                    "aoColumnDefs": [
                        {

                            "aTargets": [0],
                            "mData": function (source, type, val) {
                                var result = source.result;
                                return '<div id="colResult">' + result + '</div>';
//                                return '<div id="colResult" class="inlinesparkline">' + 1 + '</div>';
                            }
                        }, {
                            "aTargets": [1],
                            "mData": function (source, type, val) {
                                var testId = source.testCaseId;
                                var testName = source.caseName;
                                // Debugging in IDE
                                var link = '<a href=' + baseUrl + 'TestLog?testCaseId=' + testId + '&testName=' + testName + '>' + testId + '</a>';
                                // Deployed to Production
                                //var link = '<a href=' + baseUrl + 'Matrix' + '/TestLog?testCaseId=' + testId + '&testName=' + testName + '>' + testId + '</a>';
//                                console.log(link);
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
//                        }, {
//                            "aTargets": [1],
//                            "mData": function ( source, type, val ) {
//                                var result = source.result;
//                                return '<div id="colResult">' + result + '</div>';
////                                return '<div id="colResult" class="inlinesparkline">' + 1 + '</div>';
//                            }
                        }, {
                            "aTargets": [2],
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
                            "aTargets": [3],
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
//                        if ( aData['result'] == "FAILED") {
//                            $('td', nRow).css('background-color', 'Red');
//                        } else if ( aData['result'] == "PASS") {
//                            $('td', nRow).css('background-color', 'GREEN');
//                        }


                        $(nRow).attr("id", aData["testCaseId"]);
                        var testCase = aData["testCaseId"];
                        $(nRow).attr("onClick", 'alertId(' + testCase + ')');
                        //console.log(testCase);
//
                        return nRow;
                    }
//
                }); // end of
            }); // end of getJSON method
            console.log("Document Ready");
        });  // end of DocumentReady function



        function alertId(testCaseId) {
            console.log(testCaseId);
        }


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
        <th>History</th>
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

