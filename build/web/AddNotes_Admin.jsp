<%-- 
    Document   : AddNotes_Admin
    Created on : 02-Apr-2024, 8:39:17 pm
    Author     : Sneha
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String adminID = request.getParameter("adminID");
    if (adminID == null) {
        adminID= (String) session.getAttribute("adminID");
    }
    String ticketId = request.getParameter("ticketId");
   
 
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Notes</title>
    <link rel="stylesheet" type="text/css" href="raise_ticket.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color:  #30B46D;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            margin-top: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: black;
        }
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            height: 100px;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: black;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #00BD62;
        }
    </style>
</head>
<body>
    <br><br>
<div class="container">
    <h2>ADD NOTE</h2>
    <form action="AddNotesAction.jsp" method="post">
        <input type="hidden" name="adminID" value="<%=adminID%>">
        <label for="ticketID">Enter Ticket ID:</label>
        <input type="text" name="ticketId" value="<%=ticketId %>" readonly>
        <label for="notes">Note:</label>
        <textarea id="notes" name="notes" rows="5" cols="10"></textarea>
        <button type="submit">Submit</button>
    </form>
</div>
</body>
</html>
