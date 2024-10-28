package Modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/medical";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public Usuario verificarCredenciales(String nombre, String contrasena) {
        String sql = "SELECT * FROM usuarios WHERE nombre = ? AND contrasena = ?";
        Usuario usuario = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                 
                stmt.setString(1, nombre);
                stmt.setString(2, contrasena);
                ResultSet rs = stmt.executeQuery();
                
                if (rs.next()) {
                    usuario = new Usuario(rs.getString("nombre"), rs.getString("contrasena")); // Ajusta si tienes más campos
                }
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return usuario;
    }
}
