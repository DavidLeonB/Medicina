
package Modelo;


public class IPS {
    private int id_ips;          // ID de la IPS
    private String nombre;       // Nombre de la IPS

    // Constructor para inicializar la IPS con su id y nombre
    public IPS(int id_ips, String nombre) {
        this.id_ips = id_ips;
        this.nombre = nombre;
    }

    // Getter para obtener el id de la IPS
    public int getId_ips() {
        return id_ips;
    }

    // Setter para modificar el id de la IPS
    public void setId_ips(int id_ips) {
        this.id_ips = id_ips;
    }

    // Getter para obtener el nombre de la IPS
    public String getNombre() {
        return nombre;
    }

    // Setter para modificar el nombre de la IPS
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
