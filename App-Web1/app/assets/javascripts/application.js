// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery
//= require popper
//= require bootstrap
//= require rails-ujs
//= require jquery.fancybox.min
//= require aos
//= require main
//= require activestorage
//= require turbolinks
//= require_tree .

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      $('.image-upload-wrap').hide();
      $('.file-upload-image').attr('src', e.target.result);
      $('.file-upload-content').show();
      $('.image-title').html(input.files[0].name);
    };
    reader.readAsDataURL(input.files[0]);
  } else {
    removeUpload();
  }
}

function removeUpload() {
  $('.file-upload-input').replaceWith($('.file-upload-input').clone());
  $('.file-upload-content').hide();
  $('.image-upload-wrap').show();
}
$('.image-upload-wrap').bind('dragover', function () {
    $('.image-upload-wrap').addClass('image-dropping');
  });
  $('.image-upload-wrap').bind('dragleave', function () {
    $('.image-upload-wrap').removeClass('image-dropping');
});
 function myFunction(x) {
  x.classList.toggle("fa-thumbs-down");
}



$(document).on('turbolinks:load', function() {
  var $imageSrc;
  var $idimg;
  $('.site-wrap').on("click", ".gallery img", function() {
    $imageSrc = $(this).data('bigimage');
    $idimg = $(this).data('id');

});
// when the modal is opened autoplay it

$(document).on('click', '.image', function(){
    id = $(this).attr('data-id')

    $.ajax({
      url : `/photos/${id}/get_photo`,
      type : "GET"
  });
})

$(document).on('shown.bs.modal', '#my-modal', function (e) {
  $("#image").attr('src', $imageSrc  );
  $("#image").attr('data-id', $idimg  );



})
// reset the modal image
$(document).on('hide.bs.modal', '#my-modal', function (e) {
    // a poor man's stop video
    $("#image").attr('src','');
})

// document ready
  $('.modal').on('click', '.fa-thumbs-up', function(){
      idlike = $('.modal img').attr('data-id')
      $.ajax({
          url : `/photos/${idlike}/likes`,
          type : "POST"
      });
    });
  $('.modal').on('click', '.fa-thumbs-down', function(){
      idunlike = $('.modal img').attr('data-id')
      $.ajax({
          url : `/photos/${idunlike}/unlike`,
          type : "DELETE"
      });
    });
});



