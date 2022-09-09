// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import jquery from 'jquery'
import "@hotwired/turbo-rails"
import 'bootstrap'
import "controllers"
import "./channels"

window.$ = jquery

// fontawesome
import {far} from "@fortawesome/free-regular-svg-icons"
import {fas} from "@fortawesome/free-solid-svg-icons"
import {fab} from "@fortawesome/free-brands-svg-icons"
import {library} from "@fortawesome/fontawesome-svg-core"
import "@fortawesome/fontawesome-free"
library.add(far, fas, fab)


document.addEventListener("turbo:load", function() {
  // bind change event to select
  $('#page-filter').on('change', function () {
    var baseURL = $(this).data('base-url');
    var paramsName = $(this).data('params-name');
    var selectedVal = $(this).val();
    if (selectedVal) { // require a URL
      window.location = baseURL + "?" + paramsName + "=" + selectedVal;
    }
    return false;
  });
});
