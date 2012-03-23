var App = window.App = {
  Common: {
    init: function(){
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

