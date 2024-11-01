package Modelo;

public class MedicamentoDosificacion {
    private String medicamento;
    private String dosificacion;

    public MedicamentoDosificacion(String medicamento, String dosificacion) {
        this.medicamento = medicamento;
        this.dosificacion = dosificacion;
    }

    public String getMedicamento() {
        return medicamento;
    }

    public String getDosificacion() {
        return dosificacion;
    }
}
