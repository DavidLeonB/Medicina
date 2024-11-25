<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%>


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

        <!<!-- Icons -->
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
        <!-- CSS -->

        <style>


            :root {
                --azul_oscuro: #0315af;
                --azul-claro: #3fb7ee;
                --negro: #111;
                --gris: #555;
                --gris2: #9191bd;
                --blanco: #fff;
                --aqua: #92def5;
            }
            * {
                padding:  0;
                margin:  0;
                box-sizing:  border-box;
                font-family:  "Montserrat", system-ui;
                font-weight:  400;
            }

            body {
                display:  flex;
                align-items:  center;
                justify-content:  center;
                height:  100vh;
                background-image:  url("../img/medical_1.jpg");
                background-size:  cover;
            }

            @keyframes fontPulse {
                0% {
                    font-size:  1rem;
                }
                50% {
                    font-size:  1.2rem;
                }
                100% {
                    font-size:  1rem;
                }
            }




            .ErrorCredenciales {
                display: flex;
                justify-content: center;
                align-items: center;
                border-radius: 20px;                
                height: 60px;
                max-width: 500px;
                transition: all 1s ease;
                border: solid thin #0315af;
                margin: 20px auto;
                animation: fontPulse 4s infinite;
            }

            .msjError {
                width: 100%;
                text-align: center;
                background-color: #3fb7ee;
                border-radius: 20px;
                padding: 10px;
            }

            .msjError h4 {
                color: red;

            }

            .msjError p {
                margin: 5px 0;
            }
        </style>
        <title>Mensaje de ERROR</title>
    </head>
    <body>  
        
      
        <div class="ErrorCredenciales">
            <div class="msjError">                
                <h4>Usuario no está logueado.</h4>
                <p>Vuelve a intentarlo.</p>
                <p><a href="inicio.jsp">Inicia Sesión</a></p>
            </div>
        </div>
    </body>
</html>
