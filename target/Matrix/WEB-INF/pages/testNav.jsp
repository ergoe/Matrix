<%--
  Created by IntelliJ IDEA.
  User: Eric
  Date: 3/3/16
  Time: 2:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

