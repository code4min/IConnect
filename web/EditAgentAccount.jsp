<%-- 
    Document   : EditAgentAccount
    Created on : 03-Apr-2024, 4:54:42 pm
    Author     : Sneha
--%>
<%-- 
    Document   : UpdateTicketAction
    Created on : 01-Mar-2024, 12:05:55 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Establishing database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");

        // Retrieving parameters from the form
        String editUsername = request.getParameter("editUsername");
        String editEmail = request.getParameter("editEmail");
        String editPassword = request.getParameter("editPassword");
        String department = request.getParameter("department");
        String selectedAgentID = request.getParameter("selectedAgentID");

        String query = "UPDATE AGENTS SET username=?, Email=?, password=?, deptID=? WHERE agentID=?";
            
        pstmt = conn.prepareStatement(query);
            pstmt.setString(1, editUsername);
            pstmt.setString(2, editEmail);
            pstmt.setString(3, editPassword);
            pstmt.setString(4, department);
            pstmt.setString(5, selectedAgentID);
        
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // Redirecting with a success message
            response.sendRedirect(" AgentAccounts.jsp?edit=success");
        } 
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
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

