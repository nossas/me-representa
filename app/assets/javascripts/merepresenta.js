(function(){
    $("#sair").on("click", function(event) {
        event.preventDefault();
        $(this).next().submit();
    })
    
    $('.date-input').mask('00/00/0000');
    $('.cpf-input').mask('000.000.000-00');
})();