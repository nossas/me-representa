App.Candidates.Index = Backbone.View.extend({
  el: 'body',

  initialize: function() {
    this.parties  = $('.list_of_candidates .parties');
    this.bottle   = $('.list_of_candidates .loading');
  },

  events: {
    'change .filters_box' : 'submitFilter',
    'ajax:before'         : 'showSpinningBottle',
    'ajax:success'       : 'loadCandidates'
  },

  showSpinningBottle: function() {
    this.parties.empty().append(this.bottle.fadeIn());
  },

  loadCandidates: function(event, data) {
    this.parties.fadeOut(50).empty().append(data).fadeIn('slow');
  },

  submitFilter: function(event){
    jQuery(event.target).parents('form').submit();
  }

});
