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

  <title>Old Test Results</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>

    <%--<script src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>--%>
    <%--<script src="https://cdn.datatables.net/t/dt/jq-2.2.0,dt-1.10.11,b-1.1.2,b-colvis-1.1.2,b-html5-1.1.2,cr-1.3.1,fc-3.2.1,kt-2.1.1,rr-1.1.1,sc-1.4.1,se-1.1.2/datatables.min.js"></script>--%>
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
        var wordClicked = "";
        var groupedTests = {};
        var listOfTests = [];

        var baseUrl = getBaseUrl();
        var oTable;
        var optiplexIPAddress = "10.7.31.162";

        if ($.urlParam('result')) {
            testResult = $.urlParam('result')
        }

        if ($.urlParam('tags')) {
            testTags = $.urlParam('tags')
        }

        //var currentUrl = window.location.href;

        testRunId = location.pathname.split('/').pop();
        var environment;
        $.getJSON("http://" + optiplexIPAddress + ":8080/LumberJackService/testRun?testRunId=" + testRunId, function( dataSet ) {
            if (typeof dataSet.environment === 'undefined') {
                console.log("Environment is undefined!!")
            } else {
                environment = dataSet.environment;
            }

        });

        $(document).ready(function() {

            var testHistoryBlob= ${TestCaseHistory};

            var map = {};

            var testMatchFlag = true;
            var prevTestName = "";
            for (var key in testHistoryBlob) {
                var testName = testHistoryBlob[key].caseName;
                if (prevTestName != "" && prevTestName != testName) {
                    testMatchFlag = false;
                }
                if (!map.hasOwnProperty(testName) && testMatchFlag) {
                    listOfTests.push(testHistoryBlob[key]);
                } else {
                    map[prevTestName] = listOfTests;
                    testMatchFlag = true;
                }

                prevTestName = testName;

            }

            groupedTests = parseTestHistory(listOfTests);

            console.log("Stupid URL: " + "http://" + optiplexIPAddress + ":8080/LumberJackService/getTests?testRunId=" + testRunId + "&result=" + testResult + "&testTags=" + testTags)

            $.getJSON("http://" + optiplexIPAddress + ":8080/LumberJackService/getTests?testRunId=" + testRunId + "&result=" + testResult + "&testTags=" + testTags, function( dataSet ) {
                //console.log(dataSet);
                var errMessage = "";

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

                                baseUrl = baseUrl.toString().replace('/TestResults', '');
                                var testId = source.testCaseId;
                                var testName = source.caseName;
                                var result = source.caseResult;
//                                var testClassId = source.testClassExecutionId;
                                var resultObject = getResultImageHref(result)
                                var testCaseLinks = []

                                // testCaseLinks.push('<a href=' + baseUrl + 'TestLog?testCaseId=' + testId + '&testName=' + testName + '&environment=' + environment + ' data-toggle = "tooltip" title=' + source.environment + '><img src=' + resultObject.imageSource + '/>');
                                testCaseLinks.push('<a href=' + baseUrl + 'TestLog?testCaseId=' + testId + ' data-toggle = "tooltip" title=' + source.environment + '><img src=' + resultObject.imageSource + '/>');
                                if (groupedTests[testName]) {
                                    for (i = 0; i < groupedTests[testName].length; i++) {
                                        if (i < 6) {
                                            var testObject = groupedTests[testName][i];
                                            var resultObject1 = getResultImageHref(testObject.caseResult)
                                            console.log('TestId: ' + groupedTests[testName][i].caseId)
                                            console.log('<a href=' + baseUrl + 'TestLog?testCaseId=' + groupedTests[testName][i].caseId + '&testName=' + testName + '&environment=' + groupedTests[testName][i].environment + ' data-toggle = "tooltip" title=' + groupedTests[testName][i].environment + '><img src=' + resultObject1.imageSource + '/>');
                                            testCaseLinks.push('<a href=' + baseUrl + 'TestLog?testCaseId=' + groupedTests[testName][i].caseId + '&testName=' + testName + '&environment=' + groupedTests[testName][i].environment + ' data-toggle = "tooltip" title=' + groupedTests[testName][i].environment + '><img src=' + resultObject1.imageSource + '/>');
                                        } else {
                                            break;
                                        }
                                    }
                                }

                                return '<div class=' + resultObject.divClass + ' id=' + '1111' +  '><span class = hide>' + resultObject.divClass + '</span>' +
                                        testCaseLinks.join("  ");
                                '</div>';
                            }

                        }, {
                            "aTargets": [1],
                            "mData": function (source, type, val) {
                                var testId = source.testCaseId;
                                var testName = source.caseName;

                                baseUrl = baseUrl.toString().replace('/TestResults', '');
                                var link = '<a href=' + baseUrl + 'TestLog?testCaseId=' + testId + '&testName=' + testName + '&environment=' + '${environment}' + ' data-toggle = "tooltip">' + testId + '</a>';

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
                            // added to handle special stupid case
                            // class="lb_overlay js_lb_overlay"
                            "aTargets": [3],
//                            "mData": "errorMessage"
                            "mData": function (source, type, val) {
                                if (source.errorMessage == null) {
                                    errMessage = "";
                                } else if (!source.errorMessage.toString().includes("<div")) {
                                    errMessage = source.errorMessage;
                                    console.log(errMessage);
                                } else {
                                    errMessage = source.errorMessage.replace("<div", "");
                                }


                                return '<div>' + errMessage + '</div>';
                            }
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

            createSelectionChips();
        });  // end of DocumentReady function



        function alertId(testCaseId) {
            console.log(testCaseId);
        }

        function addHrefToLinks( testRunId) {
            //baseUrl = baseUrl.toString().replace('/TestResults', '');
            var passUrl = baseUrl + testRunId + "?result=PASSED" + "&environment=" + '${environment}';
            var failUrl = baseUrl + testRunId + "?result=FAILED" + "&environment=" + '${environment}';
            var impossibleUrl = baseUrl + testRunId + "?result=IMPOSSIBLE" + "&environment=" + '${environment}';
            var allUrl = baseUrl  + testRunId;
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
                words.push(
                        {
                            text: tokens[0],
                            name: tokens[0],
                            handlers:{
                                click: function() {
                                    var blah = tokens[0];
                                    return function() {
//                                    sessionStorage.setItem("selectedTags", blah);
                                        addSelectedTagToSession(blah);
//                                    alert("You Clicked the word! " + blah);
                                        window.location =  getBaseUrl() + testRunId +"?tags=" + sessionStorage.getItem("selectedTags") + "&environment=" + '${environment}';
                                    }
                                }()
                            },
                            weight: tokens[1]
                            //link: getBaseUrl() + testRunId +"?tags=" + "%" + tokens[0] + "%"
                        });
            }
            console.log("Length of tokens Map: "+ map.length);
        }

        // Method to add selected tags to local storage for sorting results
        // sessionStorage invalidates with new tab or window
        function addSelectedTagToSession(item) {
            if (sessionStorage.getItem("selectedTags") === null) {
                sessionStorage.setItem("selectedTags", item);
            } else {
                var currentSelectedTags = sessionStorage.getItem("selectedTags");
                // \bCreditCard\b /g regex grabs exact word g grabs all instances

                if (currentSelectedTags.indexOf(item) == -1) {
                    currentSelectedTags += " " + item;
                    sessionStorage.setItem("selectedTags", currentSelectedTags);
                }
            }
        }

        function createSelectionChips() {
            if (sessionStorage.getItem("selectedTags") !== null) {
                var currentTags = sessionStorage.getItem("selectedTags").trim();
                var tags = currentTags.split(" ");
                for (i = 0; i < tags.length; i++) {
                    var stupidTag = tags[i];
                    var $newdiv1 = $("<div class='chip' id=" + stupidTag + ">" + stupidTag + "<span class='closebtn' onclick=''>x</span></div>");
                    $(".chipItems").append($newdiv1);
                }

            }
        }

        $(document).on("click", ".closebtn", function() {
            var sessionTags = sessionStorage.getItem("selectedTags").split(" ");
            for (i = 0; i < sessionTags.length; i++) {
                if (this.parentNode.id === sessionTags[i]) {
                    var sessionTagsString = sessionStorage.getItem("selectedTags");
                    var newSessionTags = sessionTagsString.replace(sessionTags[i], "").replace(/  +/g, ' ').replace(",", "").trim();
                    if (!newSessionTags) {
                        sessionStorage.removeItem("selectedTags");
                        window.location =  getBaseUrl() + testRunId + "?environment=" + environment;
                    } else {
                        sessionStorage.setItem("selectedTags", newSessionTags);
                        window.location =  getBaseUrl() + testRunId +"?tags=" + sessionStorage.getItem("selectedTags") + "&environment=" + '${environment}';
                    }
                }
            }
            this.parentNode.remove();

        });

    </script>
</head>


<body>
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
    <div class="chipItems">

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

