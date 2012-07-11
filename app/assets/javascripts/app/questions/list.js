App.Questions.List = Backbone.View.extend({
  events: {
    'ajax:success .new_vote' : 'updateVote',
    'change .filter-category' : 'filter',
    'change .order-category' : 'order',
    'click .category-link' : 'filterCategory'
  },

  initialize: function(){
    this.ol = this.$('ol:first');
    this.type = this.ol.data('type');
    this.disablePagination = false;
  },

  reload: function(){
    this.ol.html('');
    this.disablePagination = false;
    this.load();
  },

  filter: function(event){
    window.location = "#truth_filter"
    var filter = $(event.target);
    this.ol.data('options', $.extend({}, this.ol.data('options'), {by_category_id: filter.find('option:selected').val()}));
    this.reload();
  },

  filterCategory: function(event){
    var id = $(event.target).data('category-id');
    var filter = this.$(".filter-category");
    filter.find('option').removeProp('selected');
    filter.find('option[value="' + id + '"]').prop('selected', 'selected');
    filter.trigger('change').trigger("liszt:updated");
    return false;
  },

  order: function(event){
    var filter = $(event.target);
    var order = _.reduce(filter.find('option'), function(memo, el){ memo[$(el).val()] = false; return memo; }, {});
    order[filter.find('option:selected').val()] = true;
    this.ol.data('options', $.extend({}, this.ol.data('options'), order));
    this.reload();
  },

  updateVote: function(event, data){
    var result = JSON.parse(data);
    var obj = $(event.currentTarget);
    obj.siblings('.votes')
      .html(result.votes)
      .effect('highlight', {}, 500);
    obj.children('input').attr('disabled', 'disabled');
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
    $("form.new_vote").submit(function(){ $(this).find("input[type='submit']").attr("disabled", "disabled") });
  }
});
