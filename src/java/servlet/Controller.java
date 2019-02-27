/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import entities.Categoria;
import entities.Chiste;
import entities.Puntos;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jpautil.JPAUtil;

/**
 *
 * @author Gonzalo
 */
@WebServlet(name = "Controller", urlPatterns = {"/Controller"})
public class Controller extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        RequestDispatcher dispatcher;
        
        String op;
        String sql;
        Query query;
        EntityManager em = null;
        
        if (em == null) {
            em = JPAUtil.getEntityManagerFactory().createEntityManager();
            session.setAttribute("em", em);
        }
        
        op = request.getParameter("op");
        
        if (op.equals("inicio")) {
            query = em.createNamedQuery("Categoria.findAll");
            List<Categoria> categorias = query.getResultList();           
            session.setAttribute("categorias",categorias);
            session.setAttribute("viewMejores",false);
            
        } else if(op.equals("categoria")){
            String idcategoria = request.getParameter("idCategoria");
            List <Chiste> chistes = null;
            if (!idcategoria.equals("")) {
                sql = "select c from Chiste c where c.idcategoria.id = :id";
                query = em.createQuery(sql);
                query.setParameter("id",Short.parseShort(idcategoria));
                chistes = query.getResultList();  
            }
            
            session.setAttribute("chistes",chistes);
            session.setAttribute("idCategoria",idcategoria);
            session.setAttribute("viewMejores",false);
            
        } else if(op.equals("mejores")){
            sql = "select p.idchiste from Puntos p group by p.idchiste order by avg(p.puntos) DESC";
            query = em.createQuery(sql);
            List <Chiste> chistes = query.getResultList();
            
            session.setAttribute("chistes",chistes);
            session.setAttribute("viewMejores",true);
            
        } else if(op.equals("votar")){
            
            BigDecimal puntos = BigDecimal.valueOf(Double.parseDouble(request.getParameter("puntos")));
            String idchiste = request.getParameter("idchiste");
            Chiste chiste = em.find(Chiste.class, Short.parseShort(idchiste));
            
            Puntos votacion = new Puntos();
            votacion.setIdchiste(chiste);
            votacion.setPuntos(puntos);
            
            em.getTransaction().begin();
            em.persist(votacion);
            em.getTransaction().commit();
            em.getEntityManagerFactory().getCache().evictAll();
            
            Boolean mejores = (Boolean) session.getAttribute("viewMejores");
            List <Chiste> chistes = null;
            
            if (mejores == false) {
                String idcategoria = (String) session.getAttribute("idCategoria");
                if (!idcategoria.equals("")) {
                    sql = "select c from Chiste c where c.idcategoria.id = :id";
                    query = em.createQuery(sql);
                    query.setParameter("id",Short.parseShort(idcategoria));
                    chistes = query.getResultList();
                    
                } 
            } else {
                sql = "select p.idchiste from Puntos p group by p.idchiste order by avg(p.puntos) DESC";
                query = em.createQuery(sql);
                chistes = query.getResultList();
                    
            }

            session.setAttribute("chistes",chistes);
        }
        
        dispatcher = request.getRequestDispatcher("home.jsp");
        dispatcher.forward(request, response);
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
