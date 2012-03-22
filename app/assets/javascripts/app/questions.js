App.Questions = {
  Form:  Backbone.View.extend({
    initialize: function(){
      this.preview = this.$('.preview');
      this.question = this.$('.question');
    },

    showPreview: function(){
      if(App.Common.login.validate()){
        this.question.hide();
        this.preview.show();
      }
    }
  }),

  Index: Backbone.View.extend({
    el: 'body',

    events: {
      'focus form textarea' : 'expandTextarea',
      'click button.reset' : 'returnTextarea',
      'click h4.discover' : 'toggleInfographic',
      'click button.preview' : 'preview',
      'click input[type=submit]' : 'submit'
    },

    isLoggedIn: function(){
      return this.$('.logged').length();
    },

    toggleInfographic: function(event){
      var obj = $(event.target);
      obj.siblings('.infographic').slideToggle('slow');
      obj.toggleClass('active');
    },

    preview: function(event){
    },

    expandTextarea: function(event){
      var obj = $(event.target);
      var klass = obj.data('form-type');
      var hiddens = $('.' + klass + ' .action');
      this.$('.' + klass + ' textarea').animate({ height: "200px" })
      hiddens.slideDown("fast");
    },

    returnTextarea: function(event){
      var obj = $(event.target);
      var klass = obj.data('form-type');
      var hiddens = $('.' + klass + ' .hidden');
      this.$('.' + klass + ' textarea').animate({ height: "60px" });
      hiddens.slideUp("fast");
    },

    submit: function(e){
      e.preventDefault();
      var parent_element = $(e.target).parents('form:first');
      console.log(parent_element);
      parent_element.validate();

      var child = parent_element.children('input.provider_field');
      if (child.length) { child.remove(); }

      var provider = $(this).data('provider');
      var element = $('<input type="hidden" name="provider['+provider+']" value="'+provider+'" class ="provider_field">');

      parent_element.append(element);
      parent_element.trigger('submit');
    },

    initialize: function(){
      this.truthForm = new App.Questions.Form({el: this.$('form#questions_truth')[0]});
      this.dareForm = new App.Questions.Form({el: this.$('form#questions_dare')[0]});

      $('form.new_vote').bind('ajax:complete', function(){
        var obj = $(this);
        obj.after('Valeu por votar!');
        obj.remove();
      });

      $('input[type=submit]').click(function(e){
        e.preventDefault();
        var parent_element = $(this).parent('form');
        parent_element.validate();

        var child = parent_element.children('input.provider_field');
        if (child.length) { child.remove(); }

        var provider = $(this).data('provider');
        var element = $('<input type="hidden" name="provider['+provider+']" value="'+provider+'" class ="provider_field">');

        parent_element.append(element);
        parent_element.trigger('submit');
      });

      $('#questions_truth').bind("ajax:success", function(event, data){ $(".form.truth").html(data); });
    },
  })
};
