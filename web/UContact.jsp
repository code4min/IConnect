<%-- 
    Document   : UContact
    Created on : 21-Mar-2024, 2:01:00?am
    Author     : Sneha
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Contact</title>
    <style>
        #con2{
            width: 99%;
            background-color: black;
            color: white;
            font-family: Arial;
            font-size: 25px;
            font-weight: bold;
            padding: 5px;
            border-radius: 4px;
            
        }
        #con1{
            background-color: black; 
            color: white;
            font-family: LOVELO;
            font-size: 35px;
            font-weight: bold;
            text-align: center;
            padding: 5px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .mail{
            margin: 0 auto;
        }
        .container{
            position: relative;
            height: calc(90vh - 35px);
        }
        .sec1,.sec2{
            padding: 5px;
            position: absolute;
            top: 20px;
        }
        .sec1{
            left: 0;
            width: 50%;
            height: 100%;
        }
        .sec2{
            right: 0;
            width:47%;
            height: 100%;
            background-color: #f9f9f9;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        #inbox1{
            border-radius: 4px;
            width: 100%;
            background-color: white;
            color: black;
            font-family: Arial;
            font-size: 25px;
            font-weight: bold;
            padding: 5px;
        }
        .buttonbar1 {
            display: flex; 
      
        }
        .btnOpen, .btnDel {
            background-color: black; 
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
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
            background-color:#FFC5C5;
            color:black;
        }
        td {
            background-color: white;
        }
        #sendMail{
            background-color: black; 
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
            position: absolute;
            bottom: 15px; /* 5px from the bottom */
            right: 15px;
            
        }
        #sendMail:hover {
            background-color: #FF455B; /* Change background color on hover */
        }
        body{
            background-color: #FF455B;
        }
        form {
            text-align: left;
        }

        label {
            font-weight: bold;
            margin-left: 20px;            
        }

        input[type="text"]{
            width: 70%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        select {
            width: 40%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        textarea{
            width: 90%;
            margin-left: 20px;
            height:200px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;

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
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
function openMail() {
    var checkboxes = document.getElementsByName("mailCheckbox");
    var checkedMessageIDs = [];

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            checkedMessageIDs.push(checkboxes[i].getAttribute("data-mail-id"));
        }
    }

    // Redirect to viewMail.jsp with the selected message_id
    if (checkedMessageIDs.length > 0) {
        window.location.href = 'viewMail.jsp?mailID=' + checkedMessageIDs[0]; // Assuming only one mail can be opened at a time
    } else {
        alert("Please select a mail to open.");
    }
}

function storeCheckedMessageIDs() {
    var checkboxes = document.getElementsByName("mailCheckbox");
    var checkedMessageIDs = [];

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            checkedMessageIDs.push(checkboxes[i].getAttribute("data-mail-id"));
        }
    }

    // Store the checked message IDs somewhere (e.g., in a hidden input field)
    var hiddenInput = document.getElementById("checkedMessageIDs");
    hiddenInput.value = JSON.stringify(checkedMessageIDs);
}

        function deleteMail() {
            var redirect="user";
            var checkboxes = document.getElementsByName("mailCheckbox");
            var checkedMessageIDs = [];

            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    checkedMessageIDs.push(checkboxes[i].getAttribute("data-mail-id"));
                }
            }

    // Redirect to viewMail.jsp with the selected message_id
            if (checkedMessageIDs.length > 0) {
                window.location.href = 'deleteMail.jsp?mailID=' + checkedMessageIDs[0] + '&redirect='+ redirect ; // Assuming only one mail can be opened at a time
            } else {
                alert("Please select a mail to delete.");
            }
    }
        
        function viewMail(mailID) {
        window.location.href = 'viewMail.jsp?mailID=' + mailID;
        }
        
        function toggleButtons() {
        var checkboxes = document.getElementsByName("mailCheckbox");
        var btnOpen = document.querySelector(".btnOpen");
        var btnDel = document.querySelector(".btnDel");

        var checked = false;
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                checked = true;
                break;
            }
        }

        if (checked) {
            btnOpen.style.display = "block";
            btnDel.style.display = "block";
        } else {
            btnOpen.style.display = "none";
            btnDel.style.display = "none";
        }
    }
    
    
    
    var urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has("mailSent") && urlParams.get("mailSent") === "true") {
        // Display an alert box with the message "Mail sent successfully"
        alert("Mail sent successfully!");
    }
    var urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has("mailDel") && urlParams.get("mailDel") === "true") {
        
        alert("Mail deleted successfully!");
    }

    </script>
</head>
<body>
    <%
    String userID = request.getParameter("userID");
    if (userID == null) {
        userID = (String) session.getAttribute("userID");
    }
    %>
    <div id="con1">        
        <a href="UserPage.jsp" class="back-button">&#8592</a>
        <div class="mail">MAIL</div>
    </div>
    <div class="container">
    <div class="sec1">
        <div id="inbox1">INBOX</div>
        <div id="buttonbar1" class="buttonbar1">
            <button class="btnOpen" style="display:none;" onclick="openMail()">OPEN</button>
            <button class="btnDel" style="display:none;" onclick="deleteMail()">DELETE</button>
        
        </div>
       
        <br>
        <div class="showmail">
            <table id="table1">
            <thead>
                <tr>
                    <th>Select</th>
                    <th>Mail ID</th>
                    <th>From</th>
                    <th>Subject</th>
                </tr>
            </thead>
<%            
            Connection conn=null;
            PreparedStatement pstmt=null;
            ResultSet rs=null;
            try{
                        Class.forName("com.mysql.jdbc.Driver");
                        conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT","db_name","db_pass");
                        String query = "SELECT * from MAIL WHERE sender_id=? OR receiver_id=? ORDER BY sent_date DESC";
                        pstmt=conn.prepareStatement(query);
                        pstmt.setString(1, userID);
                        pstmt.setString(2, userID);
                        rs = pstmt.executeQuery();
                        while(rs.next()) {
%>
            <tbody>
                <tr>
                    <td><input type="checkbox" name="mailCheckbox" data-mail-id="<%=rs.getString("message_id")%>" onchange="toggleButtons()"></td>
                    <td><%=rs.getString("message_id")%></td>
                    <td><%=rs.getString("sender_email")%></td>
                    <td><%=rs.getString("subject")%></td>
                </tr>
            </tbody>
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
        </div>
    </div>
    <div class="sec2">
        <div id="con2">Create Mail</div><br>  
        <form id="formMail" method="post" action="SendMail.jsp">
            <input type="hidden" name="sender_type" value="user">
            <input type="hidden" name="sender_id" value="<%=userID%>"><br><br>
            <label for="receiver_email">To : </label> &nbsp;
            <input type="text" id="receiver_email" name="receiver_email" placeholder="Enter recipient's email ID"><br><br>
            <label for="receiver_type">Recipient Type:</label> &nbsp;
            <select id="receiver_type" name="receiver_type">
                <option value="user">User</option>
                <option value="agent">Agent</option>
                <option value="db_pass">Admin</option>
            </select><br><br>
            <label for="subject">Subject:</label> &nbsp;
            <input type="text" id="subject" name="subject" placeholder="Enter subject"><br><br>
            <label for="message">Message:</label><br>
            <textarea id="message" name="message" rows="19" cols="80" placeholder="Enter your message"></textarea><br><br>
            <button id="sendMail" type="submit" action="sendMailAction()">Send Message</button>
        </form>
    </div>
    </div>
</body>
</html>


