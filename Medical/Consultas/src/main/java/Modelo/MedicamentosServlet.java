
package Modelo;

import Modelo.MedicamentoDosificacion;
import Modelo.UsuarioDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/medicamentos")
public class MedicamentosServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId")); // Obtener userId de los parámetros de la solicitud
        
        // Establecer la conexión a la base de datos
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/medical", "root", "")) {
            // Crear instancia de UsuarioDAO con la conexión
            UsuarioDAO usuarioDao = new UsuarioDAO(conn);
            List<MedicamentoDosificacion> dosificaciones = usuarioDao.obtenerMedicamentosYDosificaciones(userId);
request.setAttribute("dosificaciones", dosificaciones);
request.getRequestDispatcher("tuVista.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace(); // Manejar excepciones adecuadamente
        }

        // Redirigir a la vista JSP
        request.getRequestDispatcher("tuVista.jsp").forward(request, response);
    }
}
