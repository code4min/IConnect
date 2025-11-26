<%-- 
    Document   : DeleteDepartment
    Created on : 01-May-2024, 11:00:19 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*, java.util.Collections" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        // Establishing database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");

        // Retrieving parameters from the request
        String[] selectedDepIDs = request.getParameterValues("selectedDepIDs");
        if (selectedDepIDs != null && selectedDepIDs.length > 0) {
        String query = "DELETE FROM DEPARTMENTS WHERE deptID IN (" + String.join(",", Collections.nCopies(selectedDepIDs.length, "?")) + ")";
            pstmt = conn.prepareStatement(query);
            for (int i = 0; i < selectedDepIDs.length; i++) {
                pstmt.setString(i + 1, selectedDepIDs[i]);
            }
            pstmt.executeUpdate();
    }
    response.sendRedirect("UserAccounts.jsp?deleted=success");
    } catch (ClassNotFoundException | SQLException e) {
        out.println("Error: " + e.getMessage());
    } finally {
         if (pstmt != null) {
            pstmt.close();
        }    
    }
    if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
