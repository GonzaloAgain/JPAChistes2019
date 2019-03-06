$(document).ready(function() {
    
    console.log('ready');
    init();
    
});

function init(){
    saveChiste()
}

function saveChiste(){	
    $("#btnNuevoChiste").click(function (e){
        console.log('saveChiste');
        e.preventDefault();
        var frm = $("#formularioChiste").serialize();
        $.ajax({
            type: "POST",
            url: "Controller?op=addChiste",
            data: frm,
            success : function(info) {
                console.log('chiste añadido');
                console.log(info);
                $("#nuevoChiste").append(info);
                $("#modalChiste").modal("hide");
                document.getElementById("formularioChiste").reset();
            }
        });
        
    });
}


