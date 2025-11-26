<%-- 
    Document   : SaveFeedback
    Created on : 31-Mar-2024, 10:54:27 pm
    Author     : Sneha
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");

        // Retrieve parameters from the form
        String ticketID = request.getParameter("ticketID");
        String feedback = request.getParameter("feedback");
        String userID = request.getParameter("userID");
            if (userID == null) {
                userID = (String) session.getAttribute("userID");
            }
        
        // Insert feedback into the database
        String query = "INSERT INTO FEEDBACK (userID, ticketID, feedback) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, userID);
        pstmt.setString(2, ticketID);
        pstmt.setString(3, feedback);
        pstmt.executeUpdate();

        // Redirect back to the feedback page with a success message
        response.sendRedirect("Feedback.jsp?success=true");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Close database resources
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>

