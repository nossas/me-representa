var Questions = {
  self: this,
  initialize: function(){
    $('.chosen-select').chosen({
      no_results_text: "Nenhum assunto encontrado com "
    });

    $('.form textarea').live('focus', function(){
      var klass = $(this).attr('data-form-type');
      var hiddens = $('.' + klass + ' .hidden');
      $('.' + klass + ' textarea').animate({ height: "200px" })
      hiddens.slideDown("fast");
    });

    $('button.reset').click(function(){
      var klass = $(this).attr('data-form-type');
      var hiddens = $('.' + klass + ' .hidden');
      $('.' + klass + ' textarea').animate({ height: "60px" });
      hiddens.slideUp("fast");
    });

    if ( $('.message').text() !== '' ){
      $('.message').slideDown('fast');
      window.setTimeout("$('.message').slideUp()", 4000);
    }

    $('form').bind('ajax:error', function(evt, xhr, settings){
      var response = $.parseJSON(xhr.responseText);
      var errors = response.errors;
      $('*', $(this)).removeClass('error_field');
      $('.error_message', $(this)).remove();
      for (name in errors) {
        var field = $('*[name="question['+name+']"]', $(this));
        field.addClass('error_field');
        field.after('<span class="error_message">'+errors[name][0]+'</span>');
      }
    });
  },
};

Questions.initialize();
