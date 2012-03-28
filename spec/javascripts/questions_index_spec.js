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

  describe("#loadDares", function(){
    beforeEach(function(){
      spyOn(view.dareList, "load");
      spyOn(view.dareFieldset, "html");
      view.loadDares({}, 'test html');
    });

    it("should call dareList.load", function(){
      expect(view.dareList.load).toHaveBeenCalled();
    });

    it("should update the fieldset with a partial received", function(){
      expect(view.dareFieldset.html).toHaveBeenCalledWith('test html');
    });
  });

  describe("#loadTruths", function(){
    beforeEach(function(){
      spyOn(view.truthList, "load");
      spyOn(view.truthFieldset, "html");
      view.loadTruths({}, 'test html');
    });

    it("should call truthList.load", function(){
      expect(view.truthList.load).toHaveBeenCalled();
    });

    it("should update the fieldset with a partial received", function(){
      expect(view.truthFieldset.html).toHaveBeenCalledWith('test html');
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
