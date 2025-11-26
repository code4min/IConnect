<%-- 
    Document   : viewFeedback
    Created on : 01-Apr-2024, 3:24:14 am
    Author     : Sneha
--%>

<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Feedback</title>
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
        .feedback{
            margin: 0 auto;
        }
        .feedbackContainer {
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
        .feedbackContainer p {
            margin: 0;
            padding: 5px 0;
            word-wrap: break-word;
        }
        .feedbackContainer strong {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="titlebar">
            <a href="Feedback.jsp" class="back-button">&#8592</a>
            <div class="feedback">View Feedback</div>
        </div><br><br>
            <% 
            String feedbackIDsParam = request.getParameter("feedbackIDs");
            if (feedbackIDsParam != null && !feedbackIDsParam.isEmpty()) {
                String[] feedbackIDs = feedbackIDsParam.split(",");
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    // Establish database connection
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");
                    
                    // Prepare SQL query to fetch feedback details based on ticket IDs
                    String query = "SELECT f.ticketID, f.feedback, f.created_at, t.subject, t.Resolution_DateTime FROM FEEDBACK f INNER JOIN TICKET t ON f.ticketID=t.tID WHERE feedbackID IN (";
                    for (int i = 0; i < feedbackIDs.length; i++) {
                        query += "?";
                        if (i < feedbackIDs.length - 1) {
                            query += ",";
                        }
                    }
                    query += ")";
                    pstmt = conn.prepareStatement(query);
                    
                    // Set ticket IDs as parameters
                    for (int i = 0; i < feedbackIDs.length; i++) {
                        pstmt.setString(i + 1, feedbackIDs[i]);
                    }
                    
                    // Execute query
                    rs = pstmt.executeQuery();
                    
                    // Iterate over result set and display feedback details
                    while (rs.next()) {
            %>
                <div class="feedbackContainer" id="feedbackContainer">
                    <p><strong>Ticket ID:</strong> <%= rs.getString("ticketID") %></p>
                    <p><strong>Subject :</strong> <%= rs.getString("subject") %></p>
                    <p><strong>Ticket Resolved On :</strong> <%= rs.getString("Resolution_DateTime") %></p>
                    <p><strong>Feedback Created On :</strong> <%= rs.getString("created_at") %></p>
                    <p><strong>Feedback :</strong> <%= rs.getString("feedback") %></p>
                    
                    </div>
            <% 
                    }
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
            } else {
            %>
                
                    <p>No feedback to display.</p>
                
            <% } %>
</body>
</html>
