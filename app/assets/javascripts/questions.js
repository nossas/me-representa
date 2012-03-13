var App = {

  initialize: function(){
    $('.chosen-select').chosen({
      no_results_text: "Nenhum assunto encontrado com "
    });
  }
};

App.initialize();
