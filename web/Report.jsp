<%-- 
    Document   : Report
    Created on : 19-Mar-2024, 10:41:30 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>REPORT</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ACCBFF;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: black;
        }
        .section {
            margin-bottom: 20px;
        }
        .section h3 {
            margin-left: 10px;
            color: black;
        }
        .section p {
            font-size: 20px;
            margin: 0;
            color: black;
            margin-left: 15px;
            padding: 5px;
        }
        .top2{
            background-color: black;
                color:white;
                font-weight: bold;
                font-size: 15px;
                text-align: center;
                padding: 5px;
        }
        .top3, .top4,.top5, .top6, .top7, .top8{
            color: #009B7F;
                font-weight: bold;
                font-size: 25px;
                text-align: left;
                padding: 5px;
                margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="section">
            <div class="top2"> <h1>REPORT</h1></div>
    <% 
        String[] ticketIDs = request.getParameterValues("ticketIDs");
        String agentID= request.getParameter("agentID");
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","db_name","db_pass");
            
            for (String ticketID : ticketIDs) {
                // Retrieve ticket details
                String ticketQuery = "SELECT * FROM TICKET WHERE tID=?";
                pstmt = conn.prepareStatement(ticketQuery);
                pstmt.setString(1, ticketID);
                rs = pstmt.executeQuery();
                if (rs.next()) {
            %>
                    
            <div class="top3">Ticket Details</div>
                <p><strong>Ticket ID: </strong><%= rs.getString("tID")%> </p>
                    <p><strong>Ticket Type:</strong> <%=  rs.getString("tType")%></p>
                <p><strong> Ticket Priority: </strong><%= rs.getString("Priority")%></p>
                <p><strong>Ticket Creation Date:</strong> <%= rs.getString("Creation_Date") %></p>
                   <p><strong> Ticket Due Date:</strong> <%= rs.getString("due_date")%></p>
                   <p><strong>Ticket Subject:</strong> <%= rs.getString("subject") %></p>
                    <p><strong>Ticket Content:</strong> <%= rs.getString("tcontent")%></p>
                    
                    <div class="top4">Agent Work </div>
                    <p><strong>Ticket Open Date:</strong> <%= rs.getString("Open_DateTime")%></p>
                    <p><strong>Ticket Resolution Date:</strong> <%= rs.getString("Resolution_DateTime") %></p>
                    <p><strong>Ticket Resolution Steps:</strong> <%= rs.getString("resolution_steps")%></p>
            <%
                }
                rs.close();
                pstmt.close();
            %>
        </div>
            <div class="section">
                <div class="top5">Comments</div>
            <%
                // Retrieve comments for the ticket
                String commentsQuery = "SELECT * FROM COMMENTS WHERE tID=?";
                pstmt = conn.prepareStatement(commentsQuery);
                pstmt.setString(1, ticketID);
                rs = pstmt.executeQuery();
                while (rs.next()) {
            %>
                   
                <p><%= rs.getString("comment") %></p>
            <%    
                }
                rs.close();
                pstmt.close();
            %>
            </div>
            <div class="section">
                <div class="top6">Notes</div>
            <%
                // Retrieve notes for the ticket
                String notesQuery = "SELECT * FROM NOTES WHERE ticketID=?";
                pstmt = conn.prepareStatement(notesQuery);
                pstmt.setString(1, ticketID);
                rs = pstmt.executeQuery();
                while (rs.next()) {
            %>
                    
                 <p><%= rs.getString("noteText") %></p>
            <%
                }
                rs.close();
                pstmt.close();
            %>
            </div>
            <div class="section">
                <div class="top7">User Information</div>
            <%
                // Retrieve user information
                String userQuery = "SELECT u.username FROM USERS u JOIN TICKET t ON u.userID = t.uID WHERE t.tID = ?";
                pstmt = conn.prepareStatement(userQuery);
                pstmt.setString(1, ticketID); // Assuming there's a userID associated with the ticket
                rs = pstmt.executeQuery();
                if (rs.next()) {
            %>
                   
                <p><strong>Created By: </strong> <%= rs.getString("username") %></p>
            <%
                }
                rs.close();
                pstmt.close();
            %>
            </div>
            <div class="section">
                <div class="top8">Agent Information</div>
            <%
                String agentQuery = "SELECT * FROM AGENTS where agentID=?";
                pstmt = conn.prepareStatement(agentQuery);
                pstmt.setString(1, agentID); // Assuming there's a userID associated with the ticket
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    // Display user information
            %>       
                <p><strong>Resolved By:</strong> <%= rs.getString("username") %></p>
            <%       
                }
                rs.close();
                pstmt.close();
            %>
            </div>
        <%    
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } 
    %>
    
    <%-- Store report in the TEXT format in the REPORT table --%>
    <% 
        // Construct report content
        StringBuilder reportContent = new StringBuilder();
        try {
            for (String ticketID : ticketIDs) {
                // Append ticket details
                reportContent.append("Ticket ID: ").append(ticketID).append("\n");

                // Retrieve and append ticket details
                String ticketQuery = "SELECT * FROM TICKET WHERE tID=?";
                pstmt = conn.prepareStatement(ticketQuery);
                pstmt.setString(1, ticketID);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    reportContent.append("Ticket Type: ").append(rs.getString("tType")).append("\n");
                    reportContent.append("Ticket Priority: ").append(rs.getString("Priority")).append("\n");
                    reportContent.append("Ticket Creation Date: ").append(rs.getString("Creation_Date")).append("\n");
                    reportContent.append("Ticket Due Date: ").append(rs.getString("due_date")).append("\n");
                    reportContent.append("Subject: ").append(rs.getString("subject")).append("\n");
                    reportContent.append("Ticket Content: ").append(rs.getString("tcontent")).append("\n");
                    reportContent.append("AGENT WORK: ").append("\n");
                    reportContent.append("Ticket Open Date: ").append(rs.getString("Open_DateTime")).append("\n");
                    reportContent.append("Ticket Resolution Date: ").append(rs.getString("Resolution_DateTime")).append("\n");
                    reportContent.append("Resolution Steps: ").append(rs.getString("resolution_steps")).append("\n");
                
                }
                rs.close();
                pstmt.close();

        // Retrieve and append comments for the ticket
        String commentsQuery = "SELECT * FROM COMMENTS WHERE tID=?";
        pstmt = conn.prepareStatement(commentsQuery);
        pstmt.setString(1, ticketID);
        rs = pstmt.executeQuery();
        reportContent.append("Comments:\n");
        while (rs.next()) {
            reportContent.append("- ").append(rs.getString("comment")).append("\n");
        }
        rs.close();
        pstmt.close();
        
        // Retrieve and append notes for the ticket
        String notesQuery = "SELECT * FROM NOTES WHERE ticketID=?";
        pstmt = conn.prepareStatement(notesQuery);
        pstmt.setString(1, ticketID);
        rs = pstmt.executeQuery();
        reportContent.append("Notes:\n");
        while (rs.next()) {
            reportContent.append("- ").append(rs.getString("noteText")).append("\n");
        }
        rs.close();
        pstmt.close();
        
        // Retrieve and append user information for the ticket
        String userQuery = "SELECT u.username FROM USERS u JOIN TICKET t ON u.userID = t.uID WHERE t.tID = ?";
        pstmt = conn.prepareStatement(userQuery);
        pstmt.setString(1, ticketID);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            reportContent.append("Created By: ").append(rs.getString("username")).append("\n");
            // Add more user details as needed
        }
        rs.close();
        pstmt.close();
        
        String agentQuery = "SELECT * FROM AGENTS where agentID=?";
        pstmt = conn.prepareStatement(agentQuery);
        pstmt.setString(1, agentID); // Assuming there's a userID associated with the ticket
        rs = pstmt.executeQuery();
        if (rs.next()) {
            reportContent.append("Resolved By: ").append(rs.getString("username")).append("\n");
        }
        rs.close();
        pstmt.close();
        
        // Add a separator between tickets
        reportContent.append("\n-----------------------------\n");
    }
} catch (Exception e) {
    // Handle exceptions
    out.println("Error: " + e.getMessage());
} finally {
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    } catch (Exception e) {
        // Handle exceptions
        out.println("Error in closing resources: " + e.getMessage());
    }
}

       
        
        // Insert report content into the REPORT table
        try {
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","db_name","db_name");
            String insertQuery = "INSERT INTO REPORT (report, agentID, ticketID) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(insertQuery);
            pstmt.setString(1, reportContent.toString());
            pstmt.setString(2, agentID);
            String ticketIDsString = String.join(",", ticketIDs);
            pstmt.setString(3, ticketIDsString);
            pstmt.executeUpdate();
        } catch (Exception e) {
            out.println("Error storing report: " + e.getMessage());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                out.println("Error in closing resources: " + e.getMessage());
            }
        }
    %>
</body>
</html>
