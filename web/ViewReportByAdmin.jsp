<%-- 
    Document   : ViewReportByAdmin
    Created on : 04-Apr-2024, 4:44:31 am
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Report</title>
    <style>
        .title {
            background-color: black;
            color: white;
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

        body {
            background-color: #BEDFB0;
            font-family: Arial, sans-serif;
        }

        .report-details {
            margin: 0 auto;
            padding: 20px;
            max-width: 800px;
            background-color: white;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .report-details h2 {
            color: #52B253;
            font-size: 20px;
        }

        .report-details p {
            margin: 10px 0;
        }

        .report-details table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .report-details th, .report-details td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .report-details th {
            background-color: #f2f2f2;
        }
        .report_title{
            margin: 0 auto;
        }
    </style>
</head>
<body>
<div class="title">
    <a href="Reports_Analysis.jsp" class="back-button">&#8592</a>
    <div class="report_title">View Report</div>
</div>

<div class="report-details">
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String reportID = request.getParameter("reportID");

            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");

            pstmt = conn.prepareStatement("SELECT * FROM REPORT WHERE reportID = ?");
            pstmt.setString(1, reportID);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                String agentID = rs.getString("agentID");
                String ticketID = rs.getString("ticketID");
                String reportIDFromDB = rs.getString("reportID");
                String report = rs.getString("report");
                String[] reportLines = report.split("\\r?\\n");
    %>
    <h2><strong>Report ID:</strong></h2><p> <%= reportIDFromDB %></p>
    <h2><strong>Agent ID:</strong></h2><p> <%= agentID %></p>
    <h2><strong>Ticket ID:</strong></h2><p> <%= ticketID %></p>
    <h2><strong>Report Details:</strong></h2>
    <%
        for (String line : reportLines) {
    %>
        <p><%= line %></p>
    <%
        }
    %>
</div>
<%
            } else {
                out.println("<p>No report found for the specified ID.</p>");
            }

        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                out.println("Error in closing resources: " + ex.getMessage());
            }
        }
    %>
</body>
</html>
