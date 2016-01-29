<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta content="text/html;charset=utf-8" http-equiv="Content-Type">
	<meta content="utf-8" http-equiv="encoding">
	<spring:url value="/resources/js/main.js" var="mainJs" />
	<spring:url value="/resources/js/colResizable-1.5.min.js" var="colResizable" />
	<title>
	</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>
	<script src="${mainJs}"></script>
	<script src="${colResizable}"></script>

	<%--<script src="${pageContext.request.contextPath}/resources/ja/main.js"></script>--%>


	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.10/css/jquery.dataTables.min.css">

	<script>


	</script>
</head>
<body>
<script>
	var data1 = $
	var baseUrl = getBaseUrl();

	console.log("Base Url: " + baseUrl);

	$(document).ready(function() {

		$.getJSON("http://localhost:3000/", function( dataSet ) {
			data1 = dataSet;
			dataReady();
		});
	});

	function dataReady() {
			$('#example').dataTable( {
				"data": data1,
				"aoColumnDefs": [
					{   "aTargets": [0],
						"mData": function ( source, type, val ) {
							var testRunId = source.id;
							// For IDE debugging
							var link = '<a href=' + baseUrl + 'TestResults?testRunId=' + testRunId +'>' + testRunId + '</a>';
							// When deployed
							//var link = '<a href=' + baseUrl + 'Matrix' + '/TestResults?testRunId=' + testRunId +'>' + testRunId + '</a>';
							return link;
						}
					}, {
						"aTargets": [1],
						"mData": "startTime"
					}, {
						"aTargets": [2],
						"mData": "environment"
					}, {
						"aTargets": [3],
						"mData": "area"
					}, {
						"aTargets": [4],
						"mData": "buildNum"
					}, {
						"aTargets": [5],
						"mData": "executionHost"
					}
				]

			});

		$("#example").colResizable( {
			liveDrag: true
		});
	}


</script>
<table id="example" class="display" width="100%">
	<thead>
	<tr>
		<th>ID</th>
		<th>Start Time</th>
		<th>Environment</th>
		<th>Area</th>
		<th>Build Name</th>
		<th>Execution Host</th>
	</tr>
	</thead>
	<tfoot>
	<tr>
		<th>ID</th>
		<th>Start Time</th>
		<th>Environment</th>
		<th>Area</th>
		<th>Build Name</th>
		<th>Execution Host</th>
	</tr>
	</tfoot>
</table>


</body>

</html>