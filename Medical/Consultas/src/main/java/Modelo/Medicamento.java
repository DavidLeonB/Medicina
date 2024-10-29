package Modelo;

public class Medicamento {
    private String nombre;
    private int cantidad;
    private String sede;

    public Medicamento(String nombre, int cantidad, String sede) {
        this.nombre = nombre;
        this.cantidad = cantidad;
        this.sede = sede;
    }

    public String getNombre() {
        return nombre;
    }

    public int getCantidad() {
        return cantidad;
    }

    public String getSede() {
        return sede;
    }
}
