
package Modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/medical";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public boolean verificarCredenciales(String nombre, String contrasena) {
        boolean valido = false;
        String sql = "SELECT * FROM usuarios WHERE nombre = ? AND contrasena = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                 
                stmt.setString(1, nombre);
                stmt.setString(2, contrasena);
                ResultSet rs = stmt.executeQuery();
                
                valido = rs.next(); 
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return valido;
    }
}
