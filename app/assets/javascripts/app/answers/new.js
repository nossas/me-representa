App.Answers.New = Backbone.View.extend({
  
  el: 'body',

  initialize: function() {
  },

  events: {
    'ajax:success form' : 'showSuccessfulMessage',
    'click label.textarea' : 'showTextarea',
    'ajax:complete form.comment' : 'hideCommentBox',
    'blur textarea': 'submitTextareaForms',
  },

  submitTextareaForms: function(event) {
    var object = $(event.target);
    object.animate({ opacity: .9});
    object.parents('form').submit();

  },
  
  hideCommentBox: function(event) {
    var object = $(event.target);
    object.children('textarea').slideUp('slow');
    object.children('input').slideUp('fast');
  },

  showSuccessfulMessage: function(xhr, data, status){
    var question = $(xhr.target).parent();
    question.html($(data).html());
    question.addClass('success');
  },

  showTextarea: function(event) {
    var object = $(event.target);
    object.siblings('textarea').slideToggle();
    object.siblings('input').slideToggle('100');
  }

});
