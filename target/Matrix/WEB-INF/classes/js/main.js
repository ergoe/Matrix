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

//			var month = date.getMonth();
//			var day = date.getDay();
//			var year = date.getFullYear();
    var dateString = date.toDateString();
    var time = date.toLocaleTimeString();
    return dateString.slice(3) + ' ' + time;
}

