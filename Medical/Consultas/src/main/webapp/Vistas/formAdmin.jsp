<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- CSS -->
        <link rel="stylesheet" href="Styles/style.css" />
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />

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
            
            body {
                height:  100vh;
                background-image:  url("../img/medical2.jpg");
                background-size:  cover;
            }

            .container_btn {
                display:  flex;
                padding: 25px;
                align-content: center;
                align-items: center;
                border-radius:  20px;
                height:  80px;
                max-width:  100%;
                transition:  all 1s ease;
                justify-content: space-around;
                border:  solid thin #0315af;
            }


            input {
                width:  25%;
                height:  60px;
                display:  flex;
                align-items: center;
                justify-content:center ;
                align-content: center;
                border-radius:  20px;
                text-align:  center;
                background-color:  transparent;
                border-top-left-radius:  20px;
                border-bottom-left-radius:  20px;
                border:  solid 5px thin blue;
            }

            .container_btn input:hover {
                background-color:  var(--aqua);
                border:  var(--azul_oscuro);
                color:  var(--azul_oscuro);
                font-size:  1.3rem;
                box-shadow:  10px 10px 10px rgba(83, 87, 100, 0.4);
            }


        </style>
        <title>Bienvenida Admin</title>
    </head>
    <body>
       
        <h1>Bienvenido, Administrador </h1>
        <p></p>
        
        <div class="container_btn">
            <input class="Boton1" type="submit" value="Boton1" />
            <input class="Boton2" type="submit" value="Boton2" />
            <input class="Boton3" type="submit" value="Boton3" />
        </div>

 </body>
</html>