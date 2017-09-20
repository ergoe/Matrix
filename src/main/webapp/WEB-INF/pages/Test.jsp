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

  <script>

    $('.screenShotLink').on("click",function(){
      window.open(url, '_self')
    });

    $(document).ready(function(){
      $('img').click(function (event) {
        window.open($(this).attr("src"));
//        var id = $(this).attr("id");
//        alert(id);
      });
    });
  </script>

  <title>Spring MVC Test page</title>
</head>
<body>
<jsp:include page="homeNavigation.jsp">
  <jsp:param name="testHomeButton" value="Hello"/>
</jsp:include>

  <div class="chip">
    John Doe
    <span class="closebtn" onclick="this.parrentElement.style.display='none'">x</span>
  </div>
  <div class="chip">
    Credit Card
    <span class="closebtn" onclick="this.parrentElement.style.display='none'">x</span>
  </div>
  <jsp:include page="testNav.jsp">
    <jsp:param name="testNavbar" value="Hello"/>
  </jsp:include>

  <div>
    <a class="screenShotLink" href="https://s3-us-west-2.amazonaws.com/bbcom-automation-screenshots/1208/48045/1505496283933.png">Image</a>

    <a href="#" id="this is a test">
      <img src="https://s3-us-west-2.amazonaws.com/bbcom-automation-screenshots/1208/48045/1505496283933.png" id="imageId" alt="image" style="width:200px"></a>
  </div>

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
