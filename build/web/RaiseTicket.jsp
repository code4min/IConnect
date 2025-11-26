<%-- 
    Document   : RaiseTicket
    Created on : 22-Feb-2024, 10:21:01 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String userID = request.getParameter("userID");
    if (userID == null) {
        userID = (String) session.getAttribute("userID");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Raise Ticket</title>
    <link rel="stylesheet" type="text/css" href="raise_ticket.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #FF455B;
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
        select, input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        select {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="#555" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position-x: 100%;
            background-position-y: 50%;
            background-size: 16px;
            padding-right: 30px;
        }
        textarea {
            height: 100px;
        }
        button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #FF455B;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: black;
        }
    </style>
</head>
<body>
    <br><br>
<div class="container">
    <h2>Raise Ticket</h2>
    <form action="TicketAction.jsp" method="post">
        <input type="hidden" name="userID" value="<%=userID%>">
        <label for="tkt">Category:</label>
        <select name="ticketType" id="tkt">
            <option value="1">Hardware</option>
            <option value="2">Applications</option>
            <option value="3">Operating System</option>
            <option value="4">Network</option>
        </select>
        <label for="pkt">Ticket Priority:</label>
        <select name="ticketPriority" id="pkt">
            <option value="high">High Priority</option>
            <option value="medium">Medium Priority</option>
            <option value="low">Low Priority</option>
        </select>
        <label for="subject">Subject:</label>
        <input type="text" name="subject" id="subject" required>
        <label for="tkt_content">Content:</label>
        <textarea id="tkt_content" name="tkt_content" rows="5" cols="10"></textarea>
        <button type="submit">Submit Ticket</button>
    </form>
</div>
</body>
</html>
