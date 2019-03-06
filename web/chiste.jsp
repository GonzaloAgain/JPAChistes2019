<%-- 
    Document   : chiste
    Created on : 05-mar-2019, 17:07:08
    Author     : Gonzalo
--%>

<%@page import="java.util.List"%>
<%@page import="entities.Puntos"%>
<%@page import="entities.Chiste"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    Chiste chiste = (Chiste) request.getAttribute("chiste");
    int total = 0;

    List<Puntos> puntos = chiste.getPuntosList();
    int suma = 0;
    if (puntos.size()!=0) {
        for (Puntos punto: puntos) {
            suma += punto.getPuntos().intValue();
        }
        total = suma / puntos.size();   
    }
%>

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
