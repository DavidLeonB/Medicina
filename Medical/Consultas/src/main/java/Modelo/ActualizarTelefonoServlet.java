package Modelo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;

@WebServlet("/Consultas/actualizarTelefono")
public class ActualizarTelefonoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID del usuario logueado
        int idUsuario = Integer.parseInt(request.getParameter("id_usuarios"));
        String nuevoTelefono = request.getParameter("telefono");

        // Establecer la conexión a la base de datos
        Connection connection = null; // Asegúrate de obtener la conexión correctamente
        try {
            connection = DatabaseConnection.getConnection(); // Método para obtener conexión
            UsuarioDAO usuarioDAO = new UsuarioDAO(connection);

            // Actualizar el teléfono
            boolean actualizado = usuarioDAO.actualizarTelefonoPorId(idUsuario, nuevoTelefono);
            if (actualizado) {
                response.getWriter().write("Teléfono actualizado con éxito.");
            } else {
                response.getWriter().write("Error al actualizar el teléfono.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Se produjo un error: " + e.getMessage());
        } finally {
            // Cerrar la conexión si fue abierta
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
