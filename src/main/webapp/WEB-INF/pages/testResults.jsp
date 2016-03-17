<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta content="text/html;charset=utf-8" http-equiv="Content-Type">
  <meta content="utf-8" http-equiv="encoding">
    <spring:url value="/resources/js/bootstrap.min.js" var="bootStrapJs" />
    <spring:url value="/resources/js/main.js" var="mainJs" />
    <spring:url value="/resources/js/jqcloud.min.js" var="jqcloudJs" />
    <spring:url value="/resources/js/colResizable-1.5.min.js" var="colResizable" />
    <spring:url value="/resources/js/jquery.dataTables.rowGrouping.js" var="rowGroupJs" />
    <spring:url value="/resources/js/jquery.sparkline.min.js" var="sparkline" />
    <spring:url value="/resources/css/bootstrap.css" var="bootStrapCss" />
    <spring:url value="/resources/css/mainStyle.css" var="mainCss" />
    <spring:url value="/resources/css/jqcloud.min.css" var="jqcloudCss" />

  <title>
  </title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>

    <%--<script src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>--%>
    <script src="https://cdn.datatables.net/t/dt/jq-2.2.0,dt-1.10.11,b-1.1.2,b-colvis-1.1.2,b-html5-1.1.2,cr-1.3.1,fc-3.2.1,kt-2.1.1,rr-1.1.1,sc-1.4.1,se-1.1.2/datatables.min.js"></script>
    <%--<script src="${rowGroupJs}"></script>--%>
    <script src="${bootStrapJs}"></script>
    <script src="${jqcloudJs}"></script>
    <script src="${colResizable}"></script>
    <script src="${sparkline}"></script>
    <script src="${mainJs}"></script>


    <link href="${bootStrapCss}" rel="stylesheet" />
    <link href="${mainCss}" rel="stylesheet" />
    <link href="${jqcloudCss}" rel="stylesheet" />
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.10/css/jquery.dataTables.min.css">

    <script>
        var testRunId = "";
        var testResult = "";
        var testTags = "";
        var cloudObjectsArray = [];
        var words = [];

        function getBaseUrl() {
            var re = new RegExp(/^.*\//);
            return re.exec(window.location.href);
        }

        var baseUrl = getBaseUrl();
        var oTable;
        //testRunId = $.urlParam('testRunId')
        if ($.urlParam('result')) {
            testResult = $.urlParam('result')
        }

        if ($.urlParam('tags')) {
            testTags = $.urlParam('tags')
        }

        var currentUrl = window.location.href;
        //testRunId = currentUrl.substring(currentUrl.lastIndexOf('/' + 1)).replace('/', '');
        testRunId = location.pathname.split('/').pop();
//        console.log("TestRunId: " + testRunId);
        $(document).ready(function() {
            console.log("Stupid URL: " + "http://eric-OptiPlex-980:3000/testCaseResults?testRunId=" + testRunId + "&result=" + testResult + "&tags=" + testTags)

            $.getJSON("http://eric-OptiPlex-980:3000/testCaseResults?testRunId=" + testRunId + "&result=" + testResult + "&tags=" + testTags, function( dataSet ) {
                //console.log(dataSet);

                oTable = $('#example').dataTable( {

                    "iDisplayLebgth" : 100,
                    "aLengthMenu": [[200, 300, 400, -1], [200, 300, 400, "All"]],
                    "bAutoWidth": false,
                    "aoColumns": [
                        { "sWidth": "10%" }, // 1st column width
                        { "sWidth": "10%" }, // 2nd column width
                        { "sWidth": "30%" },
                        { "sWidth": "50%" },
                    ],
                    "data": dataSet,
                    "aoColumnDefs": [
                        {

                            "aTargets": [0],
                            "mData": function (source, type, val) {
                                var result = source.result;
                                return '<div class="colResult">' + result + '</div>';
//                                return '<div id="colResult" class="inlinesparkline">' + 1 + '</div>';
                            }

                        }, {
                            "aTargets": [1],
                            "mData": function (source, type, val) {
                                var testId = source.testCaseId;
                                var testName = source.caseName;

                                baseUrl = baseUrl.toString().replace('/TestResults', '');
                                var link = '<a href=' + baseUrl + 'TestLog?testCaseId=' + testId + '&testName=' + testName + '>' + testId + '</a>';

                                return link;
                            }

                        }, {
                            "aTargets": [2],
                            "mData": function ( source, type, val ) {
                                var caseName = source.caseName;
                                return '<div class="colCaseName">' + caseName + '</div>';
                            }
//
                        }, {
                            "aTargets": [3],
                            "mData": "errorMessage"
                        }
                    ],

                    "fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull) {

                        $(nRow).attr("id", aData["testCaseId"]);
                        var testCase = aData["testCaseId"];
//                        $(nRow).attr("onClick", 'alertId(' + testCase + ')');
//                        return nRow;
                        $(nRow).attr("data-toggle", "tooltip");
                        if (aData["tags"] != null) {
                            $(nRow).attr("title", aData["tags"]);
                            $('td', nRow).css('background-color', '#D8D8D8');
                        }


                    }

                }); // end of
            }); // end of getJSON method
            addHrefToLinks(testRunId);
            console.log("Document Ready");


            var blah = "${testTags}"
            var blahSplit = blah.replace('}', '').replace('{', '').replace(',', '').split(' ');
            createWordCloudObjects(blahSplit);

            $(function () {
                $('[data-toggle="tooltip"]').tooltip()
            })

            $('#demo').jQCloud(words);
        });  // end of DocumentReady function



        function alertId(testCaseId) {
            console.log(testCaseId);
        }

        function addHrefToLinks( testRunId) {
            //baseUrl = baseUrl.toString().replace('/TestResults', '');
            var passUrl = baseUrl + testRunId + "?result=PASS";
            var failUrl = baseUrl + testRunId + "?result=FAIL";
            var impossibleUrl = baseUrl + testRunId + "?result=IMPOSSIBLE";
            var allUrl = baseUrl + testRunId;
            document.getElementById("passedLink").setAttribute("href", passUrl);
            document.getElementById("failedLink").setAttribute("href", failUrl);
            document.getElementById("impossibleLink").setAttribute("href", impossibleUrl);
            document.getElementById("totalLink").setAttribute("href", allUrl);
        }

        function createWordCloudObjects(listOfObjects) {

            var map = {};
            for (var i = 0; i < listOfObjects.length; i++) {
                var tokens = listOfObjects[i].split('=');
                map[tokens[0]] = tokens[1];
                words.push({
                    text: tokens[0],
                    weight: tokens[1],
                    link: "http://eric-optiplex-980:8080/Matrix/TestResults/" + testRunId +"?tags=" + "%" + tokens[0] + "%"
                });
            }
            console.log("Length of tokens Map: "+ map.length);
        }


    </script>
