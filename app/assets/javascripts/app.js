var App = window.App = {
  Questions: {},
  Candidates: {},
  Answers: {
  },
  Common: {
    init: function(){
      App.Common.login = new App.Common.Login({el: $('section.login')[0]});
      $('select.chosen-select').chosen();
      $('#about_politician').hide();
      $('a[href="#about_politician"]').facebox('some html');
      $("form.new_answer input[type=radio]").change(function(event){
        var object = $(event.target);
        object.closest("form").submit();
        object.parents('form').siblings('form').children('label.textarea').fadeIn('fast');
      });
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

