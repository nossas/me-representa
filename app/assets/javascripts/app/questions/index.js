App.Questions.Index =  Backbone.View.extend({
  el: 'body',

  events: {
    'click h4.discover' : 'toggleInfographic',
    'ajax:success .form' : 'onQuestionCreate'
  },

  onQuestionCreate: function(event, data){
    var target = $(event.currentTarget);
    target.find('fieldset').html(data);
    if(target.hasClass('truth')){
      that.truthList.load();
    }
    else{
      that.dareList.load();
    }
  },

  scroll: function(event){
    this.truthList.paginate();
    this.dareList.paginate();
  },

  toggleInfographic: function(event){
    var obj = $(event.target);
    obj.siblings('.infographic').slideToggle('slow');
    obj.toggleClass('active');
  },

  initialize: function(){
    _.bindAll(this);
    var that = this;
    this.truthForm = new App.Questions.Form({el: this.$('form#questions_truth')[0]});
    this.dareForm = new App.Questions.Form({el: this.$('form#questions_dare')[0]});
    this.truthList = new App.Questions.List({el: this.$('section.truth')[0]});
    this.dareList = new App.Questions.List({el: this.$('section.dare')[0]});
    this.truthFieldset = new App.Questions.Fieldset({el: this.$(".form.truth fieldset")[0], list: this.truthList});
    this.dareFieldset = new App.Questions.Fieldset({el: this.$(".form.dare fieldset")[0], list: this.dareList});
    this.truthList.load();
    this.dareList.load();
    $(window).scroll(this.scroll);
    this.$('select.chosen-select').chosen();
  }
});
