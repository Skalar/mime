$(function() {
  if ($('#upload-image').length == 0) {
    return;
  }

  $('input:submit, a#upload-image').button();

  var uploader = new plupload.Uploader({
    runtimes: 'html5,html4',
    browse_button: 'upload-image',
    container: 'upload-container',
    max_file_size: '10mb',
    multi_selection: false,
    multipart_params: {
      authenticity_token: $('meta[name="csrf-token"]').attr('content')
		},
    url: $('#upload-container').data('url'),
    filters: [
      {title: 'Bilder', extensions: 'jpg,jpeg,gif,png'}
    ],

    init: {

      FilesAdded: function(up, files) {
        uploader.start();
      },

      FileUploaded: function(up, file, response) {
        $('#edit_image').fadeOut('fast', function() {
          $(this).html(response.response);
          $(this).fadeIn('fast');
        });
      },

      Error: function(up, args) {
        log(args);
      }
    }
  });

  uploader.init();

});
