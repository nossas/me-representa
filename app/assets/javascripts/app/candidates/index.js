App.Candidates.Index = Backbone.View.extend({
  el: 'body',

  initialize: function() {
    this.form                 = $('.form_to_candidates fieldset');
    this.unsuccessful_message = $('.form_to_candidates .unsuccessful');
    this.match_mobile_message = $('.form_to_candidates .match_mobile');
    this.match_email_message  = $('.form_to_candidates .match_email');
  },

  events: {
    'click .link_to_candidates a' : 'showFormToCandidates',
    'ajax:complete .form_to_candidates form'  : 'verifyCandidate'
  },
  
   verifyCandidate: function(event, data) {
    var response = jQuery.parseJSON(data.responseText);
    if (response == null) {
      this.form.hide();
      this.unsuccessful_message.fadeIn(); 
    }
    else if (response.email == true && response.mobile_phone == false) {
      this.form.hide();
      this.match_email_message.fadeIn();
    }
    else if (response.email == false && response.mobile_phone == true) {
      this.form.hide();
      this.match_mobile_message.fadeIn();
    }

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
