<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@page contentType="text/html" pageEncoding="UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- Google Font -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

        <link
            href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap"
            rel="stylesheet"
            />
        <!-- CSS -->
        <link rel="stylesheet" href="../Styles/style.css" />
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
        <style>

            /*.form i {
                  color: #0315af;
                  font-size: 1.5rem;
              }
  
              select {
                  width: 92%;
                  margin-bottom: 5px;
                  padding: 10px;
                  border: solid 2px #0315af;
                  outline: none;
                  border-radius: 20px;
                  font-size: 1rem;
                  color: #0315af;
              }
  
  
  
  
              .msjError {
                  width: 100%;
                  display: flex;
                  justify-content: center;
                  align-items: center; /* Centra el texto verticalmente */
            /* border-radius: 20px;
             text-align: center;
             background-color: transparent;
             border-top-left-radius: 20px;
             border-bottom-left-radius: 20px;
             font-size:  1rem;
             box-shadow:  7px 7px 7px rgba(255, 0, 0, 0.9);
             border: solid 2px thin red;
         }

         .widget-atencion {
             position: fixed;
             bottom: 20px;
             right: 20px;
             z-index: 1000; /* Asegúrate de que esté por encima de otros elementos */
            /*    background-color: #fff;
                border-radius: 15px;
                box-shadow:  5px 5px 5px #555;
                padding: 10px;
            }

            .globo::after {
                content: '';
                position: absolute;
                bottom: 100%; /* Ajusta la posición del triángulo */
            /*  left: 50%;
              margin-left: -5px; /* Centra el triángulo */
            /*    border-width: 5px;
                border-style: solid;
                border-color: transparent transparent #fff transparent; /* Color del fondo del globo */
            /*     }
     
                 .globo i {
                     font-size: 30px;
                     color: #0315af;
                     margin: 5px 3px;
                     cursor: pointer; /* Cambiar el cursor para indicar que son interactivos */
            /*   }
   
               .globo i:hover {
                   color: #0d47a1; /* Cambiar color al pasar el mouse */
            /*  }*/

        </style>
        <title>Formulario de registro e inicio de sesión</title>
    </head>
    <body>


        <!-- Formulario Registrarse -->
        <div class="container-form register hide">
            <div class="information">
                <div class="info-childs">
                    <h2>Bienvenido</h2>
                    <p>Eres un miembro importante para nuestra comunidad.</p>
                    <input type="button" value="Iniciar Sesión" id="sign-in" />
                </div>
            </div>
            <div class="form-information">
                <div class="form-information-childs">
                    <h2>Crear una Cuenta</h2>
                    <!-- <div class="icons">
                        <i class="bx bxl-whatsapp"></i>
                        <i class="bx bxl-instagram"></i>
                    </div> -->   
                    <p class="datos">Ingresa tus datos</p>
                    <form action="LoadIpsServlet" method="POST" class="form">
                        <input type="hidden" name="action" value="registrar" />
                        <i class="bx bxs-user"></i>
                        <input type="text" name="txtnombre" placeholder="Nombre" required />
                        <i class="bx bxs-user"></i>
                        <input type="text" name="txtapellido" placeholder="Apellido" required />
                        <i class="bx bxs-phone-call"></i>
                        <input type="text" name="txttelefono" placeholder="Teléfono" required />
                        <i class="bx bxs-lock-open-alt"></i>
                        <input type="password" name="txtcontrasena" placeholder="Contraseña" required />
                        <i class='bx bx-plus-medical'></i>


                        <!-- Combo Box para EPS -->
                        <select 


                            name="id_eps" id="eps" onchange="loadIps(this.value)" required>

                            <option value="">Selecciona EPS</option>










                        </select>

                        <!-- Combo Box para IPS -->
                        <i class='bx bxs-capsule'></i>
                        <select

                            name="id_ips" id="ips" required>
                            <option value="">Selecciona IPS</option>
                        </select>
                        <i class='bx bxs-edit'></i>
                        <input class="registrarse" type="submit" value="Registrarse" />


                    </form>

                </div>
            </div>
        </div>





        <!-- Formulario Iniciar Sesión -->
        <div class="container-form login">
            <div class="information">
                <div class="info-childs">

                    <h2>Bienvenido</h2>
                    <p>Te invitamos a ser parte de nuestra comunidad.</p>
                    <input type="button" value="Registrarse" id="sign-up" />
                </div>
            </div>
            <div class="form-information">
                <div class="form-information-childs">
                    <h2>Iniciar Sesión</h2>
                    <div class="icons">
                        <i class='bx bxl-facebook'></i>
                        <i class="bx bxl-instagram"></i>
                    </div>
                    <p class="datos">Ingresa tus datos</p>
                    
                    
                    <form action="${pageContext.request.contextPath}/LoginServlet" method="POST" class="form"> 
                        <input type="hidden" name="accion" value="verificar" />



                        <i class="bx bxs-user"></i>
                        <input type="text" name="nombre" placeholder="Nombre" required />
                        <i class="bx bxs-lock-open-alt"></i>
                        <input type="password" name="contrasena" placeholder="Contraseña" required />
                        <i class='bx bx-log-in'></i>
                        <input class="registrarse" type="submit" value="Iniciar Sesión" />

                    </form>





                    <!-- Mensaje de error -->
                    <c:if test="${not empty sessionScope.error}">
    <div class="error-message" id="error-message">
        <p>${sessionScope.error}</p>
        <button class="close-btn" onclick="closeMessage()">X</button>
    </div>
    <c:remove var="error" scope="session" /> <!-- Limpia el mensaje después de mostrarlo -->
