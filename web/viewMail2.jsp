<%-- 
    Document   : viewMail2
    Created on : 02-Apr-2024, 3:10:49 am
    Author     : Sneha
--%>

<%-- 
    Document   : viewMail
    Created on : 23-Mar-2024, 6:56:34 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<% 
        String mailID = request.getParameter("mailID");
%>
<%  
     Connection conn = null;
     PreparedStatement pstmt = null;
     ResultSet rs = null;
        
        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");
            
            // Prepare SQL query to retrieve ticket details
            String query = "SELECT * from MAIL where message_id = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, mailID);
            rs = pstmt.executeQuery();
            
 %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mail Page</title>
        <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #D6D6D6;
            margin: 0;
            padding: 20px;
            
        }
      
        .mailContainer {
            background-color: #fff;
            border-radius: 5px;
            padding: 20px;
            max-width: 700px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;                
            text-align: left;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            overflow: auto;
        }
        .mailContainer p {
            margin: 0;
            padding: 5px 0;
            word-wrap: break-word;
        }
        .mailContainer strong {
            font-weight: bold;
        }
        .titlebar{
            background-color: black;
            color:white;
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            font-size: 26px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .back-button {
            display: inline-block;
            background: none;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin-left: 5px;
            font-size: 20px;
        }
        .mail{
            margin: 0 auto;
        }
    </style>
    </head>
    <body>
        <div class="titlebar">
            <a href="AContact.jsp" class="back-button">&#8592</a>
            <div class="mail">View Mail</div>
        </div><br><br>
        <%
            if (rs.next()) {
                
        %>
        <div class="mailContainer" id="mailContainer">
        <p><strong>From :</strong> <%= rs.getString("sender_email") %></p>
        <p><strong>Sender Type :</strong> <%= rs.getString("sender_type") %></p>
        <p><strong>To :</strong> <%= rs.getString("receiver_email") %></p>
        <p><strong>Receiver Type :</strong> <%= rs.getString("receiver_type") %></p>
        <p><strong>Date :</strong> <%= rs.getString("sent_date") %></p>
        <p><strong>Subject :</strong> <%= rs.getString("subject") %></p>
        <p><strong>Content :</strong> <%= rs.getString("message") %></p>
        </div>
        <%
            } else {
                // If ticket doesn't exist
                 out.println("Mail not found.");
            }   
    %>
    </body>
</html>
<%
            
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            // Close database resources
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
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

