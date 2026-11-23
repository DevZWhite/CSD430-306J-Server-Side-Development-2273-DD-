<%--
    Name Zachary White
    Professor: Darrell Payne
    Date 11.21.2026
    Class: CSD430 Server-Side Development
    Description: This page enacts as a landing page for the CSD430 project.
    Any addition to this page will be in the form of additonal pages linked as deliverables throughout the duration of the project.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String[][] deliverables = {
        {"Modules 5 and 6: CRUD Read",
         "Pick a Book ID from a dropdown and view that record from the zachary_library_data table, read through a JavaBean.",
         "selectBook.jsp"}
    };
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CSD 430 Project - Home</title>
    <style>
        body { font-family: Georgia, serif; background-color: #0f1226; color: #e8e6f0; margin: 0; padding: 24px; }
        .page { max-width: 960px; margin: 0 auto; padding: 24px 32px; }
    </style>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="page">
<h1>CSD430 Project Landing Page</h1>
<p class="description">
    Below you will find a series of modules hosted at this page:
</p>
<ul class="links">
    <li>Module 5: Landing Page and Data Creation</li>
    <li>Module 6: Library Interfacing</li>
</ul>

<h2>Source Code on GitHub</h2>
<p class="description">
    The full source for this project, including the SQL scripts, JavaBean, and JSP pages,
    is available in my GitHub repository for CSD430.
</p>
<ul class="links">
    <li>
        <a href="https://github.com/DevZWhite/CSD430-306J-Server-Side-Development-2273-DD-"
           target="_blank" rel="noopener noreferrer"><strong>CSD430 Repository on GitHub</strong></a>
        <br>CSD430-306J Server-Side Development (2273-DD)
    </li>
</ul>

        <h2>CRUD Deliverables</h2>
        <ul class="links">
            <% for (String[] d : deliverables) { %>
                <li>
                    <% if (d[2].isEmpty()) { %>
                        <strong><%= d[0] %></strong> <span class="note">(link coming soon)</span>
                    <% } else { %>
                        <a href="<%= d[2] %>"><strong><%= d[0] %></strong></a>
                    <% } %>
                    <br><%= d[1] %>
                </li>
            <% } %>
        </ul>

        <p class="footer">CSD 430 - Modules 5 and 6 - Zachary White </p>
    </div>
</body>
</html>
