package Modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {
    private Connection connection; // Conexión a la base de datos

    // Constructor que establece la conexión
    public UsuarioDAO(Connection connection) {
        this.connection = connection;
    }

    // Método para agregar un nuevo usuario a la base de datos
    public boolean agregarUsuario(Usuario usuario) {
        String sql = "INSERT INTO usuarios (nombre, apellido, telefono, id_eps, id_ips, contrasena) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, usuario.getNombre());
            stmt.setString(2, usuario.getApellido());
            stmt.setString(3, usuario.getTelefono());
            stmt.setInt(4, usuario.getIdEPS());
            stmt.setInt(5, usuario.getIdIPS());
            stmt.setString(6, usuario.getContrasena());
            return stmt.executeUpdate() > 0; // Retorna true si se insertó al menos una fila
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Retornar false si hubo error
        }
    }

    // Método para buscar un usuario por su nombre
    public Usuario buscarUsuarioPorNombre(String nombre) {
        String sql = "SELECT * FROM usuarios WHERE nombre = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, nombre);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Usuario(
                    rs.getInt("id_usuarios"),
                    rs.getString("nombre"),
                    rs.getString("apellido"),
                    rs.getString("telefono"),
                    rs.getInt("id_eps"),
                    rs.getInt("id_ips"),
                    rs.getString("contrasena")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Retornar null si no se encontró el usuario
    }

    // Método para verificar usuario y contraseña
    public Usuario verificarUsuario(String nombre, String contrasena) {
        String sql = "SELECT * FROM usuarios WHERE nombre = ? AND contrasena = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, nombre);
            stmt.setString(2, contrasena);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Usuario(
                    rs.getInt("id_usuarios"),
                    rs.getString("nombre"),
                    rs.getString("apellido"),
                    rs.getString("telefono"),
                    rs.getInt("id_eps"),
                    rs.getInt("id_ips"),
                    rs.getString("contrasena")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Devolver null si no se encuentra el usuario o si ocurre un error
    }
}
