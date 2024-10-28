
package Modelo;

import java.sql.Connection; // Importa la clase Connection para manejar conexiones a la base de datos
import java.sql.DriverManager; // Importa DriverManager para establecer la conexión
import java.sql.SQLException; // Importa SQLException para manejar errores de SQL

public class Conexion {
    private static final String URL = "jdbc:mysql://localhost:3306/medical"; // URL de la base de datos
    private static final String USER = "root"; // Usuario de la base de datos
    private static final String PASSWORD = ""; // Contraseña de la base de datos

    public static Connection obtenerConexion() {
        Connection connection = null; // Inicializa la conexión como nula
        try {
            connection = DriverManager.getConnection(URL, USER, PASSWORD); // Intenta establecer la conexión
            System.out.println("Conexión exitosa a la base de datos."); // Mensaje de éxito
        } catch (SQLException e) {
            System.err.println("Error al establecer la conexión: " + e.getMessage()); // Mensaje de error
        }
        return connection; // Retorna la conexión (puede ser nula si hubo un error)
    }

    public static void cerrarConexion(Connection connection) {
        if (connection != null) {
            try {
                connection.close(); // Cierra la conexión
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
