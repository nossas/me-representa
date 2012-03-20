var App = window.App = {
  Common: {
    init: function(){
      $(".questions_list .share").hide();
      $("li").mouseover(function(){ $(this).find(".share").show(); });
      $("li").mouseout(function(){ $(this).find(".share").hide(); });
      $("li").click(function(){ $(this).find(".share").toggle(); });
    },

    finish: function(){
    },
  }
};

