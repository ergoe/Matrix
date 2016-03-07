<%--
  Created by IntelliJ IDEA.
  User: Eric
  Date: 3/3/16
  Time: 2:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<div class="bar">--%>
    <%--<div class="bar-items">--%>
        <%--<span>--%>
            <%--Environment: <input type="text" placeholder="(qa1, qa2 etc...)"><input onclick="getBuildNum();" id="goButton" type="button" name="go" value="GO!" />--%>
        <%--</span>--%>
    <%--</div>--%>
    <%--<div class="bar-items">--%>
        <%--<span>--%>
            <%--Host: <input type="text" placeholder="Enter Host.."><input onclick="getBuildNum();" id="goButto1" type="button" name="go" value="GO!" />--%>
        <%--</span>--%>
    <%--</div>--%>
    <%--<div class="bar-items">--%>
        <%--<span>--%>
            <%--Build: <input type="search" placeholder="Enter Build.."><input onclick="getBuildNum();" id="goButton2" type="button" name="go" value="GO!" />--%>
        <%--</span>--%>
    <%--</div>--%>
<%--</div>--%>

<%--<nav class="flexy-nav">--%>
    <%--<ul id="flexy-nav__items" class="flexy-nav__items">--%>
        <%--<li class="flexy-nav__items">--%>
            <%--<span>--%>
                <%--Environment: <input type="text" placeholder="(qa1, qa2 etc...)"><input onclick="getBuildNum();" id="goButton6" type="button" name="go" value="GO!" />--%>
            <%--</span>--%>
        <%--</li>--%>
        <%--<li class="flexy-nav__items">--%>
            <%--<span>--%>
                <%--Host: <input type="text" placeholder="Enter Host.."><input onclick="getBuildNum();" id="goButto3" type="button" name="go" value="GO!" />--%>
            <%--</span>--%>
        <%--</li>--%>
        <%--<li class="flexy-nav__items">--%>
            <%--<span>--%>
                <%--Build: <input type="search" placeholder="Enter Build.."><input onclick="getBuildNum();" id="goButton4" type="button" name="go" value="GO!" />--%>
            <%--</span>--%>
        <%--</li>--%>
    <%--</ul>--%>
<%--</nav>--%>

<%--<input id="txtBuildNum" class="userInput" type="text" placeholder="Enter Build Name"--%>
<%--onkeydown="if (event.keyCode == 13) document.getElementById('goButton').click()"/>--%>
<%--<input onclick="getBuildNum();" id="goButton" type="button" name="go" value="GO!" />--%>
<%--<input type="submit" name="go" value="GO!" />--%>

<nav class="flexy-nav">
    <ul id="flexy-nav__items1" class="flexy-nav__items">
        <li class="flexy-nav__items">
            <div class="InputAddOn">
                <span class="InputAddOn-item">Environment:</span>
                <input id="environmentInput" class="InputAddOn-field" type="text" onkeydown="if (event.keyCode == 13) document.getElementById('environmentGoButton').click()">
                <button id="environmentGoButton" class="InputAddOn-item" onclick="getEnvironment();">Go</button>
            </div>
        </li>
        <li class="flexy-nav__items">
            <div class="InputAddOn">
                <span class="InputAddOn-item">Host:</span>
                <input id="hostInput" class="InputAddOn-field" type="text" onkeydown="if (event.keyCode == 13) document.getElementById('hostGoButton').click()">
                <button id="hostGoButton" class="InputAddOn-item" onclick="getHostMachine();">Go</button>
            </div>
        </li>
        <li class="flexy-nav__items">
            <div class="InputAddOn">
                <span class="InputAddOn-item">Build:</span>
                <input id="buildInput" class="InputAddOn-field" type="text" onkeydown="if (event.keyCode == 13) document.getElementById('buildGoButton').click()">
                <button id="buildGoButton" class="InputAddOn-item" onclick="getBuildNum();">Go</button>
            </div>
        </li>
    </ul>
</nav>

