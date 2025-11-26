<%-- 
    Document   : DeleteNote
    Created on : 18-Mar-2024, 12:14:54 am
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
Connection conn = null;
 // Change to your database password

// SQL query to retrieve the noteID based on ticketID, agentID, and noteContent
String selectSql = "SELECT notesID FROM NOTES WHERE noteText = ? AND ticketID = ? AND agentID = ? ";

try {
    // Load the MySQL JDBC driver
    Class.forName("com.mysql.jdbc.Driver");
    
    // Establish a connection to the database
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");
    
    // Create a PreparedStatement with the SQL query
    PreparedStatement selectStatement = conn.prepareStatement(selectSql);
    
    // Set the parameters for the PreparedStatement
    selectStatement.setString(1, noteContent);
    selectStatement.setString(2, ticketID);
    selectStatement.setString(3, agentID);
    
    
    // Execute the query to retrieve the noteID
    ResultSet resultSet = selectStatement.executeQuery();
    
    // Initialize noteID variable
    int notesID = 0;
    
    // Check if the result set has any rows
    if (resultSet.next()) {
        // Get the noteID from the result set
        notesID = resultSet.getInt("notesID");
    }
    
    // Close the result set and PreparedStatement
    resultSet.close();
    selectStatement.close();
    
    // Check if noteID is not zero (i.e., note found in the database)
    if (notesID != 0) {
        // SQL query to delete the note from the database
        String deleteSql = "DELETE FROM NOTES WHERE notesID = ?";
        
        // Create a PreparedStatement with the delete SQL query
        PreparedStatement deleteStatement = conn.prepareStatement(deleteSql);
        
        // Set the parameter for the PreparedStatement
        deleteStatement.setInt(1, notesID);
        
        // Execute the query to delete the note from the database
        int rowsAffected = deleteStatement.executeUpdate();
        
        // Close the PreparedStatement
        deleteStatement.close();
        
        // Check if the note was successfully deleted
        if (rowsAffected > 0) {
            out.println("Note deleted successfully");
        } else {
            out.println("Failed to delete note");
        }
    } else {
        // Note not found in the database
        out.println("Note not found in the database");
    }
    
    // Close the database connection
    conn.close();
} catch (Exception e) {
    // Handle any exceptions that occur
    out.println("Error: " + e.getMessage());
}
%>
