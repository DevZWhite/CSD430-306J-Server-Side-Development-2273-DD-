<%-- 
    Document   : index
    Created on : Oct 25, 2026, 12:49:31 PM
    Author     : Zachary White
    Professor  : Darrell Payne
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My First JSP</title>
</head>
<body>
    <h1>Hello from JSP!</h1>
    <p>Name: Zachary White</p>

    <%
        // Java scriptlet
        String course = "CSD430";
        Date now = new Date();
        int total = 0;
        for (int i = 1; i <= 5; i++) {
            total += i;
        }
    %>

    <p>Course: <%= course %></p>
    <p>Current date and time: <%= now %></p>
    <p>Sum of 1 through 5: <%= total %></p>
</body>
</html>
