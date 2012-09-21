App.Candidates.Index = Backbone.View.extend({
  el: 'body',

  initialize: function() {
  },

  events: {
    'change .filters_box' : 'submitFilter',
    'ajax:success' : 'loadCandidates'
  },

  loadCandidates: function(event, data) {
    jQuery('.list_of_candidates .parties').fadeOut(50).empty().append(data).fadeIn('slow');
  },

  submitFilter: function(event){
    jQuery(event.target).parents('form').submit();
  }

});
