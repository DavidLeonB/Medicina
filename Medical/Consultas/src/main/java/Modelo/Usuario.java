package Modelo; // Declara el paquete donde se encuentra la clase

// Clase que representa a un usuario del sistema
public class Usuario {
    // Atributos privados para almacenar el nombre y la contraseña del usuario
    private String nombre; // Nombre del usuario
    private String contrasena; // Contraseña del usuario

    // Constructor de la clase Usuario
    public Usuario(String nombre, String contrasena) {
        this.nombre = nombre; // Inicializa el atributo nombre con el valor pasado
        this.contrasena = contrasena; // Inicializa el atributo contrasena con el valor pasado
    }

    // Método para obtener el nombre del usuario
    public String getNombre() {
        return nombre; // Retorna el nombre del usuario
    }

    // Método para obtener la contraseña del usuario
    public String getContrasena() {
        return contrasena; // Retorna la contraseña del usuario
    }
}
