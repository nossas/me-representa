var App = window.App = {
  Common: {
    init: function(){
      $(".questions_list .share").css({ 'opacity' : 0.4 });;
      $("li").mouseover(function(){ $(this).find(".share").css({ 'opacity' : 1 }); });
      $("li").mouseout(function(){ $(this).find(".share").css({ 'opacity' : 0.4 }); });
    },

    finish: function(){
    },
  }
};

