window.PopupImages = {
	buildModal: function(imageSrc) {
		return $("<div />", { "class": "modal fade" }).html(
			"<div class='modal-dialog'>" +
				"<div class='modal-content modal-image'>" +
					"<img class='center-block' src='" + imageSrc + "' />" +
				"</div>" +
			"</div>"
		);
	},

	showModal: function(anchor) {
		this.buildModal(anchor.data("url")).modal("show");
	}
};

$(document).ready(function() {
	$("a[data-display=popup]").click(function(event) {
		window.PopupImages.showModal($(this));
		event.preventDefault();
	});
});
