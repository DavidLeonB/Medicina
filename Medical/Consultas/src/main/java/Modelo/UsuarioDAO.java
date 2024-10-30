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

    // Método para obtener el nombre de la EPS a partir de su ID.
    public String obtenerNombreEPS(int id_eps) {
        String sql = "SELECT nombre FROM eps WHERE id_eps = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id_eps);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("nombre");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Retornar null si no se encuentra
    }

    // Método para obtener el nombre de la IPS a partir de su ID.
    public String obtenerNombreIPS(int id_ips) {
        String sql = "SELECT nombre FROM ips WHERE id_ips = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id_ips);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("nombre");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Retornar null si no se encuentra
    }

    // Método para actualizar un usuario
    public boolean actualizarUsuario(Usuario usuario) {
        String sql = "UPDATE usuarios SET nombre = ?, apellido = ?, telefono = ?, id_eps = ?, id_ips = ?, contrasena = ? WHERE id_usuarios = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, usuario.getNombre());
            stmt.setString(2, usuario.getApellido());
            stmt.setString(3, usuario.getTelefono());
            stmt.setInt(4, usuario.getIdEPS());
            stmt.setInt(5, usuario.getIdIPS());
            stmt.setString(6, usuario.getContrasena());
            stmt.setInt(7, usuario.getId());
            return stmt.executeUpdate() > 0; // Retorna true si se actualizó al menos una fila
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Retornar false si hubo error
        }
    }

    // Método para eliminar un usuario
    public boolean eliminarUsuario(int id) {
        String sql = "DELETE FROM usuarios WHERE id_usuarios = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0; // Retorna true si se eliminó al menos una fila
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Retornar false si hubo error
        }
    }

  // Método para actualizar el teléfono por ID
    public boolean actualizarTelefonoPorId(int idUsuario, String nuevoTelefono) {
        String sql = "UPDATE usuarios SET telefono = ? WHERE id_usuarios = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, nuevoTelefono);
            pstmt.setInt(2, idUsuario);
            return pstmt.executeUpdate() > 0; // Retorna true si se actualizó al menos una fila
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Retornar false si hubo un error
        }
    }
    
  // Método para buscar un usuario por ID
    public Usuario buscarUsuarioPorId(int idUsuario) {
        String sql = "SELECT * FROM usuarios WHERE id_usuarios = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, idUsuario);
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
}

