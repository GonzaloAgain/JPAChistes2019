<%-- 
    Document   : home
    Created on : 07-feb-2019, 0:12:33
    Author     : Gonzalo
--%>

<%@page import="java.math.BigDecimal"%>
<%@page import="entities.Puntos"%>
<%@page import="entities.Chiste"%>
<%@page import="entities.Categoria"%>
<%@page import="java.util.List"%>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!--Import Google Icon Font-->
    <link href="css/fonts.css" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="css/mycss.css"/>
    

    <title>Hello, world!</title>
  </head>
  <body>
    <% 
          List<Categoria> categorias = (List<Categoria>) session.getAttribute("categorias");
          List<Chiste> chistes = (List<Chiste>) session.getAttribute("chistes");
          String idCategoria = (String)session.getAttribute("idCategoria");
          Boolean viewMejores = (Boolean) session.getAttribute("viewMejores");
          int total = 0;
      %>
    
    <div class="container px-0">
        <header class="text-center">
            <img class="img-fluid" src="img/logo.png" alt="logo" />
        </header>
        <div class="container">
            <div class="row" id="selector">
                <form class="col-sm-12 col-md-6 mt-1" action="Controller" method="post" >
                    <input type="hidden" name="op" value="categoria">
                    <select name="idCategoria" id="selectCategoria" class="custom-select" onchange="this.form.submit()">
                    <option value="" disabled selected>Selecciona Categoría</option>
                    <% 
                        for(Categoria categoria: categorias){
                    %>
                    <option value="<%=categoria.getId() %>"><%=categoria.getNombre() %></option>
                    <%  } %>
                </select>
                </form>
                <div class="col-sm-12 col-md-6 text-center">
                    <button type="button" class="btn btn-link" data-toggle="modal" data-target="#exampleModal">
                        <img src="img/surprise-box.png" />
                    </button>
                    <% 
                        if(viewMejores == false){
                    %>
                            <a class="btn btn-link" href="Controller?op=mejores">Mejores Chistes</a>
                    <%
                        } else {
                    %>
                            <a class="btn btn-link" href="Controller?op=categoria&idCategoria=<%=idCategoria %>">Por categorias</a>
                    <%  } %>
                </div>

            </div>
            <div class="row">
                <div class="col text-center">
                    <button type="button" class="btn btn-link" data-toggle="modal" data-target="#modalChiste">
                        <img src="img/jester.png" />
                    </button>
                </div>
            </div>

            <% 
                if(chistes!=null){
            %>
            <div class="row" id="chistesView">
                <% 
                    for (Chiste chiste: chistes) {
                        List<Puntos> puntos = chiste.getPuntosList();
                        int suma = 0;
                        if (puntos.size()!=0) {
                            for (Puntos punto: puntos) {
                                suma += punto.getPuntos().intValue();
                            }
                            total = suma / puntos.size();   
                        }
                %>
                <div class="col-sm-12 my-2">
                    <h3>
                        <%=chiste.getTitulo() %> (<%=chiste.getIdcategoria().getNombre() %>) 
                        <%
                            for (int i=0; i<total; i++) {   
                        %>
                                    <img src="img/star.png" />
                        <%  }   %>
                    </h3>
                    <h5><%=chiste.getAdopo() %></h5>
                    <p><%=chiste.getDescripcion() %></p>
                    <span class="rating">
                        <a href="Controller?op=votar&puntos=1&idchiste=<%=chiste.getId()%>">&#9733;</a>
                        <a href="Controller?op=votar&puntos=2&idchiste=<%=chiste.getId()%>">&#9733;</a>
                        <a href="Controller?op=votar&puntos=3&idchiste=<%=chiste.getId()%>">&#9733;</a>
                        <a href="Controller?op=votar&puntos=4&idchiste=<%=chiste.getId()%>">&#9733;</a>
                        <a href="Controller?op=votar&puntos=5&idchiste=<%=chiste.getId()%>">&#9733;</a>
                    </span>
                </div>
                <%  
                        total = 0;
                    } 
                %>
            </div>
            <%  } %>
        </div>
        <footer class="text-center py-2">
            <h1>Chistes - Azarquiel</h1>
        </footer>
    </div>
        
    <!-- Modal Añadir Chiste -->
    
        
    <!-- Modal Añadir Chiste -->
    <div class="modal fade" id="modalChiste" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Nuevo Chiste</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <form>
                    <div class="modal-body">
                        <div class="form-group row">
                            <label for="textApodo" class="col-sm-3 col-form-label">Apodo</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="textApodo" >
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="textDescrpcion" class="col-sm-3 col-form-label">Descripción</label>
                            <div class="col-sm-9">
                                <textarea class="form-control" id="textDescripcion"></textarea>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="selectChiste" class="col-sm-3 col-form-label">Categoría</label>
                            <div class="col-sm-9">
                                <select id="selectChiste" class="custom-select">
                                    <option value="" disabled selected>Selecciona Categoría</option>
                                    <% 
                                        for(Categoria categoria: categorias){
                                    %>
                                    <option value="<%=categoria.getId() %>"><%=categoria.getNombre() %></option>
                                    <%  } %>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="textTitulo" class="col-sm-3 col-form-label">Título</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="textTitulo" >
                            </div>
                        </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                            <button type="button" class="btn btn-primary">Guardar</button>
                        </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/myjs.js"></script>
    
    <% 
        if(idCategoria!=null && idCategoria!=""){ 
    %>
            <script type="text/javascript">
                $('#selectCategoria').val('<%= idCategoria %>')
            </script>
    <%  } %>
  </body>
</html>
