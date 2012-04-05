describe("Questions.Fieldset", function(){
  var view;
  beforeEach(function(){
    view = new App.Questions.Fieldset({el: $('<div><div class="ajax-target"></div></div>'), list: new App.Questions.List(), form: new App.Questions.Form({el: $('<form>')[0]}) });
  });

  describe("#showForm", function(){
    beforeEach(function(){
      spyOn(view.form, "backToForm");
      spyOn(view.ajaxTarget, "hide");
      view.showForm();
    });

    it("should hide the ajax target", function(){
      expect(view.ajaxTarget.hide).toHaveBeenCalled();
    });

    it("should show the form", function(){
      expect(view.form.backToForm).toHaveBeenCalled();
    });
  });

  describe("#afterQuestionCreate", function(){
    beforeEach(function(){
      spyOn(view.list, "prependQuestion");
      spyOn(view.formEl, "hide");
      spyOn(view.ajaxTarget, "show");
      view.afterQuestionCreate({}, '<div class="share" data-question-url="/questions/7">fake html</div>');
    });

    it("should call prepend on its list", function(){
      expect(view.list.prependQuestion).toHaveBeenCalledWith('/questions/7');
    });

    it("should replace its root el html with the html passed as parameter", function(){
      expect(view.ajaxTarget.text()).toEqual('fake html');
    });

    it("should show the ajax target", function(){
      expect(view.ajaxTarget.show).toHaveBeenCalled();
    });

    it("should hide the form", function(){
      expect(view.formEl.hide).toHaveBeenCalled();
    });
  });
});
