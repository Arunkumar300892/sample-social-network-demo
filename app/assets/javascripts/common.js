// initilization
$(document).on('turbolinks:load', function() {

  // Handle flash messages
  var $notice = $('.notice'),
      $alert = $('.alert');

  if ($notice.length > 0) {
    M.toast({ html: $notice[0].innerHTML, classes	: 'green' });
  }

  if ($alert.length > 0) {
    M.toast({ html: $alert[0].innerHTML, classes: 'red lighten-2' });
  }

  // To hide default model validation error messages on the field
  if ($('span.hide').length > 0){
    $('span.hide').hide();
  }

  var $errors = $('#error_explanation');
  var $errorUl = $errors.find('ul li');
  if ($errors.length) {
    $errors.find('h2').hide();
    $errorUl.each(function(i){
      var text = $(this).text();
      $(this).hide();
      $('.field_with_errors').find('input').addClass('invalid').show();
      M.toast({ html: text, classes: 'red lighten-2' });
    })
  }

  // Auto-intializes material components
  M.AutoInit();

  // init materialize fields
  M.updateTextFields();

  // init materialize navbar
  $(".sidenav").sidenav();

});
