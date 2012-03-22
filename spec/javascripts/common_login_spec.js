describe("Common.Login", function(){
  var view;

  describe("#validate", function(){
    it("should return true when we have a .logged div", function(){
      view = new App.Common.Login({el: $('<section><div class="logged"></div></section>')[0]});
      expect(view.validate()).toBeTruthy();
    });

    it("should return false when we do not have a .logged div", function(){
      view = new App.Common.Login({el: $('<section></section>')[0]});
      expect(view.validate()).toBeFalsy();
    });
  });
});
