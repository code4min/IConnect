<%-- 
    Document   : Analysis
    Created on : 25-Feb-2024, 5:48:34 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Analysis</title>
    <style>
        .high-priority { background-color: red; }
        .medium-priority { background-color: orange; }
        .low-priority { background-color: pink; }
        .task-bar { display: none; }
    </style>
    <style>
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
        .report{
            margin: 0 auto;
        }
        body{
            background-color: #C9E9EF;
        }
        .taskbar{
            display: none;
                background:none;
                border: none;
                border-radius: 5px;
                padding: 10px;
                justify-content: center;
            }
            .taskbar button {
                background-color: black;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin: 0 5px;
                font-size: 16px;
                margin-right: 10px;
            }

        .taskbar button:hover {
            background-color: white;
            color:black;
        }
        
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }
            th {
                background-color: #f2f2f2;
            }
</style>
    <script>
        function toggleTaskbar() {
            var checkBoxes = document.querySelectorAll('input[type="checkbox"]');
            var taskBar = document.getElementById('taskbar');
            
            var anyChecked = false;
            checkBoxes.forEach(function(checkbox) {
                if (checkbox.checked) {
                    anyChecked = true;
                }
            });

            if (anyChecked) {
                taskBar.style.display = 'block';
            } else {
                taskBar.style.display = 'none';
            }
        }
    </script>
</head>
<body>
    <div class="title">
        <a href="AgentPage.jsp" class="back-button">&#8592</a>
        <div class="report">Reports & Analysis</div>
    </div>
    
    <div id="taskbar" class="taskbar">
        <button onclick="openReport()">VIEW REPORT</button>
        <button onclick="deleteReport()">DELETE</button>
        <br>
    </div>
    <br>
    <table style="background-color: white">
        <tr>
            <th>Select</th>
            <th>Ticket ID</th>
            <th>Subject</th>
            <th>Priority</th>
        </tr>
<% 
            String agentID = (String) session.getAttribute("agentID");
            Connection conn=null;
            PreparedStatement pstmt=null;
            ResultSet rs = null;
            try{
                Class.forName("com.mysql.jdbc.Driver");
                conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","root","admin");
                
                String deletedQuery = "SELECT DeletedID FROM DELETED_REPORTS";
                Set<String> deletedIDs = new HashSet<>();
                pstmt = conn.prepareStatement(deletedQuery);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    deletedIDs.add(rs.getString("DeletedID"));
                }
                
                String placeholders = String.join(",", Collections.nCopies(deletedIDs.size(), "?"));
                String query = "SELECT * FROM TICKET WHERE TicketStatus = 'CLOSED' AND Agent = ?";

                if (!deletedIDs.isEmpty()) {
                    query += " AND tID NOT IN (" + placeholders + ")";
                }
                pstmt=conn.prepareStatement(query);
                pstmt.setString(1, agentID);
                
                int index = 2;
                for (String deletedID : deletedIDs) {
                    pstmt.setString(index++, deletedID);
                }
                
                rs = pstmt.executeQuery();
                while(rs.next()) {
                    String priority = rs.getString("Priority");
                    String priorityClass = "";
                    if ("high".equals(priority)) {
                        priorityClass = "high-priority";
                    } else if ("medium".equals(priority)) {
                        priorityClass = "medium-priority";
                    } else if ("low".equals(priority)) {
                        priorityClass = "low-priority";
                    }
        %>
        <tr>
            <td><input type="checkbox" name="ReportCheckbox" onchange="toggleTaskbar()"></td>
            <td><%= rs.getString("tID") %></td>
            <td><%= rs.getString("subject") %></td>
            <td class="<%= priorityClass %>"></td>
        </tr>
        <% 
                }
            } catch (Exception e) {
                out.println("Error:"+ e.getMessage());
            } finally {
                try {
                    if(rs != null) rs.close();
                    if(pstmt !=null) pstmt.close();
                    if(conn !=null) conn.close();
                } catch(Exception e) {
                    out.println("Error in closing resources: " + e.getMessage());
                }
            }
        %>
    </table>
     <script>
        function openReport() {
            var checkedCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');
        
        
            var ticketIDs = [];
            checkedCheckboxes.forEach(function(checkbox) {
                ticketIDs.push(checkbox.parentNode.nextElementSibling.textContent); // Assuming Ticket ID is in the next cell
            });
            var agentID = '<%= session.getAttribute("agentID") %>';
        
            if (ticketIDs.length > 0) {
                window.location.href = 'Report.jsp?agentID=' + agentID + '&ticketIDs=' + ticketIDs.join(',');
            } else {
                alert('Please select at least one report to open.');
            }
        }
        
        function deleteReport() {
             var checkedCheckboxes = document.querySelectorAll('input[type="checkbox"]:checked');
                var tableRowsToDelete = [];

                checkedCheckboxes.forEach(function(checkbox) {
                    // Get the parent row of the checkbox
                    var tableRow = checkbox.parentNode.parentNode;
                    // Add the row to the array of rows to delete
                    tableRowsToDelete.push(tableRow);
                });

                if (tableRowsToDelete.length > 0) {
                    // Remove each row from the table
                    tableRowsToDelete.forEach(function(row) {
                        row.remove();
                    });

        // Call the deleteRecord.jsp to delete records from the database
                    var ticketIDs = tableRowsToDelete.map(function(row) {
                        return row.cells[1].textContent; // Assuming Ticket ID is in the second cell
                    }).join(',');
        
        // Make AJAX request to delete records from the database
                    var xhr = new XMLHttpRequest();
                    xhr.onreadystatechange = function() {
                        if (xhr.readyState === 4) {
                            if (xhr.status === 200) {
                                // Success
                                alert("Records deleted successfully!");
                            } else {
                                // Error
                                alert("Error deleting records: " + xhr.responseText);
                            }
                        }
                };
                    xhr.open("POST", "DeleteReport.jsp", true);
                    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                    xhr.send("ticketIDs=" + ticketIDs);
            } else {
                alert('Please select at least one report to delete.');
            }
        }
        </script>
</body>
</html>