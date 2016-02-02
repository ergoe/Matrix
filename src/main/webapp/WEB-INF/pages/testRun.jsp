<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta content="text/html;charset=utf-8" http-equiv="Content-Type">
  <meta content="utf-8" http-equiv="encoding">
  <title>
  </title>
  <spring:url value="/resources/js/main.js" var="mainJs" />
  <spring:url value="/resources/js/colResizable-1.5.min.js" var="colResizable" />
  <spring:url value="/resources/css/mainStyle.css" var="mainCss" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
  <script src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>

  <script src="${mainJs}"></script>

  <link href="${mainCss}" rel="stylesheet" />
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.10/css/jquery.dataTables.min.css">

  <script>


  </script>
</head>
<body>
<script>
  var testRunId = "";


  testRunId = $.urlParam('testRunId')
  $(document).ready(function() {

    $.getJSON("http://localhost:3000/testClass?testRunId=" + testRunId, function( dataSet ) {
      //console.log(dataSet);

      $('#example').dataTable( {
        // "columnDefs": [{
        //    "defaultContent": "-",
        //    "targets": "_all"
        // }],
        "data": dataSet,
        "aoColumnDefs": [
          {   "aTargets": [0],
              "mData": "id"

          }, {
            "aTargets": [1],
            "mData": "className"
          }, {
            "aTargets": [2],
            "mData": "classStartTime"
          }, {
            "aTargets": [3],
            "mData": "testRunId"
          }, {
            "aTargets": [4],
            "mData": "description"
          }
        ]
        //  "columns": [
        //      { "data": "id" },
        //      { "data": "startTime" },
        //      { "data": "environment" },
        //      { "data": "area" },
        //      { "data": "buildNum" },
        //      { "data": "executionHost" }
        //  ]
      });
    });
  });
</script>
<table id="example" class="display" width="100%">
  <thead>
  <tr>
    <th>ID</th>
    <th>Class Name</th>
    <th>Start Time</th>
    <th>Test Run ID</th>
    <th>Description</th>
  </tr>
  </thead>
  <tfoot>
  <tr>
    <th>ID</th>
    <th>Class Name</th>
    <th>Start Time</th>
    <th>Test Run ID</th>
    <th>Description</th>
  </tr>
  </tfoot>
</table>
