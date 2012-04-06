App.Questions.Textarea = Backbone.View.extend({
  events: {
    'focus' : 'focus',
    'blur' : 'blur',
    'keydown' : 'keydown',
    'click' : 'click'
  },

  keydown: function(event){
    // Prevent user from erasing the placeholder
    if(this.getCaret() <= this.placeholder.length && ($.inArray(event.which, [8, 37, 38, 40, 46]) >= 0)){
      return false;
    }
  },

  blur: function(event){
    if($.trim(this.root.val()) == $.trim(this.placeholder)){
      this.root.val('');
    }
  },

  click: function(event){
    if(this.getCaret() < this.placeholder.length){
      this.setCaret(this.placeholder.length);
    }
  },

  focus: function(event){
    this.root.val(this.placeholder);
    this.setCaret(this.placeholder.length);
  },

  initialize: function(){
    this.root = $(this.el);
    this.placeholder = $(this.el).prop('placeholder');
    if(this.placeholder){
      this.placeholder = this.placeholder.replace('...', ' ');
    }
  },

  getCaret : function(){
    var caretPos = 0;   // IE Support
    if (document.selection) {
      this.el.focus ();
      var sel = document.selection.createRange ();
      sel.moveStart ('character', -this.el.value.length);
      caretPos = sel.text.length;
    }
    // Firefox support
    else if (this.el.selectionStart || this.el.selectionStart == '0'){
      caretPos = this.el.selectionStart;
    }
    return (caretPos);
  },

  setCaret: function(pos){
    if(this.el.setSelectionRange){
      this.el.focus();
      this.el.setSelectionRange(pos,pos);
    }
    else if (this.el.createTextRange) {
      var range = this.el.createTextRange();
      range.collapse(true);
      range.moveEnd('character', pos);
      range.moveStart('character', pos);
      range.select();
    }
  }
});

