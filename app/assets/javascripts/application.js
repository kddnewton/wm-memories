// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require action_cable
//= require social-share-button
//= require_self
//= require_tree .

App = {};
App.cable = ActionCable.createConsumer();

App.stories = App.cable.subscriptions.create('StoriesChannel', {
  received: function (data) {
    var story = data.story;
    var marker = Memories.loadMarker(story.lat, story.lng, story.body, story.id);

    marker.setAnimation(google.maps.Animation.BOUNCE);
    setTimeout(function() {
      marker.setAnimation(null);
    }, 2000);
  }
});
