describe("Questions.List", function(){
  var view;
  beforeEach(function(){
    view = new App.Questions.List({el: $('<ol data-url="load_url" data-type="dare"></ol>')[0]});
  });

  describe("#load", function(){
    beforeEach(function(){
      spyOn($, "get").andReturn({success: function(callback){ callback('html fake'); }});
      view.load();
    });

    it("should call get to questions passing the type role from type", function(){
      expect($.get).toHaveBeenCalledWith('load_url', null, null, 'html');
    });

    it("should update the el inner HTML", function(){
      expect($(view.el).html()).toEqual('html fake');
      
    });
  });

  describe("#initialize", function(){
    it("should set the type acording to root data-type", function(){
      expect(view.type).toEqual('dare');
    });
  });
});
