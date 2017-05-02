var MapManager = {
  activeMarker: null,
  infoWindows: [],

  closeInfoWindows: function () {
    this.infoWindows.forEach(function (infoWindow) {
      infoWindow.close();
    });
  },

  init: function (lat, lng, stories) {
    this.lat = lat;
    this.lng = lng;
    this.stories = stories;
    this.loadMap();
  },

  loadMap: function () {
    this.map = new google.maps.Map($('#map').get(0), {
      center: new google.maps.LatLng(this.lat, this.lng),
      zoom: 16,
      mapTypeId: google.maps.MapTypeId.HYBRID,
      disableDoubleClickZoom: true
    });

    google.maps.event.addListener(this.map, 'dblclick', function (event) {
      var latLng = event.latLng;
      this.closeInfoWindows();
      this.activeMarker = new google.maps.Marker({
        position: latLng,
        animation: google.maps.Animation.BOUNCE,
        map: this.map
      });

      $('#story_lat').val(latLng.lat());
      $('#story_lng').val(latLng.lng());
      $('#new-story').modal();

      $('#story_photo_proxies_').change(function () {
        $('#fileinput-list').html('').parent().toggle(this.files.length);
        $.each(this.files, function (index, file) {
          $('#fileinput-list').append($('<li />').html(file.name));
        });
      });
    }.bind(this));

    $('#new-story').on('hidden.bs.modal', function (event) {
      this.activeMarker.setMap(null);
      $('#errors, #fileinput-list').html('');
      $('#new_story').get(0).reset();
      $.rails.enableFormElement($('#submit-story'));
    }.bind(this));

    this.stories.forEach(function (story) {
      this.loadMarker(story.lat, story.lng, story.body, story.storyId);
    }.bind(this));
  },

  loadMarker: function (lat, lng, body, storyId) {
    var marker = new google.maps.Marker({ map: this.map, position: new google.maps.LatLng(lat, lng) });
    var infoWindow = new google.maps.InfoWindow({
      content: body + "<br /><br /><a href='/stories/" + storyId + "'>Read more...</a>"
    });

    this.infoWindows.push(infoWindow);
    google.maps.event.addListener(marker, 'click', function (event) {
      this.closeInfoWindows();
      infoWindow.open(this.map, marker);
    }.bind(this));
  },

  loadMinimap: function (elementId, lat, lng) {
    var latLng = new google.maps.LatLng(lat, lng);
    var map = new google.maps.Map($('#' + elementId).get(0), {
      center: latLng,
      disableDefaultUI: true,
      disableDoubleClickZoom: true,
      draggable: false,
      mapTypeId: google.maps.MapTypeId.HYBRID,
      scrollwheel: false,
      zoom: 18,
      zoomControl: false
    });
    return new google.maps.Marker({ map: map, position: latLng });
  }
};
