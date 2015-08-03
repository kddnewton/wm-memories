window.PopupImages =

	buildModal: (imageSrc) ->
		$('<div />', 'class': 'modal fade').html "<div class='modal-dialog'><div class='modal-content modal-image'><img class='center-block' src='#{imageSrc}' /></div></div>"

	showModal: (anchor) ->
		@buildModal(anchor.data('url')).modal 'show'

$(document).ready ->
	$('a[data-display=popup]').click (event) ->
		window.PopupImages.showModal $(@)
		event.preventDefault()