</c:if>

            <script src="script.js"></script>
            <script>
                                function loadIps(id_eps) {
                                    const ipsSelect = document.getElementById('ips');
                                    ipsSelect.innerHTML = '<option value="">Cargando...</option>'; // Mensaje de carga

                                    fetch(`/loadIps?epsId=${id_eps}`)
                                            .then(response => {
                                                console.log("Respuesta del servidor:", response); // Para depurar

                                                if (!response.ok) {
                                                    throw new Error('Network response was not ok: ' + response.statusText);
                                                }
                                                return response.json();
                                            })
                                            .then(data => {
                                                console.log("Datos recibidos:", data); // Para depurar
                                                ipsSelect.innerHTML = '<option value="">Selecciona IPS</option>'; // Limpiar y agregar opción predeterminada

                                                if (data && data.length) {
                                                    data.forEach(item => {
                                                        const option = document.createElement('option');
                                                        option.value = item.id_ips; // Asegúrate de que esto sea correcto
                                                        option.textContent = item.nombre; // Asegúrate de que esto sea correcto
                                                        ipsSelect.appendChild(option);
                                                    });
                                                } else {
                                                    console.log('No data found for epsId:', id_eps);
                                                    ipsSelect.innerHTML = '<option value="">No se encontraron IPS</option>'; // Opción si no hay datos
                                                }
                                            })
                                            .catch(err => {
                                                console.error("Error:", err); // Muestra más detalles del error
                                                ipsSelect.innerHTML = '<option value="">Error al cargar IPS</option>';
                                            });
                                }


            </script>
        

            <script>
                
                   function closeMessage() {
    const errorMessage = document.getElementById('error-message');
    if (errorMessage) {
        errorMessage.style.display = 'none'; // Oculta el mensaje
        // Redirige o actualiza la página si es necesario
        window.location.href = 'inicio.jsp'; // Redirige a inicio.jsp
    }
}
                
    
    
    function enviarSaludo(icon) {
                    if (icon === 'bot') {
                        alert('¡Hola! Soy tu asistente virtual. ¿En qué puedo ayudarte?');
                    } else if (icon === 'whatsapp') {
                        alert('¡Hola! Puedes contactarnos a través de WhatsApp para más asistencia.');
                    }
                }
            </script>
            <!-- Widget de Atención -->

        </div>
        <div class="widget-atencion">
            <h5>Asistente Virtual</h5>
            <div class="globo">
                <i class='bx bx-bot' title="Asistente Virtual" onclick="enviarSaludo('bot')"></i>
                <i class='bx bxl-whatsapp' title="Contáctanos" onclick="enviarSaludo('whatsapp')"></i>
            </div>
    </body>
</html>
