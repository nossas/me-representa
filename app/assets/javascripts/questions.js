var App = {

  initialize: function(){
    $('.chosen-select').each(function(){
      $(this).chosen({
        no_results_text: "Nenhum assunto encontrado :("
      });
    });
  }
};

App.initialize();
