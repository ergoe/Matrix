<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta content="text/html;charset=utf-8" http-equiv="Content-Type">
	<meta content="utf-8" http-equiv="encoding">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

	<spring:url value="/resources/js/main.js" var="mainJs" />
	<spring:url value="/resources/js/colResizable-1.5.min.js" var="colResizable" />
	<spring:url value="/resources/css/mainStyle.css" var="mainCss" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>
	<script src="${mainJs}"></script>
	<script src="${colResizable}"></script>

	<link href="${mainCss}" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.10/css/jquery.dataTables.min.css">

	<title>	</title>
</head>

<body>
	<script>
		var data1;
		var baseUrl = getBaseUrl();
		var environment;
		var host;
		var buildName;
		var queryString = {};

		environment = $.urlParam('env');
		host = $.urlParam('host');
		buildName = $.urlParam('build');

		if (environment) {
			queryString["env"] = environment;
		}

		if (host) {
			queryString["host"] = host;
		}

		if (buildName) {
			queryString["build"] = buildName;
		}

		$(document).ready(function() {

			$.getJSON("http://eric-OptiPlex-980:3000?" + $.param(queryString), function( dataSet ) {
				data1 = dataSet;
				dataReady();
			});

			$('.slide-trigger').collapsable();
		});

		function dataReady() {
				$('#example').dataTable( {
					"data": data1,
					"order" : [[ 0, "desc"]],
					"aoColumnDefs": [
						{   "aTargets": [0],
							"mData": function ( source, type, val ) {
								var testRunId = source.id;
								var link = '<a href=' + baseUrl + 'TestResults/' + testRunId +'>' + testRunId + '</a>';

								return  '<div class="colTestRunId">' + link + '</div>';
							}
						}, {
							"aTargets": [1],
							"mData": function ( source, type, val ) {
								var startTime = getNormalDatetime(source.startTime);
								return '<div class="startTime">' + startTime + '</div>';
							}
							//"mData": "startTime"
						}, {
							"aTargets": [2],
							"mData": function ( source, type, val ) {
								var environment = source.environment;
								return '<div class="colEnvironment">' + environment + '</div>';
							}
							//"mData": "environment"
						}, {
							"aTargets": [3],
							"mData": function ( source, type, val ) {
								var area = source.area;
								return '<div class="colArea">' + area + '</div>';
							}
							//"mData": "area"
						}, {
							"aTargets": [4],
							"mData": function ( source, type, val ) {
								var buildNum = source.buildNum.replace('COMMERCE', '');

								return '<div class="colBuildName">' + buildNum + '</div>';
							}
							//"mData": "buildNum"
						}, {
							"aTargets": [5],
							"mData": function ( source, type, val ) {
								var executionHost = source.executionHost;
								return '<div class="colExecutionHost">' + executionHost + '</div>';
							}
							//"mData": "executionHost"
						}
					]

				});

			$("#example").colResizable( {
				liveDrag: true
			});
		}  // end of function dataReady()

		function getBuildNum() {
			var buildNum = $('#txtBuildNum').val();
			var queryParams = {};


			if ( buildNum ) {
				queryParams["build"] = buildNum;
				var link =  baseUrl + '?' + $.param(queryParams);
				console.log("Link: " + link);

				window.location.href = link;
			}
		}



	</script>

	<div id="navbar">
		<nav class="clearfix">
			<ul class="clearfix">
				<li>
					<div class="buildBox">
						<div class="wrapper">
							<%--<form action='nothing' method="get" name="getBuildForm">--%>
								<input id="txtBuildNum" class="userInput" type="text" placeholder="Enter Build Name"
									   onkeydown="if (event.keyCode == 13) document.getElementById('goButton').click()"/>
								<input onclick="getBuildNum();" id="goButton" type="button" name="go" value="GO!" />
								<%--<input type="submit" name="go" value="GO!" />--%>
							<%--</form>--%>
						</div>
					</div>
				</li>
				<li><a href="#">Environment</a></li>
				<li><a href="#">Build</a></li>
			</ul>
			<a href="#" id="pull">Menu</a>
		</nav>
	</div>
	<div>
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
		</table>
	</div>


</body>

</html>