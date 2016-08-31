describe("Questions.Form", function(){
  var view;
  var context = describe;
  var storeStub;
  App.Common.login = { validate: function(){}, showOptions: function(){} };

  beforeEach(function(){
    view = new App.Questions.Form({
      el: $('<form id="questions"><div class="preview"><div class="description"><span class="text"></span></div><div class="category"></div></div><textarea placeholder="test placeholder">content</textarea><select name="question[category_id]"><option></option><option selected="selected">selected option</option></select></form>')[0]
    });

    storeStub = { get: function(){}, set: function(){}, remove: function(){} };


  });

  describe("#initialize", function(){

    it("should get the form id", function(){
      expect(view.id).toEqual(jasmine.any(String));
    });

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

    it("shoud initialize a select element", function(){
      expect(view.select).toEqual(jasmine.any(Object));
    });

    it("shoud initialize a role_type element", function(){
      expect(view.role_type).toEqual(jasmine.any(Object));
    });

    it("should initialize a textarea element", function(){
      expect(view.textarea).toEqual(jasmine.any(Object));
    });

    it("should initialize a question element", function(){
      expect(view.question).toEqual(jasmine.any(Object));
    });

    it("should create a question store", function(){
      expect(view.store).toEqual(jasmine.any(Store));
    });

    it("should check if there is store data to fill the form and generate the preview", function(){
      expect(view.fillFormWithPreviousStoreData).toEqual(jasmine.any(Function));
    });
  });

  describe("#returnTextarea", function(){
    beforeEach(function(){
      spyOn(view.actions, "slideUp");
      spyOn(view.textarea, "animate");
      spyOn($.fn, "validate").and.callThrough();
      view.returnTextarea();
    });

    it("should hide actions and reset error messages", function(){
      expect(view.actions.slideUp).toHaveBeenCalled();
      expect($.fn.validate).toHaveBeenCalled();
    });

    it("should animate the textarea", function(){
      expect(view.textarea.animate).toHaveBeenCalled();
    });
  });

  describe("#expandTextarea", function(){
    beforeEach(function(){
      spyOn(view.actions, "slideDown");
      spyOn(view.textarea, "animate");
      spyOn($.fn, "trigger");
      view.expandTextarea();
    });

    it("should show actions", function(){
      expect(view.actions.slideDown).toHaveBeenCalled();
      expect($.fn.trigger).toHaveBeenCalledWith('liszt:updated');
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

  describe("onSubmit", function(){
    beforeEach(function(){
      view.textarea.val(view.textareaView.placeholder + ' test string');
      view.onSubmit();
    });

    it("should clean the placeholder from texareas", function(){
      expect(view.textarea.val()).toEqual('test string');
    });
  });

  describe("backToForm", function(){
    beforeEach(function(){
      spyOn($.fn, "trigger");
      spyOn($.fn, "validate").and.callThrough();
      spyOn(view, "hidePreview");
      view.backToForm();
    });

    it("should hide the preview", function(){
      expect(view.hidePreview).toHaveBeenCalled();
    });
  });

  describe("#fillFormWithPreviousStoreData", function(){

    beforeEach(function(){
      view.store = storeStub;
      spyOn(App.Common.login, "validate").and.returnValue(true);
      spyOn(view.store, "get");
      spyOn(view, "showPreview");
      spyOn(Store, "clear");

    });

    it("should show the preview if the user wasn't logged in but wrote a question before its login", function(){
      spyOn(view, "checkStoreData").and.returnValue(true);


      view.fillFormWithPreviousStoreData();

      expect(view.store.get).toHaveBeenCalledWith('category');
      expect(view.store.get).toHaveBeenCalledWith('role_type');
      expect(view.store.get).toHaveBeenCalledWith('text');
      expect(view.showPreview).toHaveBeenCalled();
      expect(Store.clear).toHaveBeenCalled();
    });

    it("should NOT show the preview if the user didn't write a question before its login", function(){
      spyOn(view, "checkStoreData").and.returnValue(false);


      view.fillFormWithPreviousStoreData();

      expect(view.store.get).not.toHaveBeenCalledWith('category');
      expect(view.store.get).not.toHaveBeenCalledWith('role_type');
      expect(view.store.get).not.toHaveBeenCalledWith('text');
      expect(view.showPreview).not.toHaveBeenCalled();
      expect(Store.clear).not.toHaveBeenCalled();
    });


  });

  describe("#storeQuestionData", function(){

    beforeEach(function(){
      view.store = storeStub;
    });

    it("should store question[category_id] and question[text]", function(){
      spyOn(view.store, "set");
      spyOn(view.select, "val").and.returnValue('1')
      spyOn(view.textarea, "val").and.returnValue('My question text');
      spyOn(view.role_type, "val").and.returnValue('truth')
      view.storeQuestionData();

      expect(view.store.set).toHaveBeenCalledWith('category', '1');
      expect(view.store.set).toHaveBeenCalledWith('text', 'My question text');
      expect(view.store.set).toHaveBeenCalledWith('role_type', 'truth');
    });
  });


  describe("#hidePreview", function(){

    it("should hide preview and show the form plus update the chosen select", function(){
      spyOn(view.preview, "hide");
      spyOn(view.question, "show");
      spyOn(view.actions, "show");
      spyOn($.fn, "trigger")
      view.hidePreview();

      expect(view.question.show).toHaveBeenCalled();
      expect(view.actions.show).toHaveBeenCalled();
      expect(view.preview.hide).toHaveBeenCalled();
      expect($.fn.trigger).toHaveBeenCalledWith('liszt:updated');

    });
  });

  describe("#showPreview", function(){
    var validator = {
      valid: function(){ return true }
    };

    beforeEach(function(){
      spyOn(validator, "valid").and.returnValue(true);
      spyOn(App.Common.login, "showOptions");
      $ = function(){
        return validator;
      };
      $.trim =  jQuery.trim;
    });

    afterEach(function(){
      $ = jQuery;
    });

    context("When the user is logged in", function(){

      beforeEach(function(){
        spyOn(App.Common.login, "validate").and.returnValue(true);
      })

      it("should not require login if form validation is false", function(){
        validator.valid.and.returnValue(false);
        view.showPreview();
        expect(App.Common.login.validate).not.toHaveBeenCalled();
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
    // end user-logged-in context

    context("When the user is not logged in", function(){

      beforeEach(function(){
        spyOn(App.Common.login, "validate").and.returnValue(false);
      })

      it("should validate the form", function(){
        view.showPreview();
        expect(validator.valid).toHaveBeenCalled();
      });

      it("should not require login if form validation is false", function(){
        validator.valid.and.returnValue(false);
        view.showPreview();
        expect(App.Common.login.validate).not.toHaveBeenCalled();
      });

      it("should require login", function(){
        view.showPreview();
        expect(App.Common.login.validate).toHaveBeenCalled();
      });

      it("should not generate the preview", function(){
        spyOn(view, "generatePreview");
        view.showPreview();
        expect(view.generatePreview).not.toHaveBeenCalled();
      });

      it("should not hide question if login.validate is false", function(){
        spyOn(view.question, "hide");
        view.showPreview();
        expect(view.question.hide).not.toHaveBeenCalled();
      });

      it("should not show preview if login.validate is false", function(){
        spyOn(view.preview, "show");
        view.showPreview();
        expect(view.preview.show).not.toHaveBeenCalled();
      });

      it("should store the question data", function(){
        spyOn(view, "storeQuestionData");
        view.showPreview();
        expect(view.storeQuestionData).toHaveBeenCalled();
      });

      it("should show the box with login options", function(){
        view.showPreview();
        expect(App.Common.login.showOptions).toHaveBeenCalledWith(view.el);
      })
    });
    // end user-not-logged-in context
  })


});
