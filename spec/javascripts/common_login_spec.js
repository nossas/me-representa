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


  describe("#showOptions", function(){

    it("should replace the target with a login box", function(){
      spyOn($.fn, "fadeOut");
      spyOn($.fn, "fadeIn");
      spyOn($.fn, "clone").andCallThrough();

      view = new App.Common.Login({ el: $('<section><div class="login_options"><ul><li>option</li></ul></div></section>')[0]});
      form = $('<div class="form"><fieldset><form id="questions"></form></fieldset></div>');

      view.showOptions(form.find('form')[0]);

      expect($.fn.fadeOut).toHaveBeenCalled();
      expect($.fn.fadeIn).toHaveBeenCalled();
      expect($.fn.clone).toHaveBeenCalled();
    })

  })
});
