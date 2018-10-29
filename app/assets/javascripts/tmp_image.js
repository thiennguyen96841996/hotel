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

    if ((current = $('#review_rate').val()) > 0) {
      var element = $(`#stars li[data-value="${current}"]`);
      var onStar = parseInt(element.data('value'), 10); // The star currently selected
    var stars = element.parent().children('li.star');

    for (i = 0; i < stars.length; i++) {
      $(stars[i]).removeClass('selected');
    }

    for (i = 0; i < onStar; i++) {
      $(stars[i]).addClass('selected');
    }

    // JUST RESPONSE (Not needed)
    var ratingValue = parseInt($('#stars li.selected').last().data('value'), 10);
    responseMessage(ratingValue);
    }

  });


  $('#stars li').on('mouseover', function(){
    var onStar = parseInt($(this).data('value'), 10); // The star currently mouse on

    // Now highlight all the stars that's not after the current hovered star
    $(this).parent().children('li.star').each(function(e){
      if (e < onStar) {
        $(this).addClass('hover');
      }
      else {
        $(this).removeClass('hover');
      }
    });

  }).on('mouseout', function(){
    $(this).parent().children('li.star').each(function(e){
      $(this).removeClass('hover');
    });
  });


  /* 2. Action to perform on click */
  $('#stars li').on('click', function(){
    var onStar = parseInt($(this).data('value'), 10); // The star currently selected
    var stars = $(this).parent().children('li.star');

    for (i = 0; i < stars.length; i++) {
      $(stars[i]).removeClass('selected');
    }

    for (i = 0; i < onStar; i++) {
      $(stars[i]).addClass('selected');
    }

    // JUST RESPONSE (Not needed)
    var ratingValue = parseInt($('#stars li.selected').last().data('value'), 10);
    responseMessage(ratingValue);
  });
});

function responseMessage(msg) {
  $('#review_rate').val(msg);
}
