<%-- 
    Document   : StoreNote
    Created on : 17-Mar-2024, 11:52:48 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
// Retrieve parameters from the request
String ticketID = request.getParameter("ticketID");
String agentID = request.getParameter("agentID");
String noteContent = request.getParameter("noteContent");

// Database connection parameters
Connection conn = null;// Change to your database password

// SQL query to insert the note into the database
String sql = "INSERT INTO NOTES (noteText, ticketID, agentID) VALUES (?, ?, ?)";

try {
    // Load the MySQL JDBC driver
    Class.forName("com.mysql.jdbc.Driver");
    
    // Establish a connection to the database
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");
    
    // Create a PreparedStatement with the SQL query
    PreparedStatement statement = conn.prepareStatement(sql);
    
    // Set the parameters for the PreparedStatement
    statement.setString(1, noteContent);
    statement.setString(2, ticketID);
    statement.setString(3, agentID);
   
    
    // Execute the query to insert the note into the database
    int rowsAffected = statement.executeUpdate();
    
    // Close the PreparedStatement and database connection
    statement.close();
    conn.close();
    
    // Check if the note was successfully inserted
    if (rowsAffected > 0) {
        out.println("Note added successfully");
    } else {
        out.println("Failed to add note");
    }
} catch (Exception e) {
    // Handle any exceptions that occur
    out.println("Error: " + e.getMessage());
}
%>