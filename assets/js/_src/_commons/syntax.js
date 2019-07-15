/**
* Add pandding effect to code snippet.
*/
$(function(){
  $(".highlight>pre>code").each(function(){
    if ($(this).has("table").length == 0) {
      $(this).parent().addClass("code-padding");
    }
  });
});
