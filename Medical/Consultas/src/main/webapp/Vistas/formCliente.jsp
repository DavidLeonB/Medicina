<%@page import="java.util.ArrayList"%> 
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@ page import="Modelo.Usuario" %>
<%@ page import="Modelo.UsuarioDAO" %>
<%@ page import="Modelo.MedicamentoDosificacion" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Obtener el objeto UsuarioDAO de la sesión
    UsuarioDAO usuarioDAO = (UsuarioDAO) session.getAttribute("usuarioDAO");
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    List<MedicamentoDosificacion> dosificaciones = null;

    // Verificar que usuarioDAO no sea null
    if (usuarioDAO != null && usuario != null) {
        dosificaciones = usuarioDAO.obtenerMedicamentosYDosificaciones(usuario.getId());
    } else {
        out.println("<p>Error: No se pudo obtener el DAO del usuario.</p>");
    }
%>




<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="Styles/style.css" />
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

        <style>


            body {
                height: 100vh;
                background-image: url("../img/medical3.jpg");
                background-size: cover;
            }

            .saludo {
                margin-bottom: 15px;

            }



            .btnSaludo{

                margin: 10px;
                background-color: rgba(128, 128, 128 0.6);
                border:#0315af;
                display: flex;
                align-content: center;
                align-items: center;
                width: 600px;
                justify-content: space-around

            }

            .perfil {
                display: flex;
                justify-content: space-between;
                padding: 20px;
                border-radius: 20px;
                border: #0315af solid 2px;
                margin-bottom: 10px;
                background-color: rgba(176,196,222,0.5);
            }



            .medicamento {
                display: flex;
                border-radius: 15px;
                box-sizing: border-box; /* Para incluir padding y border en el ancho total */
                padding: 10px;
            }


            .areaConsulta {
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                padding: 20px;
                border-radius: 20px;
                border: #0315af solid 2px;
                margin-bottom: 10px;
                background-color: rgba(176,196,222,0.5);
            }

            .datos {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 10px;
                flex: 2;
            }

            .actualizaciones {
                width: 30%;
                display: flex;
                justify-content: center;
                margin: 15px;
                border-radius: 20px;
                border: 2px solid yellow;
            }

            .acciones {
                width: 90%;
                display: flex;
                flex-direction: column;
                justify-content: space-around;
                align-items: center;
            }

            .acciones input {
                width: 90%;
                margin: 0 10px;
            }

            .consmedica {
                display: flex;
                flex-direction: row;
                align-content: center;
                flex-direction: column;
                align-items: center;
                margin-bottom: 10px;

            }


            .container_btn {
                display: flex;
                padding: 15px;
                justify-content: space-around;
                align-items: center;
                border-radius: 20px;
                height: 80px;
                max-width: 100%;
                transition: all 1s ease;
                border: 2px solid #0315af;
                margin: 5px;
                background-color: rgba(176,196,222,0.5);
            }

            .consultas{
                width: 90%;
                display: flex;
                justify-content: space-around;

            }




            .logopse{
                width: 40px;
                height: 40px;
            }

            .efectivo i{
                font-size: 40px;
                color: green
            }

            .datos input,
            .container_perfil input {
                width: 95%;
                height: 60px;
                font-size: 1rem;
                border-radius: 20px;
                text-align: center;
                border: 2px solid #0315af;
            }

            .saludo input{

                width: 30%;
                height: 60px;
                margin: 10px;
                font-size: 1rem;
                border-radius: 20px;
                text-align: center;
                border: 2px solid #0315af;
            }

            input {
                width: 30%;
                height: 60px;
                font-size: 1rem;
                border-radius: 20px;
                text-align: center;
                border: solid thin #0315af;
            }

            .sede{
                width: 80%;
                padding: 5px;

            }

            .med {
                display: flex;
                flex-direction: column;
                width: 100%;
                align-items: center;
                margin-bottom: 20px;
                margin: 5px;
                border: 1.2px solid white;
                padding: 15px;
                border-radius: 20px;
                background-color: transparent;
                padding: 5px;
                gap: 20px;
            }


            .med p{
                margin: 5px;
            }

            .med input {
                margin-right: 20px;
            }

            .med input {
                width: 95%;
                height: 40px;
                font-size: 1rem;
                border-radius: 20px;
                text-align: center;
                border: 2px solid #0315af;
            }
            .pagos{
                display: flex;
                align-items: center;
                justify-items: center;
                border-radius: 15px;
                padding: 5px;
                margin: 20px;
                border: red solid 1.4px;
            }

            /* Estilo para los elementos PSE y Efectivo */
            .pse {
                display: flex !important;
                justify-content: flex-start !important;
                align-items: center !important;
                border: blue solid 1.5px !important;
                border-radius: 15px;
                margin: 10px !important;
                padding: 5px !important;
            }

            .efectivo {
                display: flex !important;
                justify-content: flex-start !important;
                align-items: center !important;
                border: blue solid 1.5px !important;
                border-radius: 15px;
                margin: 10px !important;
                padding: 5px !important;
            }

            /* Clase para ocultar elementos */
            .ocultar {
                display: none !important;
            }


            .pse input, .efectivo input{
                width: 60%;
            }

            .container_btn input,
            .saludo input,
            .actualizaciones input {
                background-color: rgba(128, 128, 128 0.6);
                border: #0315af solid 2px;
            }

            .pse input:hover,
            .efectivo input:hover,
            .consultas input:hover,
            .container_btn input:hover,
            .actualizaciones input:hover,
            .btnSaludo input:hover {
                background-color: aqua;
                border: var(--azul_oscuro);
                color: #0315af;
                font-size: 1.1rem;
                box-shadow: 10px 10px 10px rgba(83, 87, 100, 0.4);
            }


        </style>
        <title>Bienvenida Cliente</title>
    </head>
    <body>


        <div class="saludo" id="saludo">

            <h1>Bienvenido, <%= usuario.getNombre()%> <%= usuario.getApellido()%></h1>  
            <h3>Estamos felices de que estés con nosotros, aquí puedes Consultar, Generar, Separar tus medicamentos.</h3>




        </div>
        <div class="btnSaludo">
            <input class="perfil" type="button" id="btnPerfil" value="Perfil">
            <input class="areaConsulta" type="button" id="btnConsultar" value="Consultar Medicina">
        </div>
        <div class="perfil" id="perfil" style="display: none;">
            <div class="datos">
                <div>
                    <p>Nombre</p>
                    <input type="text" value="<%= usuario.getNombre()%> " name="txtnombre" disabled />
                </div>
                <div>
                    <p>Apellido</p>
                    <input type="text" value="<%= usuario.getApellido()%>" name="txtapellido" disabled />
                </div>
                <div>
                    <p>Teléfono</p>
                    <input type="text" value="<%= usuario.getTelefono()%>" name="txttelefono" id="txttelefono" disabled />
                </div>
                <div>
                    <p>EPS</p>
                    <input type="text" value="<%= usuarioDAO.obtenerNombreEPS(usuario.getIdEPS())%>" name="txteps" disabled />
                </div>
                <div>
                    <p>Dispensador de Medicina</p>
                    <input type="text" value="<%= usuarioDAO.obtenerNombreIPS(usuario.getIdIPS())%>" name="txtips" disabled />
                </div>
            </div>

            <div class="actualizaciones">
                <div class="acciones">
                    <input class="actualizar" type="button" value="Actualizar Datos" onclick="habilitarInputs()" />
                    <input class="guardarCambios" type="button" value="Guardar Cambios" onclick="guardarCambios()" />
                    <input class="cerrarSesion" type="button" id="btnCerrarSesion" value="Cerrar Sesión" />
                </div>
            </div>
        </div>

        <div class="areaConsulta" id="areaConsulta" style="display: none;">

            <div class="consmedica">                

                <%
                    // Definición de nombres de las sedes en una lista para poder eliminar elementos
                    List<String> nombresSedes = new ArrayList<>();
                    nombresSedes.add("Sede San Mateo");
                    nombresSedes.add("Sede Bosa");
                    nombresSedes.add("Sede Kennedy");
                    nombresSedes.add("Sede Americas");
                    nombresSedes.add("Sede 20 de Julio");
                    nombresSedes.add("Sede Teuaquillo");
                    nombresSedes.add("Sede Chapinero");
                    nombresSedes.add("Sede Portal 80");
                    nombresSedes.add("Sede Chico");
                    nombresSedes.add("Sede Boulevar");
                    nombresSedes.add("Sede Usaquen");
                    nombresSedes.add("Sede Suba I");
                    nombresSedes.add("Sede Suba II");
                    nombresSedes.add("Sede Toberin");
                    nombresSedes.add("Sede Usme");

                    // Definición de colores para el fondo y el borde
                    String[] coloresBorde = {"#3357FF"};
                    // String[] coloresBorde = {"#FF5733", "#33FF57", "#3357FF", "#F1C40F", "#8E44AD"};

                    // Bucle para repetir el proceso 2 veces, sin repetir sedes
                    for (int i = 0; i < 2; i++) {
                        // Selección aleatoria de una sede
                        int index = (int) (Math.random() * nombresSedes.size());
                        String nombreSede = nombresSedes.get(index);

                        // Eliminar la sede seleccionada para que no se repita
                        nombresSedes.remove(index);
                %>

                <div class="sede">
                    <!-- Mostrar el nombre de la sede seleccionada -->
                    <h3><strong><%= nombreSede%></strong> </h3>

                    <div class="med">
                        <%
                            int medicamentoindex = 1;
                            String[] estadosMed = {"Disponible", "Disponible", "Disponible", "Disponible", "Disponible", "Disponible", "Disponible", "Disponible", "Disponible", "Agotado"};

                            if (dosificaciones != null && !dosificaciones.isEmpty()) {

                                for (MedicamentoDosificacion dos : dosificaciones) {
                                    String colorBorde = coloresBorde[(int) (Math.random() * coloresBorde.length)];
                                    String estado = estadosMed[(int) (Math.random() * estadosMed.length)];
                        %>
                        <div class="medicamento" style="border: 2px solid <%= colorBorde%>;">
                            <p><strong>Medicamento:</strong></p>
                            <input type="text" value="<%= dos.getMedicamento()%>" name="med<%= medicamentoindex%>" disabled />
                            <p><strong>Dosificación:</strong></p>
                            <input type="text" value="<%= dos.getDosificacion()%>" name="cant<%= medicamentoindex%>" disabled />
                            <p><strong>Estado:</strong></p>
                            <input type="text" value="<%= estado%>" name="estado<%= medicamentoindex%>" disabled />
                        </div>
                        <%
                                }
                            } else {
                                out.println("<script>alert('Error: La lista de dosificaciones es nula.');</script>");
                                out.println("<p>No se registra medicación para el usuario.</p>");
                            }
                        %>

                        <div class="pagos" id="pagos<%= i%>" style="display: none;">
                            <div class="pse" id="psePago<%= i%>" style="display: block;">
                                <p>En esta opción el usuario tiene 72 horas para reclamar su medicamento. En caso de no hacerlo se hará la devolución del dinero.</p>
                                <img class="logopse" src="../img/pse.svg" alt=""/>
                                <input class="digital" type="button" value="PSE" onclick="seleccionarPago('PSE', <%= i%>)" />
                            </div>
                            <div class="efectivo" id="efectivoPago<%= i%>" style="display: block;">
                                <p>Esta opción es solo informativa, ya que el usuario debe acercarse a la sede lo antes posible para que el estado de la medicina no cambie.</p>
                                <i class='bx bx-money-withdraw'></i>
                                <input class="cash" type="button" value="Efectivo" onclick="seleccionarPago('Efectivo', <%= i%>)" />
                            </div>
                        </div>

                        <!-- Sección de botones -->
                        <div class="consultas" style="text-align: center;">
                            <input class="separar" type="button" value="Pago Medicamentos" id="btnSeparar<%= i%>" onclick="activarPagos('<%= i%>')" />
                            <input class="generar" type="button" value="Generar Reporte" id="btnGenerar<%= i%>" style="display: none;" onclick="generarReporte('<%= i%>')" />
                        </div>

                        <!-- Formulario oculto para enviar datos del tipo de pago -->
                        <form id="formGenerarReporte<%= i%>" action="/Consultas/GenerarReporteServlet" method="post" style="display:none;">
                            <input type="hidden" name="nombreUsuario" value="<%= usuario.getNombre()%>">
                            <input type="hidden" name="apellidoUsuario" value="<%= usuario.getApellido()%>">
                            <input type="hidden" name="Eps" value="<%= usuarioDAO.obtenerNombreEPS(usuario.getIdEPS())%>">
                            <input type="hidden" name="Dispensador" value="<%= usuarioDAO.obtenerNombreIPS(usuario.getIdIPS())%>">
                            <input type="hidden" name="tipoPago" id="tipoPago<%= i%>" value="">

                            <% for (int j = 1; j <= dosificaciones.size(); j++) {%>
                            <input type="hidden" name="medicamento<%= j%>" value="<%= dosificaciones.get(j - 1).getMedicamento()%>">
                            <input type="hidden" name="dosificacion<%= j%>" value="<%= dosificaciones.get(j - 1).getDosificacion()%>">
                            <input type="hidden" name="estado<%= j%>" value="<%= estadosMed[(int) (Math.random() * estadosMed.length)]%>">
                            <% }%>

                            <button type="submit" id="btnGenerar<%= i%>" style="display: none;">Generar Reporte PDF</button>
                        </form>
                    </div>


                </div>

                <%                    }
                %>









            </div>
        </div>

        <div class="container_btn" id="container_btn" style="visibility:hidden;">
            <div class="consultas">
                <input class="consultar" type="submit" value="Consultar Medicamentos" />
                <input class="separar" type="submit" value="Separar Medicamentos" />
                <input class="generar" type="submit" value="Generar Reporte" />
            </div>
        </div>



        <script>
            function habilitarInputs() {
                const inputs = document.querySelectorAll('.datos input[type="text"]:not([name="txteps"]):not([name="txtips"]):not([name="txtnombre"]):not([name="txtapellido"])');
                inputs.forEach(input => {
                    input.disabled = false; // Habilitar input
                });
            }


            function mostrarSeccion(seccionVisible) {
                const secciones = ['perfil', 'areaConsulta', 'container_btn'];
                secciones.forEach(seccion => {
                    document.getElementById(seccion).style.display = (seccion === seccionVisible) ? 'flex' : 'none';
                    document.getElementById('container_btn').style.display = 'flex';
                });
            }

            // Al cargar la página, mostrar la sección de consulta por defecto
            window.onload = function () {
                mostrarSeccion('perfil'); // Mostrar consulta al cargar
            };

            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById('btnPerfil').addEventListener('click', function () {
                    mostrarSeccion('perfil');
                    document.getElementById('container_btn').style.display = 'none';
                    document.getElementById('saludo').style.display = 'block';
                });

                document.getElementById('btnConsultar').addEventListener('click', function () {
                    mostrarSeccion('areaConsulta');
                });

                document.getElementById("btnConsultar").addEventListener("click", function () {
                    // Ocultar las áreas de saludo y pagos
                    document.getElementById("saludo").style.display = "none";

                });


                document.getElementById('btnCerrarSesion').addEventListener('click', function () {
                    window.location.href = '/Consultas/cerrar-sesion'; // Asegúrate de que sea esta URL
                });
            });

            function guardarCambios() {

                console.log("Función guardarCambios() llamada.");

                var telefonoInput = document.getElementById('txttelefono');
                var nuevoTelefono = telefonoInput.value; // Obtener el nuevo teléfono

                console.log("Nuevo teléfono:", nuevoTelefono);

                var usuarioId = "<%= usuario.getId()%>"; // Obtener el ID del usuario logueado

                console.log("ID de usuario:", usuarioId);

                if (!nuevoTelefono) {
                    alert("Por favor, ingresa un número de teléfono.");
                    return;
                }

                // Aquí puedes agregar el código AJAX para enviar los datos
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "/Consultas/TelefonoServlet", true); // URL del servlet
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                xhr.onload = function () {
                    if (xhr.status === 200) {
                        alert(xhr.responseText); // Mostrar la respuesta del servlet
                        // Opcional: deshabilitar el campo nuevamente
                        telefonoInput.disabled = true;
                    } else {
                        alert("Error al actualizar el teléfono.");
                    }
                };

                // Enviar la solicitud con el nuevo teléfono y el ID del usuario
                xhr.send("nuevoTelefono=" + encodeURIComponent(nuevoTelefono) + "&idUsuario=" + encodeURIComponent(usuarioId));
            }


