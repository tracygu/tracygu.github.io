/**
* Count pageviews form GA or local cache file.
*
* Dependences:
*   - jQuery
*   - countUp.js(https://github.com/inorganik/countUp.js)
*/

function countUp(min, max, dest) {
  if (min < max) {
    var numAnim = new CountUp(dest, min, max);
    if (!numAnim.error) {
      numAnim.start();
    } else {
      console.error(numAnim.error);
    }
  }
}

function countPV(path, rows) {
  /* path permalink looks like: '/posts/post-title/' */
  var fileName = path.replace(/\/posts\//g, '').replace(/\//g, '.html'); /* e.g. post-title.html */
  var count = 0;

  var _2_gen_url = path.replace(/posts\//g, ''); /* permalink: "/post-title/" */

  for (var i = 0; i < rows.length; ++i) {
    var gaPath = rows[i][0];
    if (gaPath == path
        || gaPath == _2_gen_url
        || gaPath.concat('/') == _2_gen_url
        || gaPath.slice(gaPath.lastIndexOf('/') + 1) === fileName) {// old permalink record
      count += parseInt(rows[i][1]);
    }
  }

  return count;
}

function displayPageviews(rows, hasInit) {
  if (rows === undefined) {
      return;
  }

  if ($("#post-list").length > 0) { // the Home page
    $(".post-preview").each(function() {
      var path = $(this).children("h1").children("a").attr("href");
      var count = countPV(path, rows);

      if (!hasInit) {
        $(this).find('.pageviews').text(count);
      } else {
        var initPV = parseInt($(this).find('.pageviews').text() );
        countUp(initPV, count, $(this).find('.pageviews').attr('id') );
      }
    });

  } else if ($(".post").length > 0) { // the single post
    var path = window.location.pathname;
    var count = countPV(path, rows);

    if (!hasInit) {
      $('#pv').text(count);
    } else {
      var initPV = parseInt($('#pv').text());
      countUp(initPV, count, 'pv');
    }
  }

}

$(function() {
  if ($('.pageviews').length > 0) {
    // load pageview if this page has .pageviews

    var hasInit = false;

    // Get data from daily cache.
    $.getJSON('/norobots/pageviews.json', function(data){
      displayPageviews(data.rows, hasInit);
      hasInit = true;
    });

    $.ajax({
      url: 'https://your-gae.appspot.com/query?id=the_secrt_id',
      dataType: 'jsonp', // for cross-origin access

      timeout: 1000 * 3,

      success: function(data) {
        displayPageviews(data.rows, hasInit);
      },
      error: function() {
        console.log('Failed to get pageviews from GAE');
      }
    });
  }
});
