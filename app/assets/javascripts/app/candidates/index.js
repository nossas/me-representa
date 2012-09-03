App.Candidates.Index = Backbone.View.extend({
  el: 'body',

  initialize: function() {},

  events: {
    'click .link_to_candidates #link_to_form' : 'showFormToCandidates'
  },

  showFormToCandidates: function(event) {
    $('.form_to_candidates').slideToggle();

  }


});

App.Answers.New = Backbone.View.extend({
  
  el: 'body',

  initialize: function() {
  },

  events: {
    'ajax:complete form' : 'showSuccessfulMessage',
    'change form input' : 'submitAnswer',
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

  showSuccessfulMessage: function(event){
    var object =  $(event.target);
    object.parents('.question').addClass('success');
  },

  submitAnswer: function(event) {
    var object = $(event.target);
    object.closest("form").submit();
    object.parents('form').siblings('form').children('label.textarea').fadeIn('fast');
  },

  showTextarea: function(event) {
    var object = $(event.target);
    object.siblings('textarea').slideToggle();
    object.siblings('input').slideToggle('100');
  }

});
