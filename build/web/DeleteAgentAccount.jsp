<%-- 
    Document   : DeleteAgentAccount
    Created on : 03-Apr-2024, 5:02:06 pm
    Author     : Sneha
--%>

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
    PreparedStatement pstmtDeleteNotes = null;
    PreparedStatement pstmtDeleteTickets = null;

    try {
        // Establishing database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");

        // Retrieving parameters from the request
        String[] selectedAgentIDs = request.getParameterValues("selectedAgentIDs");

        // Delete user accounts based on selected user IDs
        if (selectedAgentIDs != null && selectedAgentIDs.length > 0) {
            String deleteCommentsQuery = "DELETE FROM COMMENTS WHERE aID IN (" + String.join(",", Collections.nCopies(selectedAgentIDs.length, "?")) + ")";
            pstmtDeleteComments = conn.prepareStatement(deleteCommentsQuery);
            for (int i = 0; i < selectedAgentIDs.length; i++) {
                pstmtDeleteComments.setString(i + 1, selectedAgentIDs[i]);
            }
            pstmtDeleteComments.executeUpdate();
            
            
            String deleteNotesQuery = "DELETE FROM NOTES WHERE agentID IN (" + String.join(",", Collections.nCopies(selectedAgentIDs.length, "?")) + ")";
            pstmtDeleteNotes = conn.prepareStatement(deleteNotesQuery);
            for (int i = 0; i < selectedAgentIDs.length; i++) {
                pstmtDeleteNotes.setString(i + 1, selectedAgentIDs[i]);
            }
            pstmtDeleteNotes.executeUpdate();
            
            String deleteTicketsQuery = "DELETE FROM TICKET WHERE Agent IN (" + String.join(",", Collections.nCopies(selectedAgentIDs.length, "?")) + ")";
            pstmtDeleteTickets = conn.prepareStatement(deleteTicketsQuery);
            for (int i = 0; i < selectedAgentIDs.length; i++) {
                pstmtDeleteTickets.setString(i + 1, selectedAgentIDs[i]);
            }
            pstmtDeleteTickets.executeUpdate();
        
            String query = "DELETE FROM AGENTS WHERE agentID IN (" + String.join(",", Collections.nCopies(selectedAgentIDs.length, "?")) + ")";
            pstmt = conn.prepareStatement(query);
            for (int i = 0; i < selectedAgentIDs.length; i++) {
                pstmt.setString(i + 1, selectedAgentIDs[i]);
            }
            pstmt.executeUpdate();
        }

        // Redirect back to UserAccounts.jsp
        response.sendRedirect("AgentAccounts.jsp?deleted=success");
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
        if (pstmtDeleteNotes != null) {
            pstmtDeleteNotes.close();
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
