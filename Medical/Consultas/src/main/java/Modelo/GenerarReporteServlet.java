package Modelo;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import com.google.zxing.*;
import com.google.zxing.client.j2se.*;
import com.google.zxing.common.BitMatrix;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.text.*;
import java.util.*;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;

@WebServlet("/GenerarReporteServlet")
public class GenerarReporteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los parámetros del formulario
        String nombreUsuario = request.getParameter("nombreUsuario");
        String apellidoUsuario = request.getParameter("apellidoUsuario");
        String tipoPago = request.getParameter("tipoPago");  // "PSE" o "Efectivo"
        String eps = request.getParameter("Eps");
        String ips = request.getParameter("Dispensador");

        // Medicamentos, dosificación y estado
        String[] medicamentos = new String[] {
            request.getParameter("medicamento1"),
            request.getParameter("medicamento2"),
            request.getParameter("medicamento3")
        };

        String[] dosificaciones = new String[] {
            request.getParameter("dosificacion1"),
            request.getParameter("dosificacion2"),
            request.getParameter("dosificacion3")
        };

        String[] estados = new String[] {
            request.getParameter("estado1"),
            request.getParameter("estado2"),
            request.getParameter("estado3")
        };

        // Crear el documento PDF dentro del try-with-resources
        try (PDDocument document = new PDDocument()) {
            PDPage page = new PDPage();
            document.addPage(page);

            // Crear el contenido para la página dentro del try-with-resources
            try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
                contentStream.setFont(PDType1Font.COURIER, 14);  // Títulos en negrita para destacar

                // Obtener la fecha actual
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String fechaSistema = sdf.format(new Date());

                // Escribir el título y la fecha
                contentStream.beginText();
                contentStream.newLineAtOffset(100, 750);
                contentStream.showText("Reporte de Medicamentos");
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Fecha: " + fechaSistema);
                contentStream.endText();

                // Espacio para los datos del usuario
                contentStream.beginText();
                contentStream.newLineAtOffset(100, 680);
                contentStream.showText("Usuario: " + nombreUsuario + " " + apellidoUsuario);
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("EPS: " + eps);
                contentStream.newLineAtOffset(0, -20);
                contentStream.showText("Dispensador Med: " + ips);
                contentStream.endText();

                // Espacio para los medicamentos
                contentStream.beginText();
                contentStream.newLineAtOffset(100, 580);
                contentStream.showText("Medicamentos:");
                contentStream.endText();

                int yOffset = 560;
                for (int i = 0; i < medicamentos.length; i++) {
                    if (medicamentos[i] != null && !medicamentos[i].isEmpty()) {
                        contentStream.beginText();
                        contentStream.newLineAtOffset(100, yOffset);
                        contentStream.showText("Medicamento #" + (i + 1) + ": " + medicamentos[i]);
                        contentStream.newLineAtOffset(0, -20);
                        contentStream.showText("Dosificación: " + dosificaciones[i]);
                        contentStream.newLineAtOffset(0, -20);
                        contentStream.showText("Estado: " + estados[i]);
                        contentStream.endText();
                        yOffset -= 60;  // Ajusta la separación de los medicamentos
                    }
                }

                // Espacio para el tipo de pago y la fecha máxima de entrega
                contentStream.beginText();
                contentStream.newLineAtOffset(100, yOffset - 20);
                contentStream.showText("Tipo de pago: " + tipoPago);
                contentStream.newLineAtOffset(0, -20);

                // Calcular la fecha máxima de entrega
                String fechaMaxima = fechaSistema;
                if ("PSE".equals(tipoPago)) {
                    Calendar calendar = Calendar.getInstance();
                    calendar.add(Calendar.HOUR, 72);  // Agregar 72 horas si es PSE
                    fechaMaxima = sdf.format(calendar.getTime());
                } else if ("Efectivo".equals(tipoPago)) {
                    Calendar calendar = Calendar.getInstance();
                    calendar.add(Calendar.HOUR, 24);  // Agregar 24 horas si es Efectivo
                    fechaMaxima = sdf.format(calendar.getTime());
                }

                // Escribir la fecha máxima de entrega en el PDF
                contentStream.showText("Fecha máxima de entrega: " + fechaMaxima);
                contentStream.endText();

                // Generar el QR y agregarlo al PDF
                try {
                    // Ruta fija donde se guardará el QR
                    String rutaQR = getServletContext().getRealPath("/img/qr_code.png");

                    // Crear el archivo QR en la ruta configurada
                    File qrFile = new File(rutaQR);
                    
                    // Generar el código QR y guardarlo
                    generateQRCode("https://ejemplos.com/seguimientos", qrFile);

                    // Cargar la imagen del QR en el PDF
                    PDImageXObject pdImage = PDImageXObject.createFromFileByContent(qrFile, document);
                    contentStream.drawImage(pdImage, 400, 620, 150, 150);  // Ajusta el tamaño del QR (150x150)
                } catch (Exception e) {
                    e.printStackTrace();  // Captura cualquier excepción y muestra el error
                }

            } catch (IOException e) {
                e.printStackTrace();  // Aquí capturamos el error y lo mostramos en la consola
            }

            // Enviar el PDF como respuesta
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=Reporte.pdf");
            document.save(response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();  // Captura cualquier excepción relacionada con la creación del PDF y muestra el error
        }
    }

    // Método para generar un código QR usando ZXing
    private static void generateQRCode(String data, File file) throws Exception {
        int size = 150;  // Tamaño del código QR
        BitMatrix matrix = new MultiFormatWriter().encode(data, BarcodeFormat.QR_CODE, size, size);
        Path path = file.toPath();
        MatrixToImageWriter.writeToPath(matrix, "PNG", path);
    }
}

