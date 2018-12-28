var Post = (function () {

  var init = function () {
    $('#postForm').submit(function () {
      element = $('#post_picture');
      var size_in_megabytes = element[0].files[0].size / 1024 / 1024;
      if (size_in_megabytes > 5) {
        errorText = 'Maximum size allowed is 5MB !'
        M.toast({ html: errorText, classes: 'red lighten-2' });
        return false;
      }
      else {
        M.toast({ html: 'Successfully Posted !', classes: 'green ' });
        return true
      }
    });
  }

  return {
    init: init
  }
})();
