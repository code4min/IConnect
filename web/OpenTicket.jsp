<%-- 
    Document   : OpenTicket
    Created on : 02-Mar-2024, 2:00:33 pm
    Author     : Sneha
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Open Ticket</title>
    <link rel="stylesheet" type="text/css" href="OpenTicket.css">
    <link rel="stylesheet" type="text/css" href="Notes.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>   
    function reloadPage() {
        location.reload();
}

function resolution() {
     $('#boxy').html('');
    var resolutionTextarea = $('<textarea>').attr({
        id: 'resolutionTextarea',
        placeholder: 'Enter resolution steps...',
        rows: 20,
        cols: 70 
    });
    var submitResolutionButton = $('<button>').attr({
        type: 'button',
        id: 'submitResolutionButton',
        onclick: 'submitResolution()'
    }).text('Submit Resolution');
    $('#boxy').append(resolutionTextarea).append('<br>').append(submitResolutionButton);   
}

function submitResolution() {
    var ticketID = $("#ticketID").val();
    var resolutionSteps = $("#resolutionTextarea").val();
    
    $.ajax({
        type: 'POST',
        url: 'StoreResolution.jsp', // Change the URL to your actual server endpoint
        data: { ticketID: ticketID, resolutionSteps: resolutionSteps },
        success: function(response) {
            alert('Resolution steps stored successfully');
        },
        error: function(xhr, status, error) {
            console.error(error);
            alert('Error storing resolution steps');
        }
    });
}

function redirectToDueDate() {
    
    $('#boxy').html('');
    var ticketID = $('#boxy').data('ticket-id');
    var dueDateInput = $('<input>').attr({
        type: 'text',
        id: 'dueDateInput',
        placeholder: 'Select due date'
    });
    $('#boxy').append(dueDateInput);
     $('#dueDateInput').datepicker({
        dateFormat: 'yy-mm-dd', 
        onSelect: function(date) {
            $.ajax({
                type: 'POST',
                url: 'UpdateDueDate.jsp',
                data: { ticketID: ticketID, dueDate: date },
                success: function(response) {
                    alert('Due date updated successfully');
                },
                error: function(xhr, status, error) {
                    console.error(error);
                    alert('Error updating due date');
                }
            });
        }
    });
}
       

function closeTicket() {
    var ticketID = "<%= request.getParameter("ticketIDs") %>"; // Assuming only one ticket ID is selected
    $.ajax({
        type: 'POST',
        url: 'CloseTicket.jsp',
        data: { ticketID: ticketID },
        success: function(response) {
            alert('Ticket closed successfully');
            window.location.href = 'TicketOverview.jsp'; // Redirect to TicketOverview.jsp
        },
        error: function(xhr, status, error) {
            console.error(error);
            alert('Error closing ticket');
        }
    });
}

</script>
<style>
    body{
            background-color: #C9E9EF;
    }
   .title{
            background-color: black;
            color:white;
            text-align: center;
            margin-bottom: 5px;
            padding: 5px;
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
    .openTicket{
            margin: 0 auto;
    }
    .container {
          position: relative;
          height: calc(90vh - 30px); 
    }

    .section1, .section2 {
            padding: 5px;
            position: absolute;
            /* Add border around the sections */
    }

        .section1 {
          left: 0;
          width: 50%;
          height: 100%;
          background-color: white;/* Take up 60% of the container's width */
        }

        .section2 {
           right: 0;
           width:47%;
           height: 100%;
           background-color: #f9f9f9;
           box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);/* Take up 40% of the container's width */
        }

        #div7{
            border-radius: 4px;
            width: 98%;
            background-color: #C9E9EF;
            color: black;
            font-family: Arial;
            font-size: 25px;
            font-weight: bold;
            padding: 5px;
            margin-bottom: 7px;
        }
        #div8{
            border-radius: 4px;
            width: 98%;
            background-color: #C9E9EF;
            color: black;
            font-family: Arial;
            font-size: 25px;
            font-weight: bold;
            padding: 5px;
            margin-bottom: 7px;
        }
        taskbar {
            background-color: #f0f0f0;
            padding: 10px;
            text-align: center;
        }

        .taskbar-button {
            background-color: black; /* Green */
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }

        .taskbar-button:hover {
            background-color: #4CAF50; /* Darker Green */
        }
        #boxy{
            position: absolute;
            top: 30%;
            left: 30%;
            transform: translate(-30%, -15%);
            background-color: #C5D1FF;
            width: 80%;
            height: 60%;
            padding: 25px;
        }
        #CloseTicket{
            position: absolute;
            bottom: 15px; /* 5px from the bottom */
            right: 15px;
            background-color: black; /* Green */
            border: none;
            color: white;
            text-align: center;
            padding: 10px 20px;
            text-decoration: none;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }
        #CloseTicket:hover{
            background-color: #4CAF50;
        }
        #submitResolutionButton {
        background-color: black; /* Green */
        border: none;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin-top: 10px;
        cursor: pointer;
        border-radius: 5px;
    }

    #submitResolutionButton:hover {
        background-color: #4CAF50; /* Darker Green */
    }
    .noteContainer {
        margin-top: 10px;
        display: flex;
        align-items: center;
    }
    
    .noteTextarea {
        flex: 1;
        margin-right: 10px;
    }
    #addNoteButton{
        background-color: black;
        color:white
    }
    #addNoteButton:hover{
        background-color: #FF4E7E;
    }
    .submitNoteButton,
    .deleteNoteButton {
        background-color: black; /* Green */
        border: none;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin-right: 5px;
        cursor: pointer;
        transition-duration: 0.4s;
        border-radius: 4px;
    }

    .submitNoteButton:hover,
    .deleteNoteButton:hover {
        background-color: #FF4E7E; /* Darker Green */
    }

