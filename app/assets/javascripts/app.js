var App = window.App = {
  Router: Backbone.Router.extend({
    routes: {
      'login' : 'showLoginBox'
    },

    showLoginBox: function(){
      jQuery.facebox({ div: "#meurio_login_box"}, 'my-style');
    }
  }),
  Questions: {},
  Candidates: {},
  Answers: {
  },
  Common: {
    init: function(){
      App.Common.login = new App.Common.Login({el: $('section.login')[0]});
      new App.Router();
      Backbone.history.start();
      $('select.chosen-select').chosen();
      $('#about_politician').hide();
      $('a[href="#about_politician"]').facebox('some html');
    },

    finish: function(){
    },
    Login: Backbone.View.extend({
      validate: function(){
        return this.$('.logged').length;
      },
      showOptions: function(target){
        var obj = $(target)
        var login = this.$('.login_options');

        if (target){
          var copy_parent = obj.parents('div.form');

          obj.fadeOut('fast');

          login.clone().appendTo(copy_parent);
          copy_parent.children('.login_options').fadeIn();
        }
      }

    })
  }
};

