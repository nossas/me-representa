App.Questions.Fieldset = Backbone.View.extend({
  events: {
    'ajax:success form' : 'afterQuestionCreate'
  },

  initialize: function(options){
    this.list = options.list;
  },

  afterQuestionCreate: function(event, data){
    $(this.el).html(data);
    this.list.prependQuestion(this.$('.share').data('question-url'));
  }
});
