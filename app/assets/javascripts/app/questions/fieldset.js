App.Questions.Fieldset = Backbone.View.extend({
  events: {
    'ajax:success form' : 'afterQuestionCreate',
    'click .show-form' : 'showForm'
  },

  initialize: function(options){
    this.list = options.list;
    this.form = options.form;
    this.ajaxTarget = this.$('.ajax-target');
    this.formEl = $(this.form.el);
  },

  showForm: function(event){
    this.ajaxTarget.hide();
    this.form.backToForm();
  },

  afterQuestionCreate: function(event, data){
    this.ajaxTarget.html(data);
    this.ajaxTarget.show();
    this.formEl.hide();
    this.list.prependQuestion(this.$('.share').data('question-url'));
  }
});
