<%@page import="java.sql.*"%> <!-- Importa clases de SQL -->
<%@page import="java.util.ArrayList"%> <!-- Importa la clase ArrayList -->
<%@page import="java.util.List"%> <!-- Importa la interfaz List -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- Importa la biblioteca JSTL para etiquetas personalizadas -->

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" %> <!-- Define el tipo de contenido y codificación de la página -->

<!DOCTYPE html> <!-- Declara el tipo de documento HTML -->
<html lang="es"> <!-- Define el idioma del documento -->
    <head>
        <meta charset="UTF-8" /> <!-- Establece la codificación de caracteres -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" /> <!-- Configura el viewport para dispositivos móviles -->

        <!-- Google Font -->
        <link rel="preconnect" href="https://fonts.googleapis.com" /> <!-- Mejora la carga de fuentes -->
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin /> <!-- Permite cargar fuentes de Google -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet" /> <!-- Incluye la fuente Montserrat -->

        <!-- CSS -->
        <link rel="stylesheet" href="../Styles/style.css" /> <!-- Incluye el archivo de estilos CSS -->
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" /> <!-- Incluye íconos de Boxicons -->

        <style>
            /* Estilos CSS adicionales para personalizar la apariencia de los formularios y otros elementos */
        </style>

        <title>Formulario de registro e inicio de sesión</title> <!-- Título de la página -->
    </head>

    <body>
        <!-- Formulario Registrarse -->
        <div class="container-form register hide"> <!-- Contenedor para el formulario de registro -->
            <div class="information"> <!-- Información general -->
                <div class="info-childs"> <!-- Contenedor de información -->
                    <h2>Bienvenido</h2> <!-- Título de bienvenida -->
                    <p>Eres un miembro importante para nuestra comunidad.</p> <!-- Mensaje informativo -->
                    <input type="button" value="Iniciar Sesión" id="sign-in" /> <!-- Botón para cambiar a la vista de inicio de sesión -->
                </div>
            </div>
            <div class="form-information"> <!-- Contenedor para la información del formulario -->
                <div class="form-information-childs"> <!-- Contenedor hijo para el formulario -->
                    <h2>Crear una Cuenta</h2> <!-- Título del formulario de registro -->
                    <p class="datos">Ingresa tus datos</p> <!-- Mensaje que indica que se ingresen datos -->

                    <!-- Formulario de registro -->
                    <form action="LoadIpsServlet" method="POST" class="form"> <!-- Acción del formulario hacia el servlet -->
                        <input type="hidden" name="action" value="registrar" /> <!-- Campo oculto para la acción de registrar -->

                        <!-- Campos de entrada para nombre, apellido, teléfono y contraseña -->
                        <i class="bx bxs-user"></i> <!-- Ícono para el nombre -->
                        <input type="text" name="txtnombre" placeholder="Nombre" required /> <!-- Campo de entrada para nombre -->
                        <i class="bx bxs-user"></i> <!-- Ícono para el apellido -->
                        <input type="text" name="txtapellido" placeholder="Apellido" required /> <!-- Campo de entrada para apellido -->
                        <i class="bx bxs-phone-call"></i> <!-- Ícono para el teléfono -->
                        <input type="text" name="txttelefono" placeholder="Teléfono" required /> <!-- Campo de entrada para teléfono -->
                        <i class="bx bxs-lock-open-alt"></i> <!-- Ícono para la contraseña -->
                        <input type="password" name="txtcontrasena" placeholder="Contraseña" required /> <!-- Campo de entrada para contraseña -->

                        <!-- Combo Box para EPS -->
                        <i class='bx bxs-capsule'></i>
                        <select name="id_eps" id="eps" onchange="loadIps(this.value)" required> <!-- Selección de EPS -->
                            <option value="">Selecciona EPS</option> <!-- Opción predeterminada -->
                            <!-- Opciones de EPS se cargarán dinámicamente -->
                        </select>

                        <!-- Combo Box para IPS -->
                        <i class='bx bxs-capsule'></i> <!-- Ícono para IPS -->
                        <select name="id_ips" id="ips" required> <!-- Selección de IPS -->
                            <option value="">Selecciona IPS</option> <!-- Opción predeterminada -->
                        </select>

                        <i class='bx bxs-edit'></i> <!-- Ícono para el botón de registro -->
                        <input class="registrarse" type="submit" value="Registrarse" /> <!-- Botón de registro -->
                    </form>
                </div>
            </div>
        </div>

        <!-- Formulario Iniciar Sesión -->
        <div class="container-form login"> <!-- Contenedor para el formulario de inicio de sesión -->
            <div class="information"> <!-- Información general -->
                <div class="info-childs"> <!-- Contenedor de información -->
                    <h2>Bienvenido</h2> <!-- Título de bienvenida -->
                    <p>Te invitamos a ser parte de nuestra comunidad.</p> <!-- Mensaje informativo -->
                    <input type="button" value="Registrarse" id="sign-up" /> <!-- Botón para cambiar a la vista de registro -->
                </div>
            </div>
            <div class="form-information"> <!-- Contenedor para la información del formulario -->
                <div class="form-information-childs"> <!-- Contenedor hijo para el formulario -->
                    <h2>Iniciar Sesión</h2> <!-- Título del formulario de inicio de sesión -->
                    <div class="icons">
                        <i class='bx bxl-facebook'></i>
                        <i class="bx bxl-instagram"></i>
                    </div>
                    <p class="datos">Ingresa tus datos</p> <!-- Mensaje que indica que se ingresen datos -->

                    <!-- Formulario de inicio de sesión -->
                    <form action="${pageContext.request.contextPath}/UsuarioServlet" method="POST" class="form"> <!-- Acción del formulario hacia el servlet -->
                        <input type="hidden" name="accion" value="verificar" /> <!-- Campo oculto para la acción de verificar -->

                        <i class="bx bxs-user"></i> <!-- Ícono para el nombre -->
                        <input type="text" name="nombre" placeholder="Nombre" required /> <!-- Campo de entrada para nombre -->
                        <i class="bx bxs-lock-open-alt"></i> <!-- Ícono para la contraseña -->
                        <input type="password" name="contrasena" placeholder="Contraseña" required /> <!-- Campo de entrada para contraseña -->
                        <i class='bx bx-log-in'></i> <!-- Ícono para el botón de inicio de sesión -->
                        <input class="registrarse" type="submit" value="Iniciar Sesión" /> <!-- Botón de inicio de sesión -->
                    </form>

                    <!-- Mensaje de error -->
                    <c:if test="${not empty sessionScope.error}"> <!-- Verifica si hay un mensaje de error en la sesión -->
                        <div class="error-message" id="error-message"> <!-- Contenedor del mensaje de error -->
                            <p>${sessionScope.error}</p> <!-- Muestra el mensaje de error -->
                            <button class="close-btn" onclick="closeMessage()">X</button> <!-- Botón para cerrar el mensaje -->
                        </div>
                        <c:remove var="error" scope="session" /> <!-- Limpia el mensaje de error después de mostrarlo -->
                    </c:if>

                    <!-- Scripts de JavaScript -->
                    <script src="script.js"></script> <!-- Incluye un archivo JavaScript externo -->
                    <script>
                                // Función para cargar IPS basado en la selección de EPS
                                function loadIps(id_eps) {
                                    const ipsSelect = document.getElementById('ips'); // Obtiene el elemento select de IPS
                                    ipsSelect.innerHTML = '<option value="">Cargando...</option>'; // Mensaje de carga

                                    // Realiza una petición para obtener las IPS relacionadas con la EPS seleccionada
                                    fetch(`/loadIps?epsId=${id_eps}`)
                                            .then(response => {
                                                if (!response.ok) {
                                                    throw new Error('Network response was not ok: ' + response.statusText); // Maneja errores de red
                                                }
                                                return response.json(); // Convierte la respuesta a JSON
                                            })
                                            .then(data => {
                                                ipsSelect.innerHTML = '<option value="">Selecciona IPS</option>'; // Limpiar y agregar opción predeterminada

                                                if (data && data.length) {
                                                    data.forEach(item => { // Recorre los datos recibidos
                                                        const option = document.createElement('option'); // Crea una nueva opción
                                                        option.value = item.id_ips; // Asigna el ID de IPS
                                                        option.textContent = item.nombre; // Asigna el nombre de IPS
                                                        ipsSelect.appendChild(option); // Agrega la opción al select
                                                    });
                                                } else {
                                                    ipsSelect.innerHTML = '<option value="">No se encontraron IPS</option>'; // Opción si no hay datos
                                                }
                                            })
                                            .catch(err => {
                                                ipsSelect.innerHTML = '<option value="">Error al cargar IPS</option>'; // Mensaje de error
                                            });
                                }

                                // Función para cerrar el mensaje de error
                                function closeMessage() {
                                    const errorMessage = document.getElementById('error-message'); // Obtiene el mensaje de error
                                    if (errorMessage) {
                                        errorMessage.style.display = 'none'; // Oculta el mensaje
                                        window.location.href = 'inicio.jsp'; // Redirige a inicio.jsp
                                    }
                                }

                                // Función para enviar un saludo basado en el icono seleccionado
                                function enviarSaludo(icon) {
                                    if (icon === 'bot') {
                                        alert('¡Hola! Soy tu asistente virtual. ¿En qué puedo ayudarte?'); // Saludo del asistente
                                    } else if (icon === 'whatsapp') {
                                        alert('¡Hola! Puedes contactarnos a través de WhatsApp para más asistencia.'); // Mensaje de contacto
                                    }
                                }
                    </script>

                    <!-- Widget de Atención -->
                </div>
            </div>
        </div>

        <!-- Widget de atención en la esquina inferior derecha -->
        <div class="widget-atencion"> <!-- Contenedor para el widget de atención -->
            <h5>Asistente Virtual</h5> <!-- Título del widget -->
            <div class="globo"> <!-- Contenedor para los íconos del asistente -->
                <i class='bx bx-bot' title="Asistente Virtual" onclick="enviarSaludo('bot')"></i> <!-- Ícono de asistente virtual -->
                <i class='bx bxl-whatsapp' title="Contáctanos" onclick="enviarSaludo('whatsapp')"></i> <!-- Ícono de WhatsApp -->
            </div>
        </div>
    </body>
</html>
