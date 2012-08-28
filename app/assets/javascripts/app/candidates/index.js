App.Candidates.Index = Backbone.View.extend({

});

App.Answers.New = Backbone.View.extend({
  
  el: 'body',

  initialize: function() {
  },

  events: {
    'ajax:complete form' : 'showSuccessfulMessage',
    'change form input' : 'submitAnswer'
  },

  showSuccessfulMessage: function(event){
    var object =  $(event.target);

  },

  submitAnswer: function(event) {
    var object = $(event.target);
    object.closest("form").submit();
  }

});
