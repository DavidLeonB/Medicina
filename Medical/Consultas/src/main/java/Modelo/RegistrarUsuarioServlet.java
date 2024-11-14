
package Modelo;

import Modelo.Usuario;
import Modelo.UsuarioDAO;
import Modelo.EPS;
import Modelo.DatabaseConnection; // Asegúrate de importar la clase DatabaseConnection

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegistrarUsuarioServlet")
public class RegistrarUsuarioServlet extends HttpServlet {

    // Método GET: Cargar todas las EPS y redirigir al formulario
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;

        try {
            // Obtener la conexión a la base de datos utilizando DatabaseConnection
            connection = DatabaseConnection.getConnection();

            // Obtener la lista de EPS desde la base de datos
            UsuarioDAO usuarioDAO = new UsuarioDAO(connection);
            List<EPS> epsList = usuarioDAO.obtenerTodasLasEPS();

            // Pasar la lista de EPS al request
            request.setAttribute("epsList", epsList);

            // Redirigir al formulario de registro
            request.getRequestDispatcher("/formularioRegistro.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirigir a una página de error si ocurre algún problema
        } finally {
            // Siempre cerrar la conexión cuando ya no se necesite
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // Método POST: Registrar usuario con los datos del formulario
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;

        try {
            // Obtener la conexión a la base de datos utilizando DatabaseConnection
            connection = DatabaseConnection.getConnection();

            // Obtener los datos del formulario
            String nombre = request.getParameter("txtnombre");
            String apellido = request.getParameter("txtapellido");
            String telefono = request.getParameter("txttelefono");
            String contrasena = request.getParameter("txtcontrasena");
            int idEps = Integer.parseInt(request.getParameter("id_eps")); // ID de la EPS
            int idIps = Integer.parseInt(request.getParameter("id_ips")); // ID de la IPS

            // Crear un objeto Usuario con los datos obtenidos
            Usuario usuario = new Usuario(0, nombre, apellido, telefono, idEps, idIps, contrasena);

            // Crear una instancia de UsuarioDAO y registrar el usuario en la base de datos
            UsuarioDAO usuarioDAO = new UsuarioDAO(connection);
            boolean usuarioRegistrado = usuarioDAO.agregarUsuario(usuario);

            // Redirigir a la página de éxito o error
            if (usuarioRegistrado) {
                response.sendRedirect("registroExitoso.jsp"); // Si el registro fue exitoso
            } else {
                response.sendRedirect("registroError.jsp"); // Si hubo un error en el registro
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirigir a una página de error si ocurre algún problema
        } finally {
            // Siempre cerrar la conexión cuando ya no se necesite
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
