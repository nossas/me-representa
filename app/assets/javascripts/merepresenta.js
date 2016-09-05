(function(){
    $("#sair").on("click", function(event) {
        event.preventDefault();
        $(this).next().submit();
    })
})();