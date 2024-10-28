

package Modelo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/svLogin")
public class svLogin extends HttpServlet {

    private UsuarioDAO usuarioDAO;

    @Override
    public void init() throws ServletException {
        usuarioDAO = new UsuarioDAO(); // Inicializa el DAO
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String contrasena = request.getParameter("contrasena");

        // Condición para verificar si es admin
        if ("admin".equals(nombre) && "admin".equals(contrasena)) {
            response.sendRedirect("Vistas/formAdmin.jsp"); // Redirigir al formulario de admin
        } else if (usuarioDAO.verificarCredenciales(nombre, contrasena)) {
            response.sendRedirect("Vistas/formCliente.jsp"); // Redirigir al formulario de cliente
        } else {
            response.sendRedirect("Vistas/ErrorCredenciales.jsp"); // Redirigir a página de error
        }
    }
}
