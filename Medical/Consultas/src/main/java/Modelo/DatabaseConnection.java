package Modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/medical"; // Nombre de tu base de datos
    private static final String USER = "root"; // Usuario
    private static final String PASSWORD = ""; // Contraseña

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

