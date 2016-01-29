/**
 * Created by Eric on 1/27/16.
 */
function getBaseUrl() {
    var re = new RegExp(/^.*\//);
    return re.exec(window.location.href);
}