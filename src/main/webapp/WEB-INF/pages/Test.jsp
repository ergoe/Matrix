<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Eric
  Date: 2/12/16
  Time: 1:40 PM
  To change this template use File | Settings | File Templates.
--%>

<html>
<head>
  <meta content="text/html;charset=utf-8" http-equiv="Content-Type">
  <meta content="utf-8" http-equiv="encoding">
  <spring:url value="/resources/js/main.js" var="mainJs" />
  <spring:url value="/resources/js/jquery.sparkline.min.js" var="sparkline" />
  <spring:url value="/resources/css/mainStyle.css" var="mainCss" />

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>

  <script src="${mainJs}"></script>
  <script src="${sparkline}"></script>
  <link href="${mainCss}" rel="stylesheet" />

  <title>Spring MVC Test page</title>
</head>
<body>
  <jsp:include page="testNav.jsp">
    <jsp:param name="testNavbar" value="Hello"/>
  </jsp:include>

  <%--<div class = "container">--%>
    <%--<div class="item">--%>
      <%--<h2>${result1}</h2>--%>
    <%--</div>--%>
    <%--<div class="item">--%>
      <%--<h2>${result2}</h2>--%>
    <%--</div>--%>
    <%--<div class="item">--%>
      <%--<h2>${result2}</h2>--%>
    <%--</div>--%>
    <%--<div class="item">--%>
      <%--<h2>${result2}</h2>--%>
    <%--</div>--%>
  <%--</div>--%>
</body>
</html>
