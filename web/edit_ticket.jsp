<%-- 
    Document   : edit_ticket
    Created on : 28-Mar-2024, 1:26:57 am
    Author     : Sneha
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Edit Ticket</title>
    <style>
    body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #30B46D;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        form {
            width: 50%;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        label {
            font-weight: bold;
        }
        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        select {
            width: 50%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            height: 40px;
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
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<%
    // Retrieve the ticket ID from the query parameter
    String ticketId = request.getParameter("ticketId");

    // Check if the ticket ID is provided
    if (ticketId != null && !ticketId.isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");

            // Retrieve ticket details based on ticket ID
            pstmt = conn.prepareStatement("SELECT * FROM TICKET WHERE tID = ?");
            pstmt.setString(1, ticketId);
            rs = pstmt.executeQuery();

            // Check if the ticket exists
            if (rs.next()) {
                // Get ticket details
                String tType = rs.getString("tType");
                String ticketStatus = rs.getString("TicketStatus");
                String priority = rs.getString("Priority");
                String CreationDate= rs.getString("Creation_Date");
                String DueDate= rs.getString("due_date");                
                String subject = rs.getString("subject");
                String tcontent =rs.getString("tcontent");
                String OpenDate= rs.getString("Open_DateTime");
                String ResolutionDate= rs.getString("Resolution_DateTime");
                String ResolutionSteps =rs.getString("resolution_steps");
                // Display the form for editing ticket details
%>
    
    <form action="UpdateTicketAction.jsp" method="post">
        <h1>Edit Ticket</h1>
        <input type="hidden" name="fromPage" value="edit_ticket">
        <input type="hidden" name="ticketID" value="<%= ticketId %>">
        <label for="tType">Ticket Type:</label><br>
        <select id="tType" name="tType">
            <option value="1" <%= tType.equals("1") ? "selected" : "" %>>Hardware</option>
            <option value="2" <%= tType.equals("2") ? "selected" : "" %>>Applications</option>
            <option value="3" <%= tType.equals("3") ? "selected" : "" %>>Operating System</option>
            <option value="4" <%= tType.equals("4") ? "selected" : "" %>>Network</option>
        </select><br>
        <label for="ticketStatus">Ticket Status:</label>
        <input type="text" id="ticketStatus" name="ticketStatus" value="<%= ticketStatus %>" readonly><br>
        <label for="priority">Priority:</label><br>
        <select id="priority" name="priority">
            <option value="high" <%= tType.equals("high") ? "selected" : "" %>>High Priority</option>
            <option value="medium" <%= tType.equals("medium") ? "selected" : "" %>>Medium Priority</option>
            <option value="low" <%= tType.equals("low") ? "selected" : "" %>>Low Priority</option>
        </select><br><br>
        <label for="CreationDate">Creation Date:</label>
        <input type="text" id="CreationDate" name="CreationDate" value="<%= CreationDate %>" readonly><br>
        <label for="dueDate">Due Date:</label>
        <input type="text" id="dueDate" name="dueDate" value="<%= DueDate %>" placeholder="yyyy-mm-dd"><br>
        <label for="subject">Subject:</label>
        <input type="text" id="subject" name="subject" value="<%= subject %>"><br>
        <label for="tcontent">Ticket Content:</label><br>
        <textarea id="tcontent" name="tcontent" rows="5" cols="50"><%= tcontent %></textarea><br>
        <label for="OpenDate">Open Date:</label>
        <input type="text" id="OpenDate" name="OpenDate" value="<%= OpenDate %>" readonly><br>
        <label for="ResolutionDate">Resolution Date:</label>
        <input type="text" id="ResolutionDate" name="ResolutionDate" value="<%= ResolutionDate %>" readonly><br>
        <label for="ResolutionSteps">Ticket Resolution Steps:</label><br>
        <textarea id="ResolutionSteps" name="ResolutionSteps" rows="5" cols="50"><%= ResolutionSteps %></textarea><br>
        <input type="submit" value="Update">
    </form>
<%
            } else {
                // Ticket not found
                out.println("Ticket not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("Error in closing resources: " + e.getMessage());
            }
        }
    } else {
        // Ticket ID not provided
        out.println("Ticket ID is missing.");
    }
%>
</body>
</html>

