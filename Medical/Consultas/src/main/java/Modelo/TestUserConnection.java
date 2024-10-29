package Modelo;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

public class TestUserConnection {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.print("Ingrese el nombre de usuario: ");
        String nombre = scanner.nextLine();
        
        System.out.print("Ingrese la contraseña: ");
        String contrasena = scanner.nextLine();

        try (Connection connection = DatabaseConnection.getConnection()) {
            System.out.println("Conexión establecida correctamente.");

            UsuarioDAO usuarioDAO = new UsuarioDAO(connection);
            Usuario usuario = usuarioDAO.verificarUsuario(nombre, contrasena);

            if (usuario != null) {
                System.out.println("Usuario autenticado: " + usuario.getNombre());
            } else {
                System.out.println("Credenciales inválidas para el usuario: " + nombre);
            }
        } catch (SQLException e) {
            System.out.println("Error de conexión a la base de datos.");
            e.printStackTrace();
        } finally {
            scanner.close(); // Cerrar el escáner
        }
    }
}
