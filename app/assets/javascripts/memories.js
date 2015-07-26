window.Memories = {
	activeMarker: null,

	infoWindows: [],

	closeInfoWindows: function() {
		this.infoWindows.forEach(function(infoWindow) {
			infoWindow.close();
		});
	},

	init: function(lat, lng, memories) {
		this.lat = lat;
		this.lng = lng;
		this.memories = memories;
		this.loadMap();
	},

	loadMap: function() {
		var map = new google.maps.Map($("#map").get(0), {
			center: new google.maps.LatLng(this.lat, this.lng),
			zoom: 16,
			mapTypeId: google.maps.MapTypeId.HYBRID,
			disableDoubleClickZoom: true
		});

		google.maps.event.addListener(map, "dblclick", function(event) {
			var latLng = event.latLng;
			
			window.Memories.closeInfoWindows();
			window.Memories.activeMarker = new google.maps.Marker({
				position: latLng,
				animation: google.maps.Animation.BOUNCE,
				map: map
			});

			$("#story_lat").val(latLng.A);
			$("#story_lng").val(latLng.F);
			$("#new-story").modal();

			$("#story_photo_proxies_").change(function() {
				$("#fileinput-list").html("").parent().toggle(this.files.length);
				$.each(this.files, function(index, file) {
					$("#fileinput-list").append($("<li />").html(file.name));
				});
			});
		});

		$("#new-story").on("hidden.bs.modal", function(event) {
			window.Memories.activeMarker.setMap(null);
			$("#errors").html("");
			$("#new_story").get(0).reset();
			$.rails.enableFormElement($("#submit-story"));
		});

		this.memories.forEach(function(memory) {
			window.Memories.loadMarker(map, memory.lat, memory.lng, memory.body, memory.storyId);
		});
	},

	loadMarker: function(map, lat, lng, body, storyId) {
		var marker = new google.maps.Marker({
			map: map,
			position: new google.maps.LatLng(lat, lng)
		});
		var infoWindow = new google.maps.InfoWindow({
			content: body + "<br /><br /><a href='/stories/" + storyId + "'>Read more...</a>"
		});
		this.infoWindows.push(infoWindow);
		google.maps.event.addListener(marker, "click", function(event) {
			window.Memories.closeInfoWindows();
			infoWindow.open(map, marker);
		});
	},

	loadMinimap: function(elementId, lat, lng) {
		var latLng = new google.maps.LatLng(lat, lng);
		var map = new google.maps.Map($("#" + elementId).get(0), {
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
	}
};
