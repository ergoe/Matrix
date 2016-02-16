/**
 * Created by Eric on 1/27/16.
 */
function getBaseUrl() {
    var re = new RegExp(/^.*\//);
    return re.exec(window.location.href);
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

