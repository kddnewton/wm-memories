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
//= require_tree .

window.Memories = {};

window.Memories.loadMinimap = function(elementId, lat, lng) {
	$(document).ready(function() {
		var latLng = new google.maps.LatLng(lat, lng);
		var map = new google.maps.Map(document.getElementById(elementId), {
			center: latLng,
			disableDefaultUI: true,
			disableDoubleClickZoom: true,
			draggable: false,
			mapTypeId: google.maps.MapTypeId.HYBRID,
			scrollwheel: false,
			zoom: 18,
			zoomControl: false
		});
		new google.maps.Marker({ map: map, position: latLng });
	});
}