</style>
</head>
<body>
    <input type="hidden" id="ticketID" value="<%= request.getParameter("ticketIDs") %>">
    <input type="hidden" id="agentID" value="<%= request.getParameter("agentID") %>">
     
    <div class="title">
        <a href="TicketOverview.jsp" class="back-button">&#8592</a>
        <div class="openTicket">Ticket</div>
    </div>    
    <div class="container">
        <div class="section1">
            
<%
    // Retrieving ticketIDs from the URL parameter
    String[] ticketIDs = request.getParameterValues("ticketIDs");
    String agentID = request.getParameter("agentID");

    if (ticketIDs != null && ticketIDs.length > 0) {
        Connection conn = null;
        PreparedStatement pstmtTicket = null;
        PreparedStatement pstmtComments = null;
        ResultSet rsTicket = null;
        ResultSet rsComments = null;
        PreparedStatement pstmt = null;

        try {
            // Establishing database connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "db_name", "db_pass");
            
            
            // Iterating through each ticket ID to display details
            for (String ticketID : ticketIDs) {
                session.setAttribute("ticketID", ticketID);
                // Query to retrieve ticket details
                String timeQuery = "UPDATE TICKET SET Open_DateTime = ? WHERE tID = ?";
                pstmt = conn.prepareStatement(timeQuery);
                pstmt.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
                pstmt.setString(2, ticketID);
                pstmt.executeUpdate();
            
            
                String queryTicket = "SELECT * FROM TICKET WHERE tID=?";
                pstmtTicket = conn.prepareStatement(queryTicket);
                pstmtTicket.setString(1, ticketID);
                rsTicket = pstmtTicket.executeQuery();

                // Display ticket details
                while (rsTicket.next()) {
                    String ticketType = rsTicket.getString("tType");
                    String ticketPriority = rsTicket.getString("priority");
                    String ticketStatus = rsTicket.getString("TicketStatus");
                    String creation_date = rsTicket.getString("Creation_Date");
                    String due_date = rsTicket.getString("due_date");
                    String ticketSubject = rsTicket.getString("subject");
                    String ticketContent = rsTicket.getString("tcontent");

                    // Set ticket status to "open"
                    ticketStatus = "OPEN";
                    String updateQuery = "UPDATE TICKET SET TicketStatus = ? WHERE tID = ?";
                    PreparedStatement pstmtUpdate = conn.prepareStatement(updateQuery);
                    pstmtUpdate.setString(1, ticketStatus);
                    pstmtUpdate.setString(2, ticketID);
                    pstmtUpdate.executeUpdate();
                    pstmtUpdate.close();

                    // Query to retrieve comments associated with the ticket
                    String queryComments = "SELECT * FROM COMMENTS WHERE tID=?";
                    pstmtComments = conn.prepareStatement(queryComments);
                    pstmtComments.setString(1, ticketID);
                    rsComments = pstmtComments.executeQuery();

%>
                    
    <div id="div7">Ticket Details</div>
            <div class="taskbar">
                <button class="taskbar-button" onclick="reloadPage()">VIEW</button>                
                <button class="taskbar-button" onclick="redirectToDueDate()">SET DUE DATE</button>
                <button class="taskbar-button" onclick="resolution()">RESOLUTION</button>
            </div>
    
    <div id="boxy" data-ticket-id="<%= ticketID %>">
                    <p><strong>Ticket ID: </strong> <%= ticketID %></p>
                    <p><strong>Ticket Type: </strong> <%= ticketType %></p>
                    <p><strong>Ticket Priority: </strong> <%= ticketPriority %></p>
                    <p><strong>Ticket Status: </strong> <%= ticketStatus %></p>
                    <p><strong>Creation Date & Time: </strong><%= creation_date %></p>
                    <p><strong>Due Date: </strong><%= due_date %></p>
                    <p><strong>Ticket Subject: </strong> <%= ticketSubject %></p>
                    <p><strong>Ticket Content: </strong> <%= ticketContent %></p>

                    <h3>Comments</h3>
                    <ul>
<%
                    // Display comments
                    while (rsComments.next()) {
                        String comment = rsComments.getString("comment");
%>
                        <li><%= comment %></li>
<%
                    }
%>
                    </ul>
    </div>
                    <button id="CloseTicket" onclick="closeTicket()">CLOSE</button>
                    </div>
    <div class="section2" >
    <div id="div8">Notes</div>
            <br>
                    <div id="notesSection">
                        
                        <button id="addNoteButton" >ADD</button>
                        <%
                            String queryExistingNotes = "SELECT * FROM NOTES WHERE ticketID=?";
                            pstmtComments = conn.prepareStatement(queryExistingNotes);
                            pstmtComments.setString(1, ticketID);
                            rsComments = pstmtComments.executeQuery();
                            while (rsComments.next()) {
                                String noteContent = rsComments.getString("noteText");
                        %>
                        <div class="noteContainer">
                                    <input type="checkbox">
                                    <textarea class="noteTextarea"><%= noteContent %></textarea>
                                    <button class="submitNoteButton" style="display:none;">SUBMIT</button>
                                    <button class="deleteNoteButton" style="display:none;">DELETE</button>
                                </div>
                        <%
                            }
                        %>
                       
                    </div>
        </div>
<script>
    $(document).ready(function() {
    // Retrieve ticketID and agentID values
    var ticketID = $("#ticketID").val();
    var agentID = $("#agentID").val();
    
    // Function to handle checkbox click event
    $(document).on("click", ".noteContainer input[type='checkbox']", function() {
        var container = $(this).closest(".noteContainer");
        var submitButton = container.find(".submitNoteButton");
        var deleteButton = container.find(".deleteNoteButton");
        
        // Toggle visibility of submit and delete buttons based on checkbox state
        if ($(this).is(":checked")) {
            submitButton.show();
            deleteButton.show();
            // Store ticketID and agentID as data attributes of the checkbox container
            container.data("ticketID", ticketID);
            container.data("agentID", agentID);
        } else {
            submitButton.hide();
            deleteButton.hide();
        }
    });

    // Function to handle add note button click event
    $("#addNoteButton").click(function() {
        var newNote = $("<div class='noteContainer'><input type='checkbox'><textarea class='noteTextarea'></textarea><button class='submitNoteButton' style='display:none;'>SUBMIT</button><button class='deleteNoteButton' style='display:none;'>DELETE</button></div>");
        $("#notesSection").append(newNote);
    });

    // Function to handle delete note button click event
    
        
   
    $(document).on("click", ".deleteNoteButton", function() {
        var container = $(this).closest(".noteContainer");
        var ticketID = container.data("ticketID");
        var agentID = container.data("agentID");
        var noteContent = container.find(".noteTextarea").val();

        // Make AJAX call to store note in database
        $.ajax({
            type: 'POST',
            url: 'DeleteNote.jsp', // Change the URL to your actual server endpoint
            data: { ticketID: ticketID, agentID: agentID, noteContent: noteContent },
            success: function(response) {
                container.remove();
                alert('Note deleted successfully');                
            },
            error: function(xhr, status, error) {
                console.error(error);
                alert('Error adding note');
            }
        });
    });

    // Function to handle submit note button click event
    $(document).on("click", ".submitNoteButton", function() {
        var container = $(this).closest(".noteContainer");
        var ticketID = container.data("ticketID");
        var agentID = container.data("agentID");
        var noteContent = container.find(".noteTextarea").val();

        // Make AJAX call to store note in database
        $.ajax({
            type: 'POST',
            url: 'StoreNote.jsp', // Change the URL to your actual server endpoint
            data: { ticketID: ticketID, agentID: agentID, noteContent: noteContent },
            success: function(response) {
                alert('Note added successfully');
            },
            error: function(xhr, status, error) {
                console.error(error);
                alert('Error adding note');
            }
        });
    });
});
</script>

<%
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rsTicket != null) rsTicket.close();
                if (rsComments != null) rsComments.close();
                if (pstmtTicket != null) pstmtTicket.close();
                if (pstmtComments != null) pstmtComments.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    } else {
        out.println("<p>No ticket selected.</p>");
    }
%>
</div>
</body>
</html>
