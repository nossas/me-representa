describe("Questions.Index", function(){
  var view;

  beforeEach(function(){
    view = new App.Questions.Index();
  });

  describe("#initialize", function(){
    it("should initialize the truth form", function(){
      expect(view.truthForm).toEqual(jasmine.any(App.Questions.Form));
    });

    it("should initialize the dare form", function(){
      expect(view.dareForm).toEqual(jasmine.any(App.Questions.Form));
    });
  });
});
