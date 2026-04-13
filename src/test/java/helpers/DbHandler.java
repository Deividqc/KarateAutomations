package helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DbHandler {

    private static String connectionUrl = "jdbc:mysql://localhost:3306/myloandb?user=root&password=Gabylu212208.";
      
        public static void addNewJobWithId(int clientId, String firstName, String lastName, String email, String phoneNumber, String dateJoined) {
        // Usamos PreparedStatement para evitar inyección SQL y manejar variables fácilmente
        String sql = "INSERT INTO clients (ClientID, FirstName, LastName, Email, PhoneNumber, DateJoined) " + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection(connectionUrl);
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            
            connection.setAutoCommit(true);
            
            // Asignamos el ID dinámico que viene de Karate
            pstmt.setInt(1, clientId);
            pstmt.setString(2, firstName);
            pstmt.setString(3, lastName);
            pstmt.setString(4, email);
            pstmt.setString(5, phoneNumber);
            pstmt.setString(6, dateJoined);
            pstmt.executeUpdate();
            
            System.out.println("Registro insertado con ID: " + clientId + ", Nombre: " + firstName + ", Apellido: " + lastName + ", Email: " + email + ", Teléfono: " + phoneNumber + ", Fecha de Registro: " + dateJoined);

        } catch (SQLException e) {
            // Esto hará que Karate falle visualmente si el ID ya existe o hay error de red
            throw new RuntimeException("Error en DB: " + e.getMessage());
        }
    }
}



        /*public static void addNewJobWithName() {
            try(Connection connection = DriverManager.getConnection(connectionUrl)){
                connection.createStatement().execute("Insert into myloandb.clients(ClientID, FirstName, LastName, Email, PhoneNumber, DateJoined ) values(53,'Juan','Garcia','juangarcia@hotmail.com','555-9889-3333','2023-02-21')");
                connection.commit();
            }  catch(SQLException e){
                e.printStackTrace();
            }
             
        
           
        }*/



