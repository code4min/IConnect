<%-- 
    Document   : DeleteFeedback
    Created on : 01-Apr-2024, 4:27:20 am
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
// Retrieve ticket IDs from the request
String[] feedbackIDs = request.getParameterValues("feedbackIDs");

// Check if ticketIDs array is not null and not empty
if (feedbackIDs != null && feedbackIDs.length > 0) {
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");
        // Prepare SQL statement to delete records from REPORT table
        String deleteQuery = "DELETE FROM FEEDBACK WHERE feedbackID = ?";
        pstmt = conn.prepareStatement(deleteQuery);
        
        String insertDeletedQuery = "INSERT INTO DELETED_REPORTS (DeletedID) VALUES (?)";
        PreparedStatement insertPstmt = conn.prepareStatement(insertDeletedQuery);
        // Loop through ticket IDs and delete corresponding records
        for (String feedbackID : feedbackIDs) {
            pstmt.setString(1, feedbackID);
            pstmt.executeUpdate();
            
            insertPstmt.setString(1, feedbackID);
            insertPstmt.executeUpdate();
        }
        // Redirect back to Analysis.jsp after deletion
        response.sendRedirect("Feedback.jsp");
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
