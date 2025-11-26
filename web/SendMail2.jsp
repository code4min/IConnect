<%-- 
    Document   : SendMail2
    Created on : 26-Mar-2024, 1:01:25 am
    Author     : Sneha
--%>

<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
<%
    // Get form data
    String senderType = request.getParameter("sender_type");
    String senderId = request.getParameter("sender_id");
    String receiverEmail = request.getParameter("receiver_email");
    String receiverType = request.getParameter("receiver_type");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String senderEmail = "";
    String receiverId = "";

    try {
        // Obtain database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");
        
        String agentEmailQuery = "SELECT Email FROM AGENTS WHERE agentID = ?";
        pstmt = conn.prepareStatement(agentEmailQuery);
        pstmt.setString(1, senderId);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            senderEmail = rs.getString("email");
        } else {
            throw new SQLException("Agent email not found for sender ID: " + senderId);
        }
        String userIdQuery = "";
        if ("user".equals(receiverType)) {
            userIdQuery = "SELECT userID FROM USERS WHERE Email = ?";
        } else if ("db_pass".equals(receiverType)) {
            userIdQuery = "SELECT adminID FROM ADMIN WHERE Email = ?";
        } else {
            throw new SQLException("Invalid receiver type: " + receiverType);
        }
        pstmt = conn.prepareStatement(userIdQuery);
        pstmt.setString(1, receiverEmail);
        rs = pstmt.executeQuery();
        
         if (rs.next()) {
            receiverId = rs.getString(1); // Assuming the ID column is the first column in the result set
        } else {
            throw new SQLException("ID not found for receiver email: " + receiverEmail);
        }

        // Create SQL query to insert data into the MAIL table
        String sql = "INSERT INTO MAIL (sender_email, sender_type, receiver_email, receiver_type, subject, message, sent_date, sender_id, receiver_id) VALUES (?, ?, ?, ?, ?, ?, ?,?,?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, senderEmail);
        pstmt.setString(2, senderType);
        pstmt.setString(3, receiverEmail);
        pstmt.setString(4, receiverType);
        pstmt.setString(5, subject);
        pstmt.setString(6, message);
        
        // Set the sent_date to current timestamp
        pstmt.setTimestamp(7, new Timestamp(new Date().getTime()));
        
        pstmt.setString(8, senderId);
        pstmt.setString(9, receiverId);

        // Execute the query
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            out.println("Mail sent successfully!");
        } else {
            out.println("Failed to send mail.");
        }
         response.sendRedirect("AContact.jsp?mailSent=true");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred while sending mail: " + e.getMessage());
    } finally {
        // Close resources
        if (pstmt != null) {
            pstmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
%>