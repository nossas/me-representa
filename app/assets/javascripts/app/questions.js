App.Questions = {
  Form:  Backbone.View.extend({
    events: {
      'click button.edit' : 'hidePreview',
      'click button.reset' : 'returnTextarea',
      'click button.preview' : 'showPreview',
      'focus textarea' : 'expandTextarea'
    },

    initialize: function(){
      this.id = this.el.id;
      this.preview = this.$('.preview');
      this.previewCategory = this.$('.preview .category');
      this.previewDescription = this.$('.preview .description .text');
      this.question = this.$('.question');
      this.select = this.$('select');
      this.textarea = this.$('textarea');
      this.role_type = this.$('[name="question[role_type]"]');
      this.actions = this.$('.action');
      this.store = this.store || new Store(this.id);
      this.$('select.chosen-select').chosen();

      // Checking if there is some store data
      this.fillFormWithPreviousStoreData();
    },

    checkStoreData: function(){
      if (this.store.get('category') && this.store.get('text') && this.store.get('role_type'))
        return true
    },


    fillFormWithPreviousStoreData: function(){
      if (this.checkStoreData()){
        this.select.children('option[value='+this.store.get('category')+']').attr('selected','selected');
        this.textarea.html(this.store.get('text'));
        this.role_type.val(this.store.get('role_type'));
        this.showPreview();
        Store.clear();
      }
    },

    returnTextarea: function(){
      this.textarea.animate({ height: "60px" });
      this.actions.slideUp('fast');
      $(this.el).validate().resetForm();
    },

    expandTextarea: function(){
      this.$('select').trigger('liszt:updated');
      this.textarea.animate({ height: "200px" });
      this.actions.slideDown('fast');
    },

    generatePreview: function(){
      this.previewDescription.html(this.textarea.val());
      this.previewCategory.html(this.$('[name="question[category_id]"] option:selected').html());
    },

    storeQuestionData: function(){
      this.store.set('category', this.select.val());
      this.store.set('role_type', this.role_type.val());
      this.store.set('text', this.textarea.val());
    },

    hidePreview: function(){
      this.$('select.chosen-select').trigger('liszt:updated');
      this.preview.hide();
      this.question.show();
      this.actions.show();
    },

    showPreview: function(){
      if ($(this.el).valid()){
        if ( App.Common.login.validate() ){
          this.question.hide();
          this.generatePreview();
          this.preview.show();
        } else {
          this.storeQuestionData();
          App.Common.login.showOptions(this.el);
        }
      }
    }
  }),

  List: Backbone.View.extend({
    events: {
     'ajax:success .buttons' : 'updateVote'
    },

    updateVote: function(event, data){
      $(event.currentTarget)
        .html(data)
        .find("span.votes").effect("highlight", {}, 1000);
    },

    initialize: function(){
      this.type = $(this.el).data('type');
    },

    loadList: function(){
      var that = this;
      $.get('questions?type_role=' + this.type)
        .success(function(html){ $(that.el).html(html) });
    }
  }),

  Index: Backbone.View.extend({
    el: 'body',

    events: {
      'click h4.discover' : 'toggleInfographic',
    },

    toggleInfographic: function(event){
      var obj = $(event.target);
      obj.siblings('.infographic').slideToggle('slow');
      obj.toggleClass('active');
    },

    initialize: function(){
      var that = this;
      this.truthForm = new App.Questions.Form({el: this.$('form#questions_truth')[0]});
      this.dareForm = new App.Questions.Form({el: this.$('form#questions_dare')[0]});
      this.truthList = new App.Questions.List({el: this.$('ol#truths')[0]});
      this.dareList = new App.Questions.List({el: this.$('ol#dares')[0]});

      $('#questions_truth').bind("ajax:success", function(event, data){
        that.truthList.loadList();
        $(".form.truth fieldset").html(data);
      });

      $('#questions_dare').bind("ajax:success", function(event, data){
        that.dareList.loadList();
        $(".form.dare fieldset").html(data);
      });
    },
  })
};
