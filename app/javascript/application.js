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

import flatpickr from "flatpickr";
const initFlatpickr = () => {
  flatpickr("[data-date-picker]", {});
}

document.addEventListener("turbo:load", function() {
  initFlatpickr()

  // Refresh the investor calendar with selected date
  if($('[data-redirect-on-change]').length) {
    $('[data-redirect-on-change]').on('change', function() {
      var baseURL = $(this).data('redirect-on-change');
      var date = $(this).val();
      if (date) {
        window.location = baseURL + "?" + "date=" + date;
      }
      return false;
    })
  }
});
