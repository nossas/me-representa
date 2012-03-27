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

