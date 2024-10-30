package Modelo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.json.JSONObject; // Asegúrate de tener la biblioteca JSON en tu proyecto

@WebServlet("/TelefonoServlet")
public class TelefonoServlet extends HttpServlet {
    private Connection connection;

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
        response.setContentType("application/json"); // Establecer el tipo de contenido
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject(); // Crear un objeto JSON para la respuesta

        int idUsuario;
        String nuevoTelefono;

        try {
            idUsuario = Integer.parseInt(request.getParameter("id_usuarios"));
            nuevoTelefono = request.getParameter("telefono");

            UsuarioDAO usuarioDAO = new UsuarioDAO(connection);
            boolean actualizado = usuarioDAO.actualizarTelefonoPorId(idUsuario, nuevoTelefono);

            if (actualizado) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Teléfono actualizado con éxito.");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Error al actualizar el teléfono.");
            }
        } catch (NumberFormatException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "ID de usuario inválido.");
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error al actualizar el teléfono: " + e.getMessage());
        }

        out.print(jsonResponse); // Enviar la respuesta JSON
        out.flush(); // Asegurarse de que se envíe la respuesta
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
