package Modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class Cliente {
    private String id; // Cambia el tipo de id si es necesario (int, String, etc.)
    private String telefono;

    public Cliente(String id) {
        this.id = id;
        this.telefono = "";
    }

    public void actualizarTelefono(String nuevoTelefono) {
        this.telefono = nuevoTelefono;
    }

    public String getTelefono() {
        return telefono;
    }

    public String getId() {
        return id;
    }

    // Método para guardar cambios en la base de datos
    public void guardarEnBaseDeDatos() {
        String url = "jdbc:mysql://localhost:3306/medical"; // Cambia esto
        String usuario = "root"; // Cambia esto
        String contraseña = ""; // Cambia esto

        String sql = "UPDATE usuarios SET telefono = ? WHERE id_usuarios = ?"; // Cambiado aquí

        try (Connection conn = DriverManager.getConnection(url, usuario, contraseña);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, this.telefono);
            stmt.setString(2, this.id); // Asegúrate de que este 'id' coincida con el tipo en la base de datos
            stmt.executeUpdate();
            
            System.out.println("Teléfono actualizado en la base de datos.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        Cliente cliente = new Cliente("2"); // Usa el ID correspondiente
        String nuevoTelefono = "9876";
        
        cliente.actualizarTelefono(nuevoTelefono);
        
        // Guardar en la base de datos
        cliente.guardarEnBaseDeDatos();

        // Verificación
        if (cliente.getTelefono().equals(nuevoTelefono)) {
            System.out.println("Test pasado: El teléfono se actualizó correctamente.");
        } else {
            System.out.println("Test fallido: El teléfono no se actualizó.");
        }
        
        System.out.println("ID del cliente: " + cliente.getId());
    }
}
