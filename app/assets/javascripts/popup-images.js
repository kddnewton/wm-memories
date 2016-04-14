$(document).on('ready page:load', function () {
  $('a[data-display=popup]').click(function (event) {
    $('<div />', { 'class': 'modal fade' })
      .html("<div class='modal-dialog'>" +
            "<div class='modal-content modal-image'>" +
            "<img class='center-block' src='" + $(this).data('url') + "' /></div></div>")
      .modal('show');

    event.preventDefault();
  });
});
