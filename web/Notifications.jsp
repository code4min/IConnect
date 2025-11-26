<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Notifications</title>
    <style>
        .notification {
            border: 1px solid #ddd;
            margin: 10px;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 5px;
        }
        .notification p {
            margin: 5px 0;
        }
        .delete-button {
            background-color: #187A7D;
            color: white;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;
        }
        .delete-button:hover{
            background-color: #C9E9EF;
            color: black;
        }
        .title{
                background-color: black;
            color:white;
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            font-size: 26px;
            font-weight: bold;
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
        .notification_title{
            margin: 0 auto;
        }
        body{
            background-color: #C9E9EF;
        }
    </style>
</head>
<body>
    <div class="title">
        <a href="AgentPage.jsp" class="back-button">&#8592</a>
        <div class="notification_title">Notifications</div>
    </div>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM NOTIFICATIONS");
            while (rs.next()) {
                String agentID = rs.getString("agentID");
                String ticketID = rs.getString("ticketID");
                String message = rs.getString("message");
    %>
    <div class="notification">
        <p>Agent ID: <%= agentID %></p>
        <p>Ticket ID: <%= ticketID %></p>
        <p>Message: <%= message %></p>
        <button class="delete-button" onclick="deleteNotification(<%= ticketID %>)">Delete</button>
    </div>
    <%
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
    <script>
        function deleteNotification(ticketID) {
            if (confirm("Are you sure you want to delete this notification?")) {
                window.location.href = "DeleteNotificationAction.jsp?ticketID=" + ticketID;
            }
        }
    </script>
</body>
</html>
