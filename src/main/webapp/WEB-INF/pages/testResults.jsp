<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta content="text/html;charset=utf-8" http-equiv="Content-Type">
  <meta content="utf-8" http-equiv="encoding">
  <title>
  </title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
  <script src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.10/css/jquery.dataTables.min.css">

  <script>


  </script>
</head>
<body>
<script>
  var testRunId = "";
  $.urlParam = function(name) {
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
    if (results == null) {
      return null;
    } else {
      return results[1] || 0;
    }
  }

  function getBaseUrl() {
    var re = new RegExp(/^.*\//);
    return re.exec(window.location.href);
  }

  var baseUrl = getBaseUrl();

  testRunId = $.urlParam('testRunId')
  $(document).ready(function() {

    $.getJSON("http://localhost:3000/testCaseResults?testRunId=" + testRunId, function( dataSet ) {
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
//                var link = '<a href=' + baseUrl + 'Matrix' + '/TestLog?testCaseId=' + testId + '&testName=' + testName + '>' + testId + '</a>';
                console.log(link);
                return link;
              }


          }, {
              "aTargets": [1],
              "mData": "startTime"
          }, {
              "aTargets": [2],
              "mData": "endTime"
          }, {
            "aTargets": [3],
            "mData": "caseName"
          }, {
            "aTargets": [4],
            "mData": "result"
          }, {
            "aTargets": [5],
            "mData": "executionNode"
          }, {
            "aTargets": [6],
            "mData": "errorMessage"
          }, {
            "aTargets": [7],
            "mData": "testClassExecutionId"
          }, {
            "aTargets": [8],
            "mData": "browser"
          }, {
            "aTargets": [9],
            "mData": "className"
          }, {
            "aTargets": [10],
            "mData": "testRunId"
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
<table id="example" class="display" width="100%">
  <thead>
  <tr>
    <th>Test ID</th>
    <th>Start Time</th>
    <th>End Time</th>
    <th>Case Name</th>
    <th>Result</th>
    <th>Execution Node</th>
    <th>Error Message</th>
    <th>Test Class ID</th>
    <th>Browser</th>
    <th>Class Name</th>
    <th>Test Run</th>
  </tr>
  </thead>
</table>

