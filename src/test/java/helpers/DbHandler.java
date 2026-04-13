package helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.minidev.json.JSONObject;

public class DbHandler {

    private static String connectionUrl = "jdbc:mysql://localhost:3306/myloandb?user=root&password=Gabylu212208.";
      
        public static void addNewClientWithId(int clientId, String firstName, String lastName, String email, String phoneNumber, String dateJoined) {
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

    public static JSONObject getDataLoanByClientId(int clientId) {
        JSONObject json = new JSONObject();

            try (Connection connection = DriverManager.getConnection(connectionUrl)) {
                 ResultSet rs = connection.createStatement().executeQuery("Select c.firstname,c.lastname, cl.loanId, cl.loanAmount\n" + //
                                          "from currentloans cl\n" + //
                                          "inner join clients c on c.clientID=cl.clientID\n" + //
                                          "where cl.ClientID= " + clientId);
                 rs.next();
                    json.put("FirstName", rs.getString("c.firstname"));
                    json.put("LastName", rs.getString("c.lastname"));
                    json.put("LoanID", rs.getInt("cl.loanId"));
                    json.put("LoanAmount", rs.getInt("cl.loanAmount"));
                
                    //System.out.println("Datos obtenidos para ClientID " + clientId + ": " + json.toJSONString());
                } 
             catch (SQLException e) {
                throw new RuntimeException("Error en DB: " + e.getMessage());
            }

        return json;
        // Aquí podrías implementar un método para consultar datos de la base usando el clientId
        // y devolverlos a Karate para validación. Esto es solo un ejemplo de cómo podrías estructurarlo.
    
    }

}
