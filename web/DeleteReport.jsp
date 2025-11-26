<%-- 
    Document   : DeleteReport
    Created on : 19-Mar-2024, 10:41:45 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
// Retrieve ticket IDs from the request
String[] ticketIDs = request.getParameterValues("ticketIDs");

// Check if ticketIDs array is not null and not empty
if (ticketIDs != null && ticketIDs.length > 0) {
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");
        // Prepare SQL statement to delete records from REPORT table
        String deleteQuery = "DELETE FROM REPORT WHERE TicketID = ?";
        pstmt = conn.prepareStatement(deleteQuery);
        
        String insertDeletedQuery = "INSERT INTO DELETED_REPORTS (DeletedID) VALUES (?)";
        PreparedStatement insertPstmt = conn.prepareStatement(insertDeletedQuery);
        // Loop through ticket IDs and delete corresponding records
        for (String ticketID : ticketIDs) {
            pstmt.setString(1, ticketID);
            pstmt.executeUpdate();
            
            insertPstmt.setString(1, ticketID);
            insertPstmt.executeUpdate();
        }
        // Redirect back to Analysis.jsp after deletion
        response.sendRedirect("Analysis.jsp");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Close resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            out.println("Error in closing resources: " + e.getMessage());
        }
    }
} else {
    // No ticket IDs selected, display error message
    out.println("No ticket IDs selected.");
}
%>
