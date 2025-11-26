<%-- 
    Document   : deleteMail
    Created on : 23-Mar-2024, 7:31:44 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<% 
        String mailID = request.getParameter("mailID");
        String redirect =request.getParameter("redirect");
%>
<%  
     Connection conn = null;
     PreparedStatement pstmt = null;
     
        
        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");
            
            // Prepare SQL query to retrieve ticket details
            String query = "Delete from MAIL where message_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, mailID);
            pstmt.executeUpdate();
            
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
        
        if ("user".equals(redirect)) {
            response.sendRedirect("UContact.jsp?mailDel=true");
        } else if ("agent".equals(redirect)) {
            response.sendRedirect("AContact.jsp?mailDel=true");
        }
        else if ("db_pass".equals(redirect)) {
            response.sendRedirect("Contact3.jsp?mailDel=true");
        }else {
            // Default redirect if 'redirect' is not recognized
            response.sendRedirect("default.jsp");
        }
    
            
 %>