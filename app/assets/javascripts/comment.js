var Comment = (function () {

  var init = function () {
    
    // To toggle comment-form
    $('.comment-form').hide();

    $('.commentForm-toggler').click(function () {
      postId = $(this).data("postid");
      $('#' + postId + '-comment-form').toggle();
    });

    // To toggle comments section
    $('.comments-section').hide();

    $('.comments-toggler').click(function () {
      postId = $(this).data("postid");
      $('#' + postId + '-comments').toggle();
    });

    // comment validation
    $('#new_comment').submit(function(){
      element = $("#comment_content")
      if (element.val() == ''){
        element.addClass('invalid');
        M.toast({ html: 'Write Something to Post!', classes: 'red lighten-2' });
        return false;
      }
    })
  }

  return {
    init: init
  }
})();
