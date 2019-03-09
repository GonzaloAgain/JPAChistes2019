$(document).ready(function() {
    
    console.log('ready');
    init();
    
});

function init(){
    comprobarSave()
}

function comprobarSave(){
    $("#btnNuevoChiste").click(function (e){
        if ($("#textApodo").val()!="" && $("#textDescripcion").val()!="" && $("#selectChiste").val()!=null && $("#textTitulo").val()!=""){
            saveChiste()
        }
        $("#modalChiste").modal("hide");
        document.getElementById("formularioChiste").reset();
    });
}

function saveChiste(){	
    $.ajax({
        type: "POST",
        url: "Controller?op=addChiste",
        data: $("#formularioChiste").serialize(),
        success : function(info) {
            console.log('chiste añadido');
            console.log(info);
            $("#nuevoChiste").append(info);
        }
    });
}

//function saveChiste(){	
//    $("#btnNuevoChiste").click(function (e){
//        console.log('saveChiste');
//        e.preventDefault();
//        var frm = $("#formularioChiste").serialize();
//        $.ajax({
//            type: "POST",
//            url: "Controller?op=addChiste",
//            data: frm,
//            success : function(info) {
//                console.log('chiste añadido');
//                console.log(info);
//                $("#nuevoChiste").append(info);
//                $("#modalChiste").modal("hide");
//                document.getElementById("formularioChiste").reset();
//            }
//        });
//        
//    });
//}


