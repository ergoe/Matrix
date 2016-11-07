/**
 * Created by Eric on 1/27/16.
 */
function getBaseUrl() {
    var re = new RegExp(/^.*\//);
    var currentUrl = re.exec(window.location.href);
    console.log("First: " + currentUrl.indexOf('Matrix'));
    console.log("Second: " + currentUrl.indexOf("Matrix"));
    if (currentUrl[0].indexOf("Matrix") === -1 ) {
        console.log("currentUrl: " + currentUrl[0]);
        currentUrl[0] = currentUrl[0] + "Matrix/";
    }
    //return re.exec(window.location.href);
    console.log("Final currentUrl: " + currentUrl);
    return currentUrl;
}

$.urlParam = function(name) {
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
    if (results == null) {
        return null;
    } else {
        return results[1] || 0;
    }
}

$(function() {
    var pull        = $('#pull');
    menu        = $('nav ul');
    menuHeight  = menu.height();

    $(pull).on('click', function(e) {
        e.preventDefault();
        menu.slideToggle();
    });
});

$(window).resize(function(){
    var w = $(window).width();
    if(w > 320 && menu.is(':hidden')) {
        menu.removeAttr('style');
    }
});

function getNormalDatetime( dateTimeString ) {
    var date = new Date( dateTimeString );
    var milliseconds = date.getUTCMilliseconds();

//			var month = date.getMonth();
//			var day = date.getDay();
//			var year = date.getFullYear();
    var options = { timeZone: 'UTC' };
    var dateString = date.toDateString();
    var time = date.toLocaleTimeString('en-US', options);
    return dateString.slice(3) + ' ' + time + ":" + milliseconds;
}

// http://stackoverflow.com/questions/5667888/counting-the-occurrences-of-javascript-array-elements
// https://gist.github.com/zykadelic/5069223#file-array-count-js
// Count the frequency of an element within an array, returns length if the argument is undefined
Array.prototype.count = function(obj) {
    var count = this.length;
    if(typeof(obj) !== "undefined") {
        var array = this.slice(0), count = 0;  //clone array and reset count
        for (i = 0; i < array.length; i++) {
            if (array[i] == obj) {
                count ++
            }
        }
    }
    return count;
}

function getBuildNum() {
    var buildNum = $('#buildInput').val();
    var queryParams = {};


    if ( buildNum ) {
        queryParams["build"] = buildNum;
        var link =  baseUrl + '?' + $.param(queryParams);
        console.log("Link: " + link);

        window.location.href = link;
    } else {
        window.location.href = baseUrl;
    }
}

function getHostMachine() {
    var hostMachine = $('#hostInput').val();
    var queryParams = {};


    if ( hostMachine ) {
        queryParams["host"] = hostMachine;
        var link =  baseUrl + '?' + $.param(queryParams);
        console.log("Link: " + link);

        window.location.href = link;
    } else {
        window.location.href = baseUrl;
    }
}

function getEnvironment() {
    var environment = $('#environmentInput').val();
    var queryParams = {};


    if ( environment ) {
        queryParams["env"] = environment;

        var link =  baseUrl + '?' + $.param(queryParams);
        console.log("Link: " + link);

        window.location.href = link;
    } else {
        window.location.href = baseUrl;
    }
}

function navigateHome() {
    var baseUrl = getBaseUrl().toString();
    var newBaseUrl = baseUrl.substring(0, baseUrl.indexOf('Matrix/') + 'Matrix/'.length);

    window.location = newBaseUrl;
}
// for counting objects in array
//var a = ["order", "credit card", "order", "iphone", "chrome"];
//
//var obj = { };
//for (var i = 0, j = a.length; i < j; i++) {
//    obj[a[i]] = (obj[a[i]] || 0) + 1;
//}
//
//console.log(obj);

// output: Object {order: 2, credit card: 1, iphone: 1, chrome: 1}

