<%-- 
    Document   : FeedbackForm
    Created on : 31-Mar-2024, 11:38:05 pm
    Author     : Sneha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
             body{
                background-color: #FF4D62;
                display: flex;
                justify-content: center; /* Center content horizontally */
                align-items: center; /* Center content vertically */
                height: 100vh; /* Full viewport height */
                margin: 0; /* Remove default margin */
            }
            .formContainer {
                max-width: 600px;
                width: 100%; /* Set width to 100% */
                padding: 20px;
                box-sizing: border-box; /* Include padding in width calculation */
            }
            .feedbackForm {
                    background-color: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
                padding: 20px;
                }

            .inputField,
            .textareaField {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 5px;
                border: 1px solid #ccc;
                box-sizing: border-box;
            }

            .textareaField {
                height: 200px;
                resize: none;
            }

            .buttonContainer {
                display: flex;
                justify-content: center;
            }

            .submitButton {
                background-color: black;
                color: white;
                padding: 15px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

            .submitButton:hover {
                background-color: #4CAF50;
            }
            .labelField {
                font-weight: bold;
            }
            .formTitle{
                text-align: center;
            }
        </style>
    </head>
    <body>
        <br><br>
        <div class="formContainer">
         <div class="feedbackForm">
                    <h2 class="formTitle">Feedback Form</h2>
                    <form action="SaveFeedback.jsp" method="post">
                        <label for="ticketID">Ticket ID:</label>
                        <input type="text" id="ticketID" name="ticketID" readonly value="<%= request.getParameter("ticketID") %>" class="inputField"><br><br>
                        <label for="feedback">Feedback:</label>
                        <textarea id="feedback" name="feedback" required class="textareaField"></textarea><br><br>
                        <div class="buttonContainer">
                        <input type="submit" value="Submit Feedback" class="submitButton">
                        </div>
                    </form>
                </div>
        </div>
    </body>
</html>
