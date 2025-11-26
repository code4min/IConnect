<%-- 
    Document   : reassign_tickets
    Created on : 28-Mar-2024, 5:48:29?am
    Author     : Sneha
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import org.json.JSONObject %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>

<%
JSONObject responseData = new JSONObject();
String ticketIdsString = request.getParameter("ticketIds");
String agentId = request.getParameter("agentId");

if (ticketIdsString != null && agentId != null) {
    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HDT", "root", "admin");
        String[] ticketIds = ticketIdsString.split(",");
        PreparedStatement pstmt = conn.prepareStatement("UPDATE TICKET SET Agent = ? WHERE tID = ?");

        for (String ticketId : ticketIds) {
            pstmt.setString(1, agentId);
            pstmt.setString(2, ticketId);
            pstmt.executeUpdate();
        }

        pstmt.close();
        conn.close();

        responseData.put("success", true);
    } catch (SQLException e) {
        responseData.put("success", false);
        responseData.put("error", e.getMessage());
    }
} else {
    responseData.put("success", false);
    responseData.put("error", "Invalid parameters.");
}

out.println(responseData.toJSONString());
%>

