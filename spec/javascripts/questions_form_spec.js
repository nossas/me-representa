describe("Questions.Form", function(){
  var view;

  beforeEach(function(){
    view = new App.Questions.Form({
      el: $('<form><div class="preview"><div class="description"></div><div class="category"></div></div><textarea>content</textarea><select name="question[category_id]"><option></option><option selected="selected">selected option</option></select></form>')[0]
    });
    App.Common.login = {
      validate: function(){}
    };
  });

  describe("#intitalize", function(){
    it("should initialize a preview description element", function(){
      expect(view.previewDescription).toEqual(jasmine.any(Object));
    });

    it("should initialize a preview category element", function(){
      expect(view.previewCategory).toEqual(jasmine.any(Object));
    });

    it("should initialize a preview element", function(){
      expect(view.preview).toEqual(jasmine.any(Object));
    });

    it("should initialize an actions element", function(){
      expect(view.actions).toEqual(jasmine.any(Object));
    });

    it("should initialize a textarea element", function(){
      expect(view.textarea).toEqual(jasmine.any(Object));
    });

    it("should initialize a question element", function(){
      expect(view.question).toEqual(jasmine.any(Object));
    });
  });

  describe("#returnTextarea", function(){
    beforeEach(function(){
      spyOn(view.actions, "slideUp");
      spyOn(view.textarea, "animate");
      view.returnTextarea();
    });

    it("should hide actions", function(){
      expect(view.actions.slideUp).toHaveBeenCalled();
    });

    it("should animate the textarea", function(){
      expect(view.textarea.animate).toHaveBeenCalled();
    });
  });

  describe("#expandTextarea", function(){
    beforeEach(function(){
      spyOn(view.actions, "slideDown");
      spyOn(view.textarea, "animate");
      view.expandTextarea();
    });

    it("should show actions", function(){
      expect(view.actions.slideDown).toHaveBeenCalled();
    });

    it("should animate the textarea", function(){
      expect(view.textarea.animate).toHaveBeenCalled();
    });
  });

  describe("#generatePreview", function(){
    beforeEach(function(){
      view.generatePreview();
    });

    it("should copy text to preview description", function(){
      expect(view.previewDescription.html()).toEqual(view.textarea.val());
    });

    it("should copy selected option to preview category", function(){
      expect(view.previewCategory.html()).toEqual(view.$('[name="question[category_id]"] option:selected').html());
    });
  });

  describe("#showPreview", function(){
    var validator = {
      valid: function(){ return true }
    };

    beforeEach(function(){
      spyOn(validator, "valid").andReturn(true);
      spyOn(App.Common.login, "validate").andReturn(true);
      $ = function(){
        return validator;
      };
    });

    afterEach(function(){
      $ = jQuery;
    });

    it("should not require login if form validation is false", function(){
      validator.valid.andReturn(false);
      view.showPreview();
      expect(App.Common.login.validate).wasNotCalled();
    });

    it("should require login", function(){
      view.showPreview();
      expect(App.Common.login.validate).toHaveBeenCalled();
    });

    it("should generate the preview", function(){
      spyOn(view, "generatePreview");
      view.showPreview();
      expect(view.generatePreview).toHaveBeenCalled();
    });

    it("should validate the form", function(){
      view.showPreview();
      expect(validator.valid).toHaveBeenCalled();
    });

    it("should hide question login.validate is true", function(){
      spyOn(view.question, "hide");
      view.showPreview();
      expect(view.question.hide).toHaveBeenCalled();
    });

    it("should show preview if login.validate is true", function(){
      spyOn(view.preview, "show");
      view.showPreview();
      expect(view.preview.show).toHaveBeenCalled();
    });
  });


});