</head>


<body>

    <%--<jsp:include page="homeNavigation.jsp">--%>
        <%--<jsp:param name="testHomeButton" value="Hello"/>--%>
    <%--</jsp:include>--%>
    <div class="container">
        <div id="homeButton" class="item">
            <button id="goHomeButton" class="InputAddOn-item" onclick="navigateHome();">Home</button>
        </div>
        <div id="pass" class="item">
            <%--baseUrl = baseUrl.toString().replace('/TestResults', '');--%>
            <%--var link = '<a href=' + baseUrl + 'TestLog?testCaseId=' + testId + '&testName=' + testName + '>' + testId + '</a>';--%>
            <a id = "passedLink"> <h3>Pass: ${Passed}</h3> </a>
        </div>
        <div id="fail" class="item">
            <a id = "failedLink"><h3>Fail: ${Failed}</h3></a>
        </div>
        <div id="impossible" class="item">
            <a id = "impossibleLink"><h3>Impossible: ${Impossible}</h3></a>
        </div>
        <div id="total" class="item">
            <a id = "totalLink"><h3>Total: ${Total}</h3></a>
        </div>
    </div>
    <div id="demo" class="demo jqcloud">

    </div>
    <table id="example" class="display" width="100%">
      <thead>
      <tr>
        <th>Result</th>
        <th>Test ID</th>
        <th>Case Name</th>
        <th>Error Message</th>
      </tr>
      </thead>
    </table>
</body>

