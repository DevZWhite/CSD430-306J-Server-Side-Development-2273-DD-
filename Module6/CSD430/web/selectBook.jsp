<%--
    Name Zachary White
    Professor: Darrell Payne
    Date 11.21.2026
    Class: CSD430 Server-Side Development
    selectBook.jsp - Module 6: CRUD Read using a JavaBean.
    1. The dropdown lists every book_id (the key) found in zachary_library_data.
    2. When the form is submitted, this same page shows the chosen record in a table.
    3. I decided for a cleaner project mock-up to have the select and show be a part of the same JSP file. instead of having multiple for each module.
    This design is in my opinion more scalable as the project continues onward it will take less effort to develop the page.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, csd430.BookBean" %>

<jsp:useBean id="bookBean" class="csd430.BookBean" scope="request" />
<%
    // Get all key values for the dropdown menu (the bean talks to MySQL)
    List<Integer> bookIds = bookBean.getAllIds();

    // Read the key the user picked (null the first time the page loads)
    String selectedParam = request.getParameter("bookId");
    boolean submitted = (selectedParam != null && !selectedParam.isEmpty());
    boolean found = false;

    // Ask the bean to load the matching record into its properties
    if (submitted) {
        try {
            found = bookBean.loadBook(Integer.parseInt(selectedParam));
        } catch (NumberFormatException e) {
            found = false;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CRUD Read - Find a Book</title>
    <style>
        body { font-family: Georgia, serif; background-color: #0f1226; color: #e8e6f0; margin: 0; padding: 24px; }
        .page { max-width: 960px; margin: 0 auto; padding: 24px 32px; }
    </style>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="page">
    <h1>My Favorite Books: Find a Book</h1>

    <p class="description">
        This page reads the <strong>zachary_library_data</strong> table in the CSD430 database
        through a JavaBean. The table holds my favorite books: Carl Sagan, astronomy, and the
        Dungeon Crawler Carl series. Pick a Book ID from the menu to see that book's full record.
    </p>

    <h2>Choose a Book ID</h2>
    <form method="get" action="selectBook.jsp" class="search">
        <label for="bookId">Book ID:</label>
        <select name="bookId" id="bookId" required>
            <option value="">-- Select an ID --</option>
            <% for (Integer id : bookIds) { %>
                <option value="<%= id %>" <%= String.valueOf(id).equals(selectedParam) ? "selected" : "" %>><%= id %></option>
            <% } %>
        </select>
        <button type="submit">Show Book</button>
    </form>

    <% if (!bookBean.getErrorMessage().isEmpty()) { %>
        <p class="error"><%= BookBean.escape(bookBean.getErrorMessage()) %></p>
    <% } %>

    <% if (submitted && found) { %>
        <h2>Book Record</h2>
        <p class="description">
            Each column below is one field of the selected record: the ID (primary key), title, author,
            genre, year first published, and my personal rating out of 5.
        </p>
        <table>
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Genre</th>
                    <th>Year Published</th>
                    <th>My Rating</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= bookBean.getBookId() %></td>
                    <td><%= BookBean.escape(bookBean.getTitle()) %></td>
                    <td><%= BookBean.escape(bookBean.getAuthor()) %></td>
                    <td><%= BookBean.escape(bookBean.getGenre()) %></td>
                    <td><%= bookBean.getPublicationYear() %></td>
                    <td><%= bookBean.getMyRating() %> / 5</td>
                </tr>
            </tbody>
        </table>
    <% } else if (submitted) { %>
        <p class="note">No book was found for that ID.</p>
    <% } %>

    <p><a class="button" href="index.jsp">&larr; Back to Home</a></p>
    <p class="footer">CSD 430 - Modules 5 and 6 - Zachary White</p>
</div>
</body>
</html>
