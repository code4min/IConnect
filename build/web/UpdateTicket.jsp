<%-- 
    Document   : UpdateTicket
    Created on : 29-Feb-2024, 7:33:46 pm
    Author     : Sneha
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Establishing database connection
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");

        // Retrieving ticket information based on ticketID parameter
        String ticketID = request.getParameter("ticketID");
        String query = "SELECT tID, tType, TicketStatus, Priority,subject, tcontent FROM TICKET WHERE tID = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, ticketID);
        rs = pstmt.executeQuery();

        // Checking if the ticket exists
        if (rs.next()) {
            // Retrieving ticket details
            String tID = rs.getString("tID");
            String tType = rs.getString("tType");
            String ticketStatus = rs.getString("TicketStatus");
            String priority = rs.getString("Priority");
            String subject= rs.getString("subject");
            String tcontent = rs.getString("tcontent");
            

            // Displaying ticket details in a form for update
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Ticket</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #FF4D62;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #333;
        }
        form {
            background-color: #fff;
            border-radius: 5px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        label {
            font-weight: bold;
        }
        input[type="text"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: black;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        input[type="submit"]:hover {
            background-color: #FF4D62;
        }
        .center-heading {
            text-align: center;
            margin-bottom: 20px; /* Adjust as needed */
        }
    </style>
</head>
<body>
    
    <form action="UpdateTicketAction.jsp" method="post">
        <h1 class="center-heading">Update Ticket</h1>
        <input type="hidden" name="ticketID" value="<%= tID %>"><br>
        <label for="tType">Ticket Type:</label><br>
        <select id="tType" name="tType">
            <option value="1" <%= tType.equals("1") ? "selected" : "" %>>Hardware</option>
            <option value="2" <%= tType.equals("2") ? "selected" : "" %>>Applications</option>
            <option value="3" <%= tType.equals("3") ? "selected" : "" %>>Operating System</option>
            <option value="4" <%= tType.equals("4") ? "selected" : "" %>>Network</option>
        </select><br>
        <input type="hidden" name="ticketStatus" value="<%= ticketStatus %>"> <br>
        <label for="priority">Priority:</label><br>
        <select id="priority" name="priority">
            <option value="high" <%= tType.equals("high") ? "selected" : "" %>>High Priority</option>
            <option value="medium" <%= tType.equals("medium") ? "selected" : "" %>>Medium Priority</option>
            <option value="low" <%= tType.equals("low") ? "selected" : "" %>>Low Priority</option>
        </select><br><br>
        <label for="subject">Subject:</label><br>
        <input type="text" id="subject" name="subject" value="<%= subject %>"><br><br>
        <label for="tcontent">Ticket Content:</label><br>
        <textarea id="tcontent" name="tcontent" rows="5" cols="50"><%= tcontent %></textarea><br>
        
        <input type="submit" value="Update">
    </form>
</body>
</html>
<%
        } else {
            // Ticket not found
            out.println("Ticket not found.");
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

