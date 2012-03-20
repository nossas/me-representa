window.Questions = {
  self: this,

  isLoggedIn: function(){
    if ($('.logged').length()){
      return true;
    }
  },

  expandTextarea: function(obj){
    var klass = obj.attr('data-form-type');
    var hiddens = $('.' + klass + ' .hidden');
    $('.' + klass + ' textarea').animate({ height: "200px" })
    hiddens.slideDown("fast");
  },

  returnTextarea: function(obj){
    var klass = obj.attr('data-form-type');
    var hiddens = $('.' + klass + ' .hidden');
    $('.' + klass + ' textarea').animate({ height: "60px" });
    hiddens.slideUp("fast");
  },

  initialize: function(){
    $('.chosen-select').chosen({
      no_results_text: "Nenhum assunto encontrado com "
    });

    $('.form textarea').live('focus', function(){
      Questions.expandTextarea($(this));
    });

    $('button.reset').click(function(){
      Questions.returnTextarea($(this));
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

    $('form').validate();
    $('input[type=submit]').click(function(e){
      e.preventDefault();

      if ($('input.provider_field').length){
        $('input.provider_field').remove();
      }

      var provider = $(this).attr('data-provider');
      var element = $('<input type="hidden" name="provider['+provider+']" value="'+provider+'" class ="provider_field">');

      $(this).parent('form').append(element);
      $(this).parent('form').trigger('submit');
    });
  },
};

window.Questions ? Questions.initialize() : null;
