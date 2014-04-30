function cfeDialog(url, newHref) {
    window.returnValue = undefined;
    var ret = window.showModalDialog(url, '', 'center:yes;resizable:yes;dialogwidth:800px;dialogheight:600px;');
    if (ret == undefined) {
        // see http://stackoverflow.com/questions/10213530/javascript-showmodaldialog-not-returning-value-in-chrome
        ret = window.returnValue;
    }
    if (ret == '') return false;
    if (newHref == null) {
        __doPostBack();
    }
    else {
        window.location.href = newHref + '&' + ret;
    }
    return ret;
}

function cfeTabClick(a, cid) {
    var match = a.id.match(/\d+/);
    var id = parseInt(match[0], 10);
    for (var child = 1; child < (a.parentNode.parentNode.children.length + 1); child++) {
        document.getElementById('tablink_' + child + '_' + cid).className = 'tablink';
        document.getElementById('tabcontent_' + child + '_' + cid).className = 'tabcontent';
    }
    document.getElementById('tablink_' + id + '_' + cid).className = 'tablinka';
    document.getElementById('tabcontent_' + id + '_' + cid).className = 'tabcontenta';
    return false;
}