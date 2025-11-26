<%-- 
    Document   : StoreResolution
    Created on : 19-Mar-2024, 9:09:49 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String ticketID = request.getParameter("ticketID");
    String resolutionSteps = request.getParameter("resolutionSteps");
    
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");

        String updateQuery = "UPDATE TICKET SET resolution_steps = ? WHERE tID = ?";
        pstmt = conn.prepareStatement(updateQuery);
        pstmt.setString(1, resolutionSteps);
        pstmt.setString(2, ticketID);
        int rowsUpdated = pstmt.executeUpdate();

        if (rowsUpdated > 0) {
            out.println("Resolution steps stored successfully");
        } else {
            out.println("Failed to store resolution steps");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>