// Función para asignar un color aleatorio
            function obtenerColorAleatorio() {
                return colores[Math.floor(Math.random() * colores.length)];
            }


            // Array de colores
            const colores = ['#ff5733', '#f1c40f', '#c0392b', ' #28b463', '#2471a3 '];


            /*Funcion para activar seccion pagos.
             function activarPagos(id) {
             var pagosDiv = document.getElementById('pagos' + id);
             pagosDiv.style.display = 'block';*/

// Variable para verificar si las opciones de pago ya fueron activadas
            let pagosActivos = false;

// Función para activar la sección de pagos
            function activarPagos(id) {
                var pagosDiv = document.getElementById('pagos' + id);
                var btnGenerar = document.getElementById('btnGenerar' + id);

                // Si las opciones de pago no han sido mostradas antes, las mostramos
                if (pagosDiv.style.display === 'none' || pagosDiv.style.display === '') {
                    pagosDiv.style.display = 'block'; // Mostrar la sección de pagos
                    btnGenerar.style.display = 'none'; // Asegurarse de que el botón "Generar Reporte" esté oculto inicialmente

                    // Llamamos a la función para restaurar las opciones de pago
                    restaurarOpcionesPago(id); // Restaurar ambas opciones de pago

                } else {
                    // Si las opciones de pago ya han sido mostradas, las ocultamos completamente
                    pagosDiv.style.display = 'none'; // Ocultar la sección de pagos
                    btnGenerar.style.display = 'none'; // Ocultar el botón "Generar Reporte"
                }
            }


            function seleccionarPago(tipo, id) {
                console.log("Método de pago seleccionado: " + tipo + ", ID: " + id);

                // Establecer el valor del tipo de pago
                document.getElementById("tipoPago" + id).value = tipo;

                // Mostrar el botón "Generar Reporte" cuando se seleccione un método de pago
                document.getElementById('btnGenerar' + id).style.display = 'inline-block';

                // Ocultar la opción no seleccionada completamente
                if (tipo === 'PSE') {
                    // Ocultar el pago en efectivo
                    document.getElementById('efectivoPago' + id).classList.add('ocultar');
                    // Mostrar el pago en PSE si no está oculto
                    document.getElementById('psePago' + id).classList.remove('ocultar');

                    // Abrir una nueva ventana con la imagen en caso de ser pago PSE
                    var ventanaPSE = window.open('', '_blank', 'width=400,height=400');
                    ventanaPSE.document.write('<html><head><title>Imagen PSE</title></head><body>');
                    ventanaPSE.document.write('<img src=" ../img/pse.png" style="width:100%; height:auto;">');
                    ventanaPSE.document.write('</body></html>');


                } else if (tipo === 'Efectivo') {
                    // Ocultar el pago PSE
                    document.getElementById('psePago' + id).classList.add('ocultar');
                    // Mostrar el pago en efectivo si no está oculto
                    document.getElementById('efectivoPago' + id).classList.remove('ocultar');
                }
            }

            // Función para restaurar ambas opciones de pago para una sede específica
            function restaurarOpcionesPago(id) {
                console.log("Restaurando opciones de pago para ID:", id);

                // Mostrar ambas opciones de pago (PSE y Efectivo) de forma independiente por sede
                const efectivoPago = document.getElementById('efectivoPago' + id);
                const psePago = document.getElementById('psePago' + id);

                // Asegurarse de que los elementos existen y restaurar su visibilidad
                if (efectivoPago && psePago) {
                    // Eliminar la clase 'ocultar' para mostrar ambos pagos
                    efectivoPago.classList.remove('ocultar');
                    psePago.classList.remove('ocultar');
                }
            }

            // Función para generar el reporte PDF
            function generarReporte(id) {
                const tipoPago = document.getElementById("tipoPago" + id).value;

                if (tipoPago === "") {
                    alert("Por favor, seleccione una forma de pago antes de generar el reporte.");
                    return;
                }

                document.getElementById("formGenerarReporte" + id).submit();
            }



        </script>

    </body>
</html>