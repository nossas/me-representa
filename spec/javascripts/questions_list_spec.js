describe("Questions.List", function(){
  var view;
  beforeEach(function(){
    view = new App.Questions.List({el: $('<div><ol data-url="/load_url?type=dare" data-type="dare"></ol></div>')[0]});
  });

  describe("#load", function(){
    beforeEach(function(){
      spyOn($, "get").and.returnValue({success: function(callback){ callback('<p>html fake</p>'); }});
    });

    it("should call get to questions passing the type role from type and offset 0 as default", function(){
      view.load();
      expect($.get).toHaveBeenCalledWith('/load_url?type=dare&offset=0&voted_first=true', null, null, 'html');
    });

    it("should call get to questions passing the type role from type", function(){
      view.load({offset: 10});
      expect($.get).toHaveBeenCalledWith('/load_url?type=dare&offset=10&voted_first=true', null, null, 'html');
    });

    it("should update the el inner HTML", function(){
      view.load(10);
      expect($(view.el).text()).toEqual('html fake');
    });
  });

  describe("#order", function(){
    var select;

    beforeEach(function(){
      select = $('<select><option value="recent_first">test</option><option value="voted_first">test2</option></select>')[0];
    });

    it("should copy the selected value as key and true as value to the ol options", function(){
      $(select).find('option:first').attr('selected', 'selected');
      view.order({target: select});
      expect(view.ol.data('options')).toEqual({voted_first: false, recent_first: true});
      $(select).find('option').removeAttr('selected');
      $(select).find('option:last').attr('selected', 'selected');
      view.order({target: select});
      expect(view.ol.data('options')).toEqual({voted_first: true, recent_first: false});
    });
  });

  describe("#filter", function(){
    var select;

    beforeEach(function(){
      select = $('<select><option value="1" selected="selected">test</option></select>')[0];
    });

    it("should copy the value to by_category_id in ol options preserving other options", function(){
      view.ol.data('options', {other_option: 2});
      view.filter({target: select});
      expect(view.ol.data('options')).toEqual({by_category_id: '1', other_option: 2});
    });

    it("should copy the value to by_category_id in ol options", function(){
      view.filter({target: select});
      expect(view.ol.data('options')).toEqual({by_category_id: '1'});
    });
  });

  describe("#prependQuestion", function(){
    beforeEach(function(){
      spyOn($, "get").and.returnValue({success: function(callback){ callback('<li>new item</li>'); }});
      view.prependQuestion('/questions/7');
    });

    it("should get the url", function(){
      expect($.get).toHaveBeenCalledWith('/questions/7', null, null, 'html');
    });

    it("should prepend the returning html to the list root el", function(){
      expect($(view.el).text()).toEqual('new item');
    });
  });

  describe("#initialize", function(){
    it("should set the type acording to root data-type", function(){
      expect(view.type).toEqual('dare');
    });
  });
});
