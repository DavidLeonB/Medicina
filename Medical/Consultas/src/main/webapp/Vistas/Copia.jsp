<%@page import="java.util.ArrayList"%> 
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="Styles/style.css" />
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
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
                background-color: rgba(128, 128, 128 0.6);
                display: flex;
                align-content: center;
                align-items: center;
                width: 600px;
                
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
                align-content: center;
                flex-direction: column;
                align-items: center;
                margin-bottom: 15px;
                 /*display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 10px;
                flex: 2;*/
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

            .med {
               display: flex;
               flex-direction: row;
               align-items: center;
               margin-bottom: 20px;
               margin: 5px;
                border: 3px solid greenyellow;
                padding: 15px;
                border-radius: 20px;
                background-color: transparent;
            }
            .med p{
                margin: 8px;
            }
                
            .med input {
                margin-right: 20px;
            }

            .med input {
                width: 95%;
                height: 60px;
                font-size: 1rem;
                border-radius: 20px;
                text-align: center;
                border: 2px solid #0315af;
            }

            .container_btn input,
            .saludo input,
            .actualizaciones input {
                background-color: rgba(128, 128, 128 0.6);
                border: #0315af solid 2px;
            }

            .container_btn input:hover,
            .actualizaciones input:hover,
            .saludo input:hover {
                background-color: var(--aqua);
                border: var(--azul_oscuro);
                color: var(--azul_oscuro);
                font-size: 1.3rem;
                box-shadow: 10px 10px 10px rgba(83, 87, 100, 0.4);
            }


        </style>
        <title>Bienvenida Cliente</title>
