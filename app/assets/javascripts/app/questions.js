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
      'ajax:success .questions_list .vote' : 'updateVote',
      'change .filter-category' : 'filter',
      'change .order-category' : 'order'
    },

    reload: function(){
      this.ol.html('');
      this.disablePagination = false;
      this.load();
    },

    filter: function(event){
      var filter = $(event.target);
      this.ol.data('options', $.extend({}, this.ol.data('options'), {by_category_id: filter.find('option:selected').val()}));
      this.reload();
    },

    order: function(event){
      var filter = $(event.target);
      var order = _.reduce(filter.find('option'), function(memo, el){ memo[$(el).val()] = false; return memo; }, {});
      order[filter.find('option:selected').val()] = true;
      this.ol.data('options', $.extend({}, this.ol.data('options'), order));
      this.reload();
    },

    updateVote: function(event, data){
      $(event.currentTarget)
        .html(data)
        .find("div.vote").effect("highlight", {}, 1000);
    },

    initialize: function(){
      this.ol = this.$('ol:first');
      this.type = this.ol.data('type');
      this.disablePagination = false;
    },

    prependQuestion: function(url){
      var that = this;
      $.get(url, null, null, 'html')
      .success(function(html){
        var item = $(html).hide();
        that.ol.prepend(item);
        item.fadeIn('slow');
      });
    },

    lowerLimit: function(){
      return $(window).scrollTop() + $(window).height();
    },

    paginate: function(){
      if(this.disablePagination){
        return;
      }
      var lastItem = this.$('.questions_list ol li.user_question:last');
      var offset = this.$('.questions_list ol li.user_question').length
      if(lastItem.length > 0 && this.lowerLimit() > (lastItem.offset().top - 20)){
        this.load({offset: offset});
      }
    },

    load: function(options){
      var that = this;
      var url = this.ol.data('url');
      if(!url){ return; }
      var filters = _.map(
        $.extend({offset: 0, recent_first: true}, this.ol.data('options'), options),
        function(val, key){ return key + '=' + val; }
      ).join('&');
      this.disablePagination = true;

      url += ((url.indexOf("?") >= 0) ? '&' : '?') + filters;
      $.get(url, null, null, 'html')
      .success(function(html){
        if($.trim(html) != ''){
          var items = $(html).hide();

          that.ol.append(items);
          items.fadeIn('slow');
          that.disablePagination = false;
        }
      });
    }
  }),

  Fieldset: Backbone.View.extend({
    events: {
      'ajax:success form' : 'afterQuestionCreate'
    },

    initialize: function(options){
      this.list = options.list;
    },

    afterQuestionCreate: function(event, data){
      $(this.el).html(data);
      this.list.prependQuestion(this.$('.share').data('question-url'));
    }
  }),

  Index: Backbone.View.extend({
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
      this.truthList = new App.Questions.List({el: this.$('.truth')[0]});
      this.dareList = new App.Questions.List({el: this.$('.dare')[0]});
      this.truthFieldset = new App.Questions.Fieldset({el: this.$(".form.truth fieldset")[0], list: this.truthList});
      this.dareFieldset = new App.Questions.Fieldset({el: this.$(".form.dare fieldset")[0], list: this.dareList});
      this.truthList.load();
      this.dareList.load();
      $(window).scroll(this.scroll);
      this.$('select.chosen-select').chosen();
    }
  })
};
