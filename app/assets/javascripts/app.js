var App = window.App = {
  Common: {
    init: function(){
      $(".questions_list .share").css({ 'opacity' : 0.4 });;
      $("li").mouseover(function(){ $(this).find(".share").css({ 'opacity' : 1 }); });
      $("li").mouseout(function(){ $(this).find(".share").css({ 'opacity' : 0.4 }); });
      App.Common.login = new App.Common.Login({el: $('section.login')[0]});
    },

    finish: function(){
    },

    Login: Backbone.View.extend({
      validate: function(){
        return this.$('.logged').length;
      }
    })
  }
};

