package Modelo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {
    private Connection connection; // Conexión a la base de datos

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/medical", "root", "");
        } catch (Exception e) {
            throw new ServletException("Error al conectar a la base de datos", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String contrasena = request.getParameter("contrasena");

        // Verificar si el usuario es admin
        if ("admin".equals(nombre) && "admin".equals(contrasena)) {
            String mensaje = "Usuario autenticado como administrador: " + nombre;
            request.getSession().setAttribute("mensaje", mensaje); // Guardar en la sesión
            
            // Redirigir a formAdmin.jsp
            response.sendRedirect("Vistas/formAdmin.jsp");
            return; // Salir del método
        }

        try {
            UsuarioDAO usuarioDAO = new UsuarioDAO(connection);
            request.getSession().setAttribute("usuarioDAO", usuarioDAO); // Almacena usuarioDAO en la sesión
            
            // Verificar el usuario y la contraseña
            Usuario usuario = usuarioDAO.verificarUsuario(nombre, contrasena);
            if (usuario != null) {
                String mensaje = "Usuario autenticado: " + usuario.getNombre(); // Mensaje de éxito
                request.getSession().setAttribute("usuario", usuario); // Guardar el usuario en la sesión
                request.getSession().setAttribute("mensaje", mensaje); // Guardar en la sesión
                
                // Redirigir a formCliente.jsp
                response.sendRedirect("Vistas/formCliente.jsp");
            } else {
                String error = "Credenciales inválidas para el usuario: " + nombre; // Mensaje de error
                request.getSession().setAttribute("error", error); // Guardar en la sesión
                
                // Redirigir a ErrorCredenciales.jsp
                response.sendRedirect("Vistas/ErrorCredenciales.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            String error = "Error en la base de datos: " + e.getMessage(); // Mensaje de error de base de datos
            request.getSession().setAttribute("error", error); // Guardar en la sesión
            
            // Redirigir a ErrorCredenciales.jsp
            response.sendRedirect("Vistas/ErrorCredenciales.jsp");
        }
    }

    @Override
    public void destroy() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
