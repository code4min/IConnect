<%-- 
    Document   : ViewTicket
    Created on : 28-Feb-2024, 4:55:17 pm
    Author     : Sneha
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%
     String[] ticketIDs = null;
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // Check if the "ticketIDs" parameter exists in the request
    String ticketIDsParam = request.getParameter("ticketIDs");
    if (ticketIDsParam != null && !ticketIDsParam.isEmpty()) {
        ticketIDs = ticketIDsParam.split(",");
    } else {
        out.println("No ticket IDs were provided.");
        return; // Exit the JSP page
    }
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Ticket</title>
    <style>
         body {
            font-family: Arial, sans-serif;
            background-color: #D6D6D6;
            margin: 0;
            padding: 20px;
            
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
        .ticket{
            margin: 0 auto;
        }
        .ticketContainer {
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
        .ticketContainer p {
            margin: 0;
            padding: 5px 0;
            word-wrap: break-word;
        }
        .ticketContainer strong {
            font-weight: bold;
        }
    </style>   
</head>
<body>
    <div class="titlebar">
            <a href="UserPage.jsp" class="back-button">&#8592</a>
            <div class="ticket">Ticket Details</div>
        </div><br><br>
            <%
                for (String ticketID : ticketIDs) {
                    String query = "SELECT * FROM TICKET WHERE tID = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, ticketID);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
            %>
            <div class="ticketContainer" id="ticketContainer">
                    <p><strong>Ticket ID:</strong> <%= rs.getString("tID") %></p>
                    <p><strong>Subject :</strong> <%= rs.getString("subject") %></p>
                    <p><strong>Ticket Type :</strong> <%= rs.getString("tType") %></p>
                    <p><strong>Ticket Priority :</strong> <%= rs.getString("Priority") %></p>
                    <p><strong>Ticket Status :</strong> <%= rs.getString("TicketStatus") %></p>
                    <p><strong>Creation Date :</strong> <%= rs.getString("Creation_Date") %></p>
                    <p><strong>Ticket Resolved On :</strong> <%= rs.getString("Resolution_DateTime") %></p>
                    <p><strong>Ticket Content :</strong> <%= rs.getString("tcontent") %></p>
                    
            <%     }
                }
            %>


    <h1>Comments</h1>
            <%
                for (String ticketID : ticketIDs) {
                    String query = "SELECT * FROM COMMENTS WHERE tID = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, ticketID);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
            %>
                <p><strong>Ticket ID:</strong> <%= rs.getString("cID") %></p>
                <p><strong>Subject :</strong> <%= rs.getString("comment") %></p>
            <%     }
                }
            %>
</body>
</html>
<%
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            out.println("Error in closing resources: " + e.getMessage());
        }
    }
%>
