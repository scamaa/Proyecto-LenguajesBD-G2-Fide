package com.proyectotienda;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class ConexionBD {
    
    String url = "jdbc:oracle:thin:@//localhost:1521/ORCL";
    String usuario = "AARON";
    String contrasena = "123456789";
    Connection conexion;
    Statement statement;
    
    public ConexionBD() {
        try {
            // Establecer la conexión
            conexion = DriverManager.getConnection(url, usuario, contrasena);
            // Crear un Statement
            statement = conexion.createStatement();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}



