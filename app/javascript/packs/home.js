$(document).ready(function(){
  $('.collapsible').collapsible();
  $('select').formSelect();

  $(".collapsible-header").on("click", function(){
    if ($(this).next().children().length == 0) {
      $.ajax('/event/' + $(this).data('event-id') + '/competitions.js?element_id=' + $(this).data('element-id'), {
        success: function(data, textStatus, jqXHR) {
          // console.log("success");
        },
        error: function() {
          // console.log("error");
        },
      });
    }
  });
});
