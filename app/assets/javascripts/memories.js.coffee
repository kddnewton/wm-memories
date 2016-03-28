window.Memories =

	activeMarker: null

	infoWindows: []

	closeInfoWindows: ->
		@infoWindows.forEach (infoWindow) -> infoWindow.close()

	init: (@lat, @lng, @memories) -> @loadMap()

	loadMap: ->
		@map = new (google.maps.Map)($('#map').get(0),
			center: new (google.maps.LatLng)(@lat, @lng)
			zoom: 16
			mapTypeId: google.maps.MapTypeId.HYBRID
			disableDoubleClickZoom: true)

		google.maps.event.addListener @map, 'dblclick', (event) ->
			latLng = event.latLng
			window.Memories.closeInfoWindows()
			window.Memories.activeMarker = new google.maps.Marker(
				position: latLng
				animation: google.maps.Animation.BOUNCE
				map: @map)

			$('#story_lat').val latLng.lat()
			$('#story_lng').val latLng.lng()
			$('#new-story').modal()
			$('#story_photo_proxies_').change ->
				$('#fileinput-list').html('').parent().toggle @files.length
				$.each @files, (index, file) ->
					$('#fileinput-list').append $('<li />').html(file.name)

		$('#new-story').on 'hidden.bs.modal', (event) ->
			window.Memories.activeMarker.setMap null
			$('#errors, #fileinput-list').html ''
			$('#new_story').get(0).reset()
			$.rails.enableFormElement $('#submit-story')

		@memories.forEach (memory) =>
			@loadMarker(memory.lat, memory.lng, memory.body, memory.storyId)

	loadMarker: (lat, lng, body, storyId) ->
		marker = new google.maps.Marker(map: @map, position: new google.maps.LatLng(lat, lng))
		infoWindow = new google.maps.InfoWindow(content: body + "<br /><br /><a href='/stories/#{storyId}'>Read more...</a>")
		@infoWindows.push(infoWindow)
		google.maps.event.addListener marker, 'click', (event) =>
			@closeInfoWindows()
			infoWindow.open(@map, marker)
		marker

	loadMinimap: (elementId, lat, lng) ->
		latLng = new google.maps.LatLng(lat, lng)
		map = new google.maps.Map($('#' + elementId).get(0),
			center: latLng
			disableDefaultUI: true
			disableDoubleClickZoom: true
			draggable: false
			mapTypeId: google.maps.MapTypeId.HYBRID
			scrollwheel: false
			zoom: 18
			zoomControl: false)
		new google.maps.Marker(map: map, position: latLng)