</head>
<body>

     <%
    HttpSession userSession = request.getSession(false);
    String usuario = null;
    String nombre = "";
    String apellido = "";
    String telefono = "";
    String eps = "";
    String dispensador = "";
    
    List<String> medicamentos = new ArrayList<>();
    List<String> cantidades = new ArrayList<>();

    if (userSession != null) {
        usuario = (String) userSession.getAttribute("usuario");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/medical", "root", "");

            // Consulta para obtener los datos del usuario
            String sqlUsuario = "SELECT usuarios.nombre, usuarios.apellido, usuarios.telefono, "
                    + "eps.nombre AS eps_nombre, ips.nombre AS ips_nombre "
                    + "FROM usuarios "
                    + "JOIN eps ON usuarios.id_eps = eps.id_eps "
                    + "JOIN ips ON usuarios.id_ips = ips.id_ips "
                    + "WHERE usuarios.nombre = ?";
            
            stmt = conn.prepareStatement(sqlUsuario);
            stmt.setString(1, usuario);
            rs = stmt.executeQuery();

            if (rs.next()) {
                nombre = rs.getString("usuarios.nombre");
                apellido = rs.getString("usuarios.apellido");
                telefono = rs.getString("usuarios.telefono");
                eps = rs.getString("eps_nombre");
                dispensador = rs.getString("ips_nombre");
            }

            // Consulta para obtener los medicamentos
            String sqlMedicamentos = "SELECT m.nombre AS med_nombre, um.med_men AS cantidad "
                    + "FROM usu_medicamentos um "
                    + "JOIN medicamentos m ON um.id_medicamentos = m.id_medicamentos "
                    + "JOIN usuarios u ON um.id_usuarios = u.id_usuarios "
                    + "WHERE u.nombre = ?";
            
            stmt = conn.prepareStatement(sqlMedicamentos);
            stmt.setString(1, usuario);
            rs = stmt.executeQuery();

            while (rs.next()) {
                medicamentos.add(rs.getString("med_nombre"));
                cantidades.add(rs.getString("cantidad"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    if (usuario != null) {
%> 
    <div class="saludo">
        <h1>Bienvenido, <%= usuario %></h1>  
        <h4>Estamos felices de que estés con nosotros, aquí puedes Consultar, Generar, Separar tus medicamentos.</h4>
        
        <div class="btnSaludo">
        <input class="perfil" type="button" id="btnPerfil" value="Perfil">
        <input class="areaConsulta" type="button" id="btnConsultar" value="Consultar">
        </div>
    </div>

    <div class="perfil" id="perfil" style="display: none;">
        <div class="datos">
            <div>
                <p>Nombre</p>
                <input type="text" value="<%= nombre %>" name="txtnombre" disabled />
            </div>
            <div>
                <p>Apellido</p>
                <input type="text" value="<%= apellido %>" name="txtapellido" disabled />
            </div>
            <div>
                <p>Teléfono</p>
                <input type="text" value="<%= telefono %>" name="txttelefono" disabled />
            </div>
            <div>
                <p>EPS</p>
                <input type="text" value="<%= eps %>" name="txteps" disabled />
            </div>
            <div>
                <p>Dispensador de Medicina</p>
                <input type="text" value="<%= dispensador %>" name="txtips" disabled />
            </div>
        </div>
        <div class="actualizaciones">
            <div class="acciones">
                <input class="actualizar" type="button" value="Actualizar Datos" onclick="habilitarInputs()" />
                <input class="guardarCambios" type="submit" value="Guardar Cambios" />
                <input class="cerrarSesion" type="button" id="btnCerrarSesion" value="Cerrar Sesión" />
            </div>
        </div>
    </div>

    <div class="areaConsulta" id="areaConsulta" style="display: none;">
        <div class="consmedica">
             <%
                for (int i = 0; i < medicamentos.size(); i++) {
                    String medNombre = medicamentos.get(i);
                    String cantidad = cantidades.get(i);
            %> 
            <div class="med">
                <p><strong><%= i + 1 %>° Medicamento</strong></p>
                <input type="text" value="<%= medNombre %>" name="med<%= i + 1 %>" />
                <p>Cantidad</p>
                <input type="text" value="<%= cantidad %>" name="cant<%= i + 1 %>" />
                <p>Estado</p>
                <input type="text" value="" name="estado<%= i + 1 %>" />
            </div>
            <%
                }
            %>
        </div>
    </div>

    <div class="container_btn" id="container_btn" style="display: none;">
        <div class="consultas">
            <input class="consultar" type="submit" value="Consultar Medicamentos" />
            <input class="separar" type="submit" value="Separar Medicamentos" />
            <input class="generar" type="submit" value="Generar Reporte" />
        </div>
    </div>

<%
    } else {
        response.sendRedirect("ErrorCredenciales.jsp");
    }
%>

<script>
    function habilitarInputs() {
        const inputs = document.querySelectorAll('.datos input[type="text"]:not([name="txteps"]):not([name="txtips"])');
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
    window.onload = function() {
        mostrarSeccion('areaConsulta'); // Mostrar consulta al cargar
    };

    document.getElementById('btnPerfil').addEventListener('click', function () {
        mostrarSeccion('perfil'); // Mostrar perfil
        document.getElementById('container_btn').style.display = 'none';
    });

    document.getElementById('btnConsultar').addEventListener('click', function () {
        mostrarSeccion('areaConsulta'); // Mostrar consulta
        document.getElementById('container_btn').style.display = 'flex';
    });

    document.getElementById('btnCerrarSesion').addEventListener('click', function () {
        window.location.href = '/Medicamentos/cerrar-sesion'; // Asegúrate de que sea esta URL
    });


/*
    document.getElementById('btnPerfil').addEventListener('click', function () {
        document.getElementById('perfil').style.display = 'flex';
        document.getElementById('areaConsulta').style.display = 'none';
        document.getElementById('container_btn').style.display = 'none';
    });

    document.getElementById('btnConsultar').addEventListener('click', function () {
        document.getElementById('perfil').style.display = 'none';
        document.getElementById('areaConsulta').style.display = 'flex';
        document.getElementById('container_btn').style.display = 'flex';
    });

    document.getElementById('btnCerrarSesion').addEventListener('click', function () {
        window.location.href = '/Medicamentos/cerrar-sesion'; // Asegúrate de que sea esta URL
    });*/
</script>

</body>
</html><%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ComboBox desde SQL</title>
</head>
<body>
    <h2>Selecciona una Opción</h2>
    <form action="formCliente.jsp" method="post">
        <select name="miComboBox">
            <%
                // Configura la conexión a la base de datos
                String url = "jdbc:mysql://localhost:3306/medical";
                String user = "root";
                String password = "";
                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                try {
                    // Establecer la conexión
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(url, user, password);
                    statement = connection.createStatement();
                    String sql = "SELECT * FROM eps"; // Ajusta según tu tabla
                    resultSet = statement.executeQuery(sql);

                    // Llenar el ComboBox
                    while (resultSet.next()) {
                        String nombre = resultSet.getString("nombre");
            %>
                        <option value="<%= nombre %>"><%= nombre %></option>
            <%
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                } finally {
                    // Cerrar los recursos
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </select>
        <input type="submit" value="Enviar">
    </form>
</body>
</html>