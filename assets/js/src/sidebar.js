/*
  Exapand or hide sidebar in small screens.
*/
$(function(){

  var isExpanded = false;

  $("#sidebar-trigger").click(function() {

    if (isExpanded == false) {
      $("#sidebar").addClass("sidebar-expand");
      $("#main-wrap").addClass("main-wrap-expand");
      openModal();

      isExpanded = true;
    }
  });

  $("#mask").click(function() {
    $("#sidebar").removeClass("sidebar-expand");
    $("#main-wrap").removeClass("main-wrap-expand");
    closeModal();

    isExpanded = false;
  });

  /**
  * ModalHelper helpers resolve the modal scrolling issue on mobile devices
  * https://github.com/twbs/bootstrap/issues/15852
  * requires document.scrollingElement polyfill https://github.com/yangg/scrolling-element
  */
  var ModalHelper = (function(bodyCls) {
    var scrollTop;
    return {
      afterOpen: function() {
        scrollTop = document.scrollingElement.scrollTop;
        document.body.classList.add(bodyCls);
        document.body.style.top = -scrollTop + 'px';
      },
      beforeClose: function() {
        document.body.classList.remove(bodyCls);
        // scrollTop lost after set position:fixed, restore it back.
        document.scrollingElement.scrollTop = scrollTop;
        document.body.style.top = '';
      }
    };
  })('no-scroll');

  function openModal() {
    $("#mask").show();
    ModalHelper.afterOpen();
  }

  function closeModal() {
    ModalHelper.beforeClose();
    $('#mask').hide();
  }

});