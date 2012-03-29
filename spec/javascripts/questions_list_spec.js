describe("Questions.List", function(){
  var view;
  beforeEach(function(){
    view = new App.Questions.List({el: $('<ol data-url="load_url" data-type="dare"></ol>')[0]});
  });

  describe("#load", function(){
    beforeEach(function(){
      spyOn($, "get").andReturn({success: function(callback){ callback('<p>html fake</p>'); }});
    });

    it("should call get to questions passing the type role from type and offset 0 as default", function(){
      view.load();
      expect($.get).toHaveBeenCalledWith('load_url?offset=0', null, null, 'html');
    });

    it("should call get to questions passing the type role from type", function(){
      view.load(10);
      expect($.get).toHaveBeenCalledWith('load_url?offset=10', null, null, 'html');
    });

    it("should update the el inner HTML", function(){
      view.load(10);
      expect($(view.el).text()).toEqual('html fake');
    });
  });

  describe("#prependQuestion", function(){
    beforeEach(function(){
      spyOn($, "get").andReturn({success: function(callback){ callback('<li>new item</li>'); }});
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
