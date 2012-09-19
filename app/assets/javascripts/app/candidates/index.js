App.Candidates.Home = Backbone.View.extend({
  el: 'body',

  initialize: function() {
    this.form                 = $('.form_to_candidates fieldset');
    this.generic_class        = $('.form_to_candidates .messages');
    this.unsuccessful_message = $('.form_to_candidates .unsuccessful');
    this.match_mobile_message = $('.form_to_candidates .match_mobile');
    this.match_email_message  = $('.form_to_candidates .match_email');
  },

  events: {
    'click .link_to_candidates a' : 'showFormToCandidates',
    'ajax:complete .form_to_candidates form'  : 'verifyCandidate',
    'click .show_form': 'showForm',
    'click .infographic' : 'showInfographic'
  },


  showInfographic: function(){
    jQuery('div.infographic').slideToggle();
  },
  
  showForm: function(){
    this.generic_class.hide();
    this.form.fadeIn();
  },

   verifyCandidate: function(event, data) {
    var response = jQuery.parseJSON(data.responseText);
    
    if (response == null) {
      this.form.hide();
      this.unsuccessful_message.fadeIn(); 
    }

    else if (response.email == true && response.mobile_phone == true) {
      this.form.hide();
      this.match_email_message.fadeIn();
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
