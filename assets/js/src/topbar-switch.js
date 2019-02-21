/* Hide Header on on scroll down */
$(function() {

  var didScroll;
  var lastScrollTop = 0;
  var delta = 5;
  var topbarHeight = $('#topbar').outerHeight();

  $(window).scroll(function(event) {
    didScroll = true;
  });

  setInterval(function() {
    if (didScroll) {
      hasScrolled();
      didScroll = false;
    }
  }, 250);

  function hasScrolled() {
    var st = $(this).scrollTop();

    // Make sure they scroll more than delta
    if (Math.abs(lastScrollTop - st) <= delta)
      return;

    if (st > lastScrollTop && st > topbarHeight) {
      // Scroll Down
      $('#topbar').removeClass('topbar-down').addClass('topbar-up');
      if ( $('#toc').length > 0) {
        $('#toc').removeClass('topbar-down');
      }
      if ( $('.panel-group').length > 0) {
        $('.panel-group').removeClass('topbar-down');
      }

    } else {
      // Scroll Up
      if (st + $(window).height() < $(document).height()) {
        $('#topbar').removeClass('topbar-up').addClass('topbar-down');
        if ( $('#toc').length > 0) {
          $('#toc').addClass('topbar-down');
        }
        if ( $('.panel-group').length > 0) {
          $('.panel-group').addClass('topbar-down');
        }
      }
    }

    lastScrollTop = st;
  }
});