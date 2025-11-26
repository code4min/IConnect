<%-- 
    Document   : SendMail
    Created on : 22-Mar-2024, 2:37:08 am
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
        
        String userEmailQuery = "SELECT Email FROM USERS WHERE userID = ?";
        pstmt = conn.prepareStatement(userEmailQuery);
        pstmt.setString(1, senderId);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            senderEmail = rs.getString("email");
        } else {
            throw new SQLException("User email not found for sender ID: " + senderId);
        }
        String agentIdQuery = "SELECT agentID FROM AGENTS WHERE Email = ?";
        pstmt = conn.prepareStatement(agentIdQuery);
        pstmt.setString(1, receiverEmail);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            receiverId = rs.getString("agentID");
        } else {
            throw new SQLException("Agent ID not found for receiver email: " + receiverEmail);
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
         response.sendRedirect("UContact.jsp?mailSent=true");
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





