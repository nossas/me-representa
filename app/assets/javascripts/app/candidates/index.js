App.Candidates.Index = Backbone.View.extend({
  el: 'body',

  initialize: function() {
  },

  events: {
    'change .filters_box' : 'submitFilter'
  },

  submitFilter: function(event){
    jQuery(event.target).parents('form').submit();
  }

});
