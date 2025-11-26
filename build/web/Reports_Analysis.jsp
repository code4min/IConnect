<%-- 
    Document   : Reports_Analysis
    Created on : 27-Mar-2024, 6:06:46 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reports & Analysis </title>
        <style>
            .title{
            background-color: #00BD62;
            color:white;
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            font-family: sans-serif;
            font-size: 26px;
            height: 50px;
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
        .report_analysis_title{
            margin: 0 auto;
        }
        body{
            background-color: white;
        }
        .task-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 99%;
            background-color: #f2f2f2; /* Match the background color of the table header */
            padding: 10px; /* Adjust padding as needed */
            border-bottom: 1px solid #ddd; /* Adjust as needed */
        }

        .task-bar button {
            background-color: black; /* Green background */
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 0; /* Remove margin */
            flex-grow: 1;
            cursor: pointer;
            transition-duration: 0.4s; /* Adjust as needed */
        }
        
        .task-bar button:hover {
            background-color: #cccccc;
            color: black;
        }
        .feedback{
            display: none;
        }
        .feedbackContainer {
            border: 1px solid #ddd;
            margin: 10px;
            padding: 10px;
            background-color: #BEDFB0;
            border-radius: 5px;
        }
        .feedbackContainer p {
            margin: 5px 0;
        }
        .report{
            display: none;
        }
        .reportContainer {
            border: 1px solid #ddd;
            margin: 10px;
            padding: 10px;
            background-color: #BEDFB0;
            border-radius: 5px;
        }
        .reportContainer p {
            margin: 5px 0;
        }
        .delete-button, .delete-button2 {
            background-color: #40693F;
            color: white;
            border: none;
            border-radius: 3px;
            padding: 5px 10px;
            cursor: pointer;
        }
        .delete-button:hover{
            background-color: #295228;
            color: white;
        }
        .delete-button2:hover{
            background-color: #295228;
            color: white;
        }
    </style>
    <script>
            
            if ('<%= request.getParameter("deleteReport") %>' === 'success') {
                alert('REPORT DELETED SUCCESSFULLY!');
            }
        </script>
    </head>
    <body>
         <div class="title">
            <a href="AdminPage.jsp" class="back-button">&#8592</a>
            <div class="report_analysis_title">REPORTS & ANALYSIS</div>
        </div>
        <div class="task-bar">
                <button onclick="viewFeedback()">Feedback</button>
                <button onclick="viewReport()">Reports</button>
        </div>
        <div class="feedback" id="feedbackContent">
<%
        Connection conn = null;
        Statement stmt = null;
        Statement ptmt = null;
        ResultSet rs = null;
        ResultSet rsp = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM FEEDBACK");
            while (rs.next()) {
                String feedbackID = rs.getString("feedbackID");
                String userID = rs.getString("userID");
                String ticketID = rs.getString("ticketID");
                String feedback = rs.getString("feedback");
    %>
    <div class="feedbackContainer">
        <p><strong>Feedback ID: </strong><%= feedbackID %></p>
        <p><strong>User ID: </strong><%= userID %></p>
        <p><strong>Ticket ID: </strong><%= ticketID %></p>
        <p><strong>Feedback: </strong><%= feedback %></p>
        <button class="delete-button" onclick="deleteFeedback(<%= ticketID %>)">Delete</button>
    </div>
    <%
            }
    %>
        </div>
        <div class="report" id="reportContent">
<%
         ptmt = conn.createStatement();
            rsp = ptmt.executeQuery("SELECT * FROM REPORT");
            while (rsp.next()) {
                String agentID = rsp.getString("agentID");
                String ticketID = rsp.getString("ticketID");
                String reportID = rsp.getString("reportID");
    %>
    <div class="reportContainer">
        <p>Agent ID: <%= agentID %></p>
        <p>Ticket ID: <%= ticketID %></p>
        <p>Report ID: <%= reportID %></p>
        <button class="delete-button2" onclick="viewReportByAdmin(<%= reportID %>)">View Full Report</button>
        <button class="delete-button2" onclick="deleteReport(<%= ticketID %>)">Delete Report</button>
    </div>
    <%
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (rsp != null) rsp.close();
            if (ptmt != null) ptmt.close();
            if (conn != null) conn.close();
        }
    %>   
        </div>
    </body>
</html>
<script>
    function viewFeedback() {
            var feedbacktDiv = document.getElementById("feedbackContent");
            feedbacktDiv.style.display = "block"; // Display the about section
            feedbacktDiv.scrollIntoView();
        }
        
        function viewReport() {
            var reportDiv = document.getElementById("reportContent");
            reportDiv.style.display = "block"; // Display the about section
            reportDiv.scrollIntoView();        }
</script>
<script>
        function deleteFeedback(ticketID) {
            if (confirm("Are you sure you want to delete this notification?")) {
                window.location.href = "DeleteFeedbackByAdmin.jsp?ticketID=" + ticketID;
            }
        }
    </script>
<script>
        function viewReportByAdmin(reportID) {
                window.location.href = "ViewReportByAdmin.jsp?reportID=" + reportID;           
        }
</script>
<script>
        function deleteReport(ticketID) {
            if (confirm("Are you sure you want to delete this report?")) {
                window.location.href = "DeleteReportByAdmin.jsp?ticketID=" + ticketID;
            }
        }
</script>