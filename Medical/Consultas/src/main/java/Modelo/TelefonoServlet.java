package Modelo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/TelefonoServlet")
public class TelefonoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String nuevoTelefono = request.getParameter("nuevoTelefono");
        String idUsuario = request.getParameter("idUsuario");

        String url = "jdbc:mysql://localhost:3306/medical"; // Cambia esto
        String usuario = "root"; // Cambia esto
        String contraseña = ""; // Cambia esto

        String sql = "UPDATE usuarios SET telefono = ? WHERE id_usuarios = ?";

        try (Connection conn = DriverManager.getConnection(url, usuario, contraseña);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, nuevoTelefono);
            stmt.setString(2, idUsuario);
            int filasActualizadas = stmt.executeUpdate();
            
            if (filasActualizadas > 0) {
                response.getWriter().write("Teléfono actualizado correctamente.");
            } else {
                response.getWriter().write("Error al actualizar el teléfono.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error al conectar con la base de datos.");
        }
    }
}