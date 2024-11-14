
package Modelo;


public class EPS {
    private int id_eps;          // ID de la EPS
    private String nombre;       // Nombre de la EPS

    // Constructor para inicializar la EPS con su id y nombre
    public EPS(int id_eps, String nombre) {
        this.id_eps = id_eps;
        this.nombre = nombre;
    }

    // Getter para obtener el id de la EPS
    public int getId_eps() {
        return id_eps;
    }

    // Setter para modificar el id de la EPS
    public void setId_eps(int id_eps) {
        this.id_eps = id_eps;
    }

    // Getter para obtener el nombre de la EPS
    public String getNombre() {
        return nombre;
    }

    // Setter para modificar el nombre de la EPS
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}

