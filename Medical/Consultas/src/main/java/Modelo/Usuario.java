package Modelo;

public class Usuario {
    private int id; // ID del usuario
    private String nombre; // Nombre del usuario
    private String apellido; // Apellido del usuario
    private String telefono; // Teléfono del usuario
    private int id_eps; // ID de la EPS
    private int id_ips; // ID de la IPS
    private String contrasena; // Contraseña del usuario

    // Constructor
    public Usuario(int id, String nombre, String apellido, String telefono, int id_eps, int id_ips, String contrasena) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.telefono = telefono;
        this.id_eps = id_eps;
        this.id_ips = id_ips;
        this.contrasena = contrasena;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public int getIdEPS() {
        return id_eps;
    }

    public void setIdEPS(int id_eps) {
        this.id_eps = id_eps;
    }

    public int getIdIPS() {
        return id_ips;
    }

    public void setIdIPS(int id_ips) {
        this.id_ips = id_ips;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }
}
