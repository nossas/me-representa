describe("Questions.Fieldset", function(){
  var view;
  beforeEach(function(){
    view = new App.Questions.Fieldset({el: $('<div>'), list: new App.Questions.List() });
  });

  describe("#afterQuestionCreate", function(){
    beforeEach(function(){
      spyOn(view.list, "prependQuestion");
      view.afterQuestionCreate({}, '<div class="share" data-question-url="/questions/7">fake html</div>');
    });

    it("should call prepend on its list", function(){
      expect(view.list.prependQuestion).toHaveBeenCalledWith('/questions/7');
    });

    it("should replace its root el html with the html passed as parameter", function(){
      expect($(view.el).text()).toEqual('fake html');
    });
  });
});
