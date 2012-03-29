describe("Questions.Index", function(){
  var view;

  beforeEach(function(){
    view = new App.Questions.Index();
  });

  describe("#scroll", function(){
    beforeEach(function(){
      spyOn(view.truthList, "paginate");
      spyOn(view.dareList, "paginate");
      view.scroll();
    });

    it("should call paginate for dareList", function(){
      expect(view.dareList.paginate).toHaveBeenCalled();
    });

    it("should call paginate for truthList", function(){
      expect(view.truthList.paginate).toHaveBeenCalled();
    });
  });

  describe("#initialize", function(){
    it("should initialize the truth fieldset", function(){
      expect(view.truthFieldset).toEqual(jasmine.any(Object));
    });

    it("should initialize the dare fieldset", function(){
      expect(view.dareFieldset).toEqual(jasmine.any(Object));
    });

    it("should initialize the truth list", function(){
      expect(view.truthList).toEqual(jasmine.any(App.Questions.List));
    });

    it("should initialize the dare list", function(){
      expect(view.dareList).toEqual(jasmine.any(App.Questions.List));
    });

    it("should initialize the truth form", function(){
      expect(view.truthForm).toEqual(jasmine.any(App.Questions.Form));
    });

    it("should initialize the dare form", function(){
      expect(view.dareForm).toEqual(jasmine.any(App.Questions.Form));
    });
  });
});
