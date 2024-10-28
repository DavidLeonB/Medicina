/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author Martha Liliana León
 */
import java.sql.Connection;

public class TestConexion {
    public static void main(String[] args) {
        Connection conn = null; // Inicializa la conexión como nula
        try {
            conn = Conexion.obtenerConexion(); // Prueba de conexión
            if (conn != null) {
                System.out.println("Conexión exitosa a la base de datos."); // Mensaje de éxito
            } else {
                System.out.println("Falló la conexión a la base de datos."); // Mensaje de fallo
            }
        } catch (Exception e) {
            e.printStackTrace(); // Imprime cualquier excepción
        } finally {
            if (conn != null) {
                try {
                    conn.close(); // Asegura que se cierre la conexión
                    System.out.println("Conexión cerrada.");
                } catch (Exception e) {
                    e.printStackTrace(); // Imprime cualquier error al cerrar
                }
            }
        }
    }
}
