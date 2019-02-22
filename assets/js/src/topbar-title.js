/*
* Replace topbar title while scroll screens.
*/
$(function(){

  var DEFAULT = $("#topbar-title").text().trim();
  var title = $("h1").text().trim();

  if ($("#category-page").length || $("#tag-page").length) {
    /* The title in Category or Tag page will be '$(title) $(count_of_posts)' */
    if (/\s/.test(title)) {
      title = title.split(' ')[0];
    }
  }

  var isHome = $("#post-list").length? true : false;

  $(window).scroll(function (){
    if (isHome || $("div.post>h1").is(":hidden")) {
      return false;
    }

    if ($(this).scrollTop() >= 95) {
      $("#topbar-title").text(title);
    } else {
      $("#topbar-title").text(DEFAULT);
    }

  })
});