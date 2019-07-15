/*
*  Topbar title effect in mobile screens.
*/
$(function(){

  var DEFAULT = $("#topbar-title").text().trim();
  var title = $("h1").text().trim();

  if ($("#page-category").length || $("#page-tag").length) {
    /* The title in Category or Tag page will be '$(title) $(count_of_posts)' */
    if (/\s/.test(title)) {
      title = title.split(' ')[0];
    }
  }

  // Replace topbar title while scroll screens.
  $(window).scroll(function () {
    if ($("#post-list").length // in Home page
      || $("div.post>h1").is(":hidden") // is tab pages
      || $("#topbar-title").is(":hidden") // not mobile screens
      || $("#sidebar.sidebar-expand").length) { // when the sidebar trigger is clicked
      return false;
    }

    if ($(this).scrollTop() >= 95) {
      if ($("#topbar-title").text() != title) {
        $("#topbar-title").text(title);
      }
    } else {
      if ($("#topbar-title").text() != DEFAULT) {
        $("#topbar-title").text(DEFAULT);
      }
    }
  })
});