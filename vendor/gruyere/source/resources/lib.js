/* Copyright 2010 Google Inc. */
/**
 * Swaps the display settings of two elements. Before calling, exactly one
 * of the two elements should have style="display:none" and it shows the one
 * that is hidden and hides the one that is shown.
 */
function _showHide(id1, id2) {
  var x1 = document.getElementById(id1);
  var x2 = document.getElementById(id2);
  var shown = x1.style.display != '';
  x1.style.display = shown ? '' : 'none';
  x2.style.display = shown ? 'none' : '';
};

/**
 * Refreshes the current page by loading the url and then passing the
 * json response object to the callback.
 */
function _refresh(url, callback) {
  var httpRequest = window.XMLHttpRequest ? new XMLHttpRequest()
      : new ActiveXObject("Microsoft.XMLHTTP");
  httpRequest.onreadystatechange = function() {
    if (httpRequest.readyState == 4) {
      _feed = callback;
      eval('(' + httpRequest.responseText + ')');
      httpRequest = null;
    }
  }
  httpRequest.open("GET", url, true);
  httpRequest.send(null);
};

/**
 * Processes refresh response {'private_snippet':snippet, user:snippet, ...}
 */
function _finishRefreshHome(response) {
  for (var uid in response) {
    var element = document.getElementById(uid);
    if (element) {
      element.innerHTML = response[uid];
    }
  }
};

function _refreshHome(uniqueId) {
  _refresh("/" + uniqueId + "/feed.gtl", _finishRefreshHome);
};

/**
 * Processes refresh response [name, snippet, ...]
 */
function _finishRefreshSnippets(response) {
  var n = response.length;
  var element = document.getElementById('user_name');
  if (n && element) {
    element.innerHTML = response[0];
  }

  // The snippet divs are numbered 0, 1, ...
  for (var i = 1; i < n; ++i) {
    var element = document.getElementById(i - 1);
    if (element) {
      element.innerHTML = response[i];
    }
  }
};

function _refreshSnippets(uniqueId, uid) {
  _refresh("/" + uniqueId + "/feed.gtl?uid=" + uid, _finishRefreshSnippets);
};
