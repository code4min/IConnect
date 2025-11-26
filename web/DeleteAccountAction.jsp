<%-- 
    Document   : DeleteAccountAction
    Created on : 03-Apr-2024, 4:12:50 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*, java.util.Collections" %>


<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmtDeleteComments = null;
    PreparedStatement pstmtDeleteTickets = null;

    try {
        // Establishing database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");

        // Retrieving parameters from the request
        String[] selectedUserIDs = request.getParameterValues("selectedUserIDs");

        // Delete user accounts based on selected user IDs
        if (selectedUserIDs != null && selectedUserIDs.length > 0) {
            String deleteCommentsQuery = "DELETE FROM COMMENTS WHERE uID IN (" + String.join(",", Collections.nCopies(selectedUserIDs.length, "?")) + ")";
            pstmtDeleteComments = conn.prepareStatement(deleteCommentsQuery);
            for (int i = 0; i < selectedUserIDs.length; i++) {
                pstmtDeleteComments.setString(i + 1, selectedUserIDs[i]);
            }
            pstmtDeleteComments.executeUpdate();
            
            String deleteTicketsQuery = "DELETE FROM TICKET WHERE uID IN (" + String.join(",", Collections.nCopies(selectedUserIDs.length, "?")) + ")";
            pstmtDeleteTickets = conn.prepareStatement(deleteTicketsQuery);
            for (int i = 0; i < selectedUserIDs.length; i++) {
                pstmtDeleteTickets.setString(i + 1, selectedUserIDs[i]);
            }
            pstmtDeleteTickets.executeUpdate();
        
            String query = "DELETE FROM USERS WHERE userID IN (" + String.join(",", Collections.nCopies(selectedUserIDs.length, "?")) + ")";
            pstmt = conn.prepareStatement(query);
            for (int i = 0; i < selectedUserIDs.length; i++) {
                pstmt.setString(i + 1, selectedUserIDs[i]);
            }
            pstmt.executeUpdate();
        }

        // Redirect back to UserAccounts.jsp
        response.sendRedirect("UserAccounts.jsp?deleted=success");
    } catch (ClassNotFoundException | SQLException e) {
        out.println("Error: " + e.getMessage());
    } finally {
         if (pstmt != null) {
            pstmt.close();
        }
         if (pstmtDeleteComments != null) {
            pstmtDeleteComments.close();
        }
        if (pstmtDeleteTickets != null) {
            pstmtDeleteTickets.close();
        }
        // Closing database resources
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
