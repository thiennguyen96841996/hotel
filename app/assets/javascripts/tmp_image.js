$(document).on("turbolinks:load", function() {
  $(function() {
    $('#user_picture').on('change', function(event) {
      var files = event.target.files;
      var image = files[0]
      var reader = new FileReader();
      reader.onload = function(file) {
        var img = new Image();
        img.height = 300;
        img.width = 300;
        img.src = file.target.result;
        $('#target').html(img);
      }
      reader.readAsDataURL(image);
    });

    $(".upload-image").on("change", function(){
      var preview = document.querySelector('#preview');
      preview.innerHTML = "";
      var files   = document.querySelector('input[type=file]').files;

      function readAndPreview(file) {

        if ( /\.(jpe?g|png|gif)$/i.test(file.name) ) {
          var reader = new FileReader();

          reader.addEventListener("load", function () {
            var image = new Image();
            image.height = 100;
            image.width = 100;
            image.title = file.name;
            image.src = this.result;
            preview.appendChild( image );
          }, false);

          reader.readAsDataURL(file);
        }

      }

      if (files) {
        [].forEach.call(files, readAndPreview);
      }
    });
  });
});

