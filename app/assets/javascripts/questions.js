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
      console.log(hiddens);
      console.log(klass);
      $('.' + klass + ' textarea').animate({ height: "60px" });
      hiddens.slideUp("fast");
    });

    if ( $('.message').text() !== '' ){
        $('.message').slideDown('fast');
        window.setTimeout("$('.message').slideUp()", 4000);
    }
  }
};

Questions.initialize();
