// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
require('jquery')

import 'materialize-css/dist/js/materialize'
import '../stylesheets/application'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

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
