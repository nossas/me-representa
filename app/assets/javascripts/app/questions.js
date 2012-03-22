App.Questions = {
  Form:  Backbone.View.extend({
    events: {
      'click button.reset' : 'returnTextarea',
      'click button.preview' : 'showPreview',
      'focus textarea' : 'expandTextarea'
    },

    initialize: function(){
      this.preview = this.$('.preview');
      this.question = this.$('.question');
      this.textarea = this.$('textarea');
      this.actions = this.$('.action');
    },

    returnTextarea: function(){
      this.textarea.animate({ height: "60px" })
      this.actions.slideUp('fast');
    },

    expandTextarea: function(){
      this.textarea.animate({ height: "200px" })
      this.actions.slideDown('fast');
    },

    showPreview: function(){
      if($(this.el).valid() && App.Common.login.validate()){
        this.question.hide();
        this.preview.show();
      }
    }
  }),

  Index: Backbone.View.extend({
    el: 'body',

    events: {
      'click h4.discover' : 'toggleInfographic',
    },

    toggleInfographic: function(event){
      var obj = $(event.target);
      obj.siblings('.infographic').slideToggle('slow');
      obj.toggleClass('active');
    },

    initialize: function(){
      this.truthForm = new App.Questions.Form({el: this.$('form#questions_truth')[0]});
      this.dareForm = new App.Questions.Form({el: this.$('form#questions_dare')[0]});

      $('form.new_vote').bind('ajax:complete', function(){
        var obj = $(this);
        obj.after('Valeu por votar!');
        obj.remove();
      });

      $('#questions_truth').bind("ajax:success", function(event, data){ $(".form.truth").html(data); });
    },
  })
};
