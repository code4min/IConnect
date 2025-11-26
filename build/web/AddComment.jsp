<%-- 
    Document   : AddComment
    Created on : 29-Feb-2024, 4:46:42 pm
    Author     : Sneha
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    // Retrieve parameters from the form
    String userID = request.getParameter("userID");
    String ticketId = request.getParameter("ticketId");
    String comment = request.getParameter("comment");

    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/HDT";
    String username = "db_name";
    String password = "db_pass";

    // Database connection and query initialization
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Establish database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // Insert comment into the Comment table
        String sql = "INSERT INTO COMMENTS (tID, comment,uID) VALUES (?,?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, ticketId);
        pstmt.setString(2, comment);
        pstmt.setString(3, userID);
        pstmt.executeUpdate();

        // Redirect back to the page where the ticket was raised
        response.sendRedirect("UserPage.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        // Handle any errors
        e.printStackTrace();
        // You may want to handle errors differently, like displaying an error message on the page
        out.println("Error: " + e.getMessage());
    } finally {
        // Close resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error in closing resources: " + e.getMessage());
        }
    }
%>
