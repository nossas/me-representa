describe("Questions.Form", function(){
  var view;

  beforeEach(function(){
    view = new App.Questions.Form();
    App.Common.login = {
      validate: function(){}
    };
  });

  describe("#intitalize", function(){
    it("should initialize a preview element", function(){
      expect(view.preview).toEqual(jasmine.any(Object));
    });

    it("should initialize a question element", function(){
      expect(view.question).toEqual(jasmine.any(Object));
    });
  });

  describe("#showPreview", function(){
    it("should require login", function(){
      spyOn(App.Common.login, "validate");
      view.showPreview();
      expect(App.Common.login.validate).toHaveBeenCalled();
    });

    it("should hide question login.validate is true", function(){
      spyOn(App.Common.login, "validate").andReturn(true);
      spyOn(view.question, "hide");
      view.showPreview();
      expect(view.question.hide).toHaveBeenCalled();
    });

    it("should show preview if login.validate is true", function(){
      spyOn(App.Common.login, "validate").andReturn(true);
      spyOn(view.preview, "show");
      view.showPreview();
      expect(view.preview.show).toHaveBeenCalled();
    });
  });


});
