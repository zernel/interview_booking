import * as ActionCable from '@rails/actioncable'
import $ from 'jquery'
const consumer = ActionCable.createConsumer();

document.addEventListener("turbo:load", function() {
  if ($('[data-booking-channel]').length) {
    let id = $('[data-booking-channel]').data('booking-channel').id
    consumer.subscriptions.create({
      channel: "BookingChannel",
      id: id
    }, {
      connected() {
        console.log("Connected to the channel:", this);
      },
      disconnected() {
        console.log("Disconnected");
      },
      received(data) {
        console.log("Received some data:", data);
        if($('#'+ data.located_id).length) {
          $('#'+ data.located_id).replaceWith(data.content);
        }
      }
    });
  }

  if ($('[data-investor-channel]').length) {
    let id = $('[data-investor-channel]').data('investor-channel').id
    consumer.subscriptions.create({
      channel: "InvestorChannel",
      id: id
    }, {
      connected() {
        console.log("Connected to the channel:", this);
      },
      disconnected() {
        console.log("Disconnected");
      },
      received(data) {
        console.log("Received some data:", data);
        Turbo.visit(window.location.href);
      }
    });
  }

})
