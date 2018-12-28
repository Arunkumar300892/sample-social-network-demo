var UserValidation = (function(){

  var init = function () {
    var signup_fields = $('.signup__fields');
    var isEmpty = false;
    $('#new_user').submit(function(){
      signup_fields.each(function(i){
        var selector = $(signup_fields[i]);
        var element = selector.find('input');
        if (element.val() == '') {
          element.addClass('invalid');
          isEmpty = true;
        }
      })
      if(isEmpty == true) {
        isEmpty = false;
        return false;
      }
    });
  }

  return {
    init: init
  }
})();
