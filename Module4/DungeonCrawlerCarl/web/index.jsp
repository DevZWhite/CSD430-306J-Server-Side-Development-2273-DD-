<%--
    File       : index.jsp
    Course     : CSD 430
    Author     : Zachary White
    Date       : November 15, 2026
    Professor  : Darrell Payne
    Purpose    : Displays Dungeon Crawler Carl web page data held in a JavaBean
                 (beans.DungeonCrawlerBean).
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%-- Create the bean. serializable and gen'd inside of the constructor. --%>
<jsp:useBean id="dungeon" class="beans.DungeonCrawlerBean" scope="page" />

<%-- Pull the data out of the bean into local variables for the display loops. --%>
<%
    String pageTitle = dungeon.getPageTitle();
    String author = dungeon.getAuthor();
    String overview = dungeon.getOverview();

    String[][] books = dungeon.getBooks();
    String[] bookFields = dungeon.getBookFields();

    String[][] characters = dungeon.getCharacters();
    String[] characterFields = dungeon.getCharacterFields();

    String[][] floors = dungeon.getFloors();
    String[] floorFields = dungeon.getFloorFields();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><%= pageTitle %> | CSD 430 JavaBean Project</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@500;700&family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <%-- External stylesheet that controls all of the page styling --%>
        <link rel="stylesheet" type="text/css" href="css/styles.css">
    </head>
    <body>

        <%-- TITLE SECTION --%>
        <header class="hero">
            <div class="hero-text">
                <p class="eyebrow">A Book Worth the Descent</p>
                <h1><%= pageTitle %></h1>
                <p class="byline">by <%= author %></p>
            </div>
            <div class="img-frame banner">
                <span class="placeholder">images/banner.png</span>
                <img src="images/banner.png" alt="<%= pageTitle %> banner" onerror="this.style.display = 'none'">
            </div>
        </header>

        <main>

            <%-- OVERALL DATA DESCRIPTION --%>
            <section class="panel intro">
                <h2>About This Page</h2>
                <p><%= overview %></p>
                <p class="desc">
                    The data below is stored in a Serializable JavaBean and read
                    through its getter methods. It is organized into three
                    categories: books, characters, and floors/locations. In each
                    table, one row is one record and each column is one field.
                </p>
                <p class="stats">
                    Records loaded:
                    <span class="badge"><%= books.length %> books</span>
                    <span class="badge"><%= characters.length %> characters</span>
                    <span class="badge"><%= floors.length %> locations</span>
                </p>
            </section>

            <%-- CATEGORY 1: THE BOOKS --%>
            <section class="panel">
                <h2>Category 1: The Books</h2>
                <p class="desc">Each record is one novel in the series, listed in reading order.</p>

                <%-- Field descriptions --%>
                <ul class="field-list">
                    <% for (int i = 0; i < bookFields.length; i++) { %>
                    <li><%= bookFields[i] %></li>
                    <% } %>
                </ul>

                <div class="table-wrap">
                    <table>
                        <caption>Dungeon Crawler Carl books (<%= books.length %> records)</caption>
                        <thead>
                            <tr>
                                <th>Book Number</th>
                                <th>Title</th>
                                <th>Story Hook</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int i = 0; i < books.length; i++) { %>
                            <tr>
                                <td class="num"><%= books[i][0] %></td>
                                <td class="title"><%= books[i][1] %></td>
                                <td><%= books[i][2] %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <%-- Series cover art (a nod to book 7, my favorite of the series) --%>
                <figure class="img-frame cover">
                    <span class="placeholder">images/cover.jpg</span>
                    <img src="images/cover.jpg" alt="Dungeon Crawler Carl cover art" onerror="this.style.display = 'none'">
                </figure>
            </section>

            <%-- CATEGORY 2: THE CHARACTERS --%>
            <section class="panel">
                <h2>Category 2: The Characters</h2>
                <p class="desc">Each record is one character or group that shapes the story.</p>

                <ul class="field-list">
                    <% for (int i = 0; i < characterFields.length; i++) { %>
                    <li><%= characterFields[i] %></li>
                    <% } %>
                </ul>

                <div class="table-wrap">
                    <table>
                        <caption>Main characters (<%= characters.length %> records)</caption>
                        <thead>
                            <tr>
                                <th>Character</th>
                                <th>Role</th>
                                <th>Allegiance</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int i = 0; i < characters.length; i++) { %>
                            <tr>
                                <td class="title"><%= characters[i][0] %></td>
                                <td><%= characters[i][1] %></td>
                                <td><%= characters[i][2] %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <%-- One picture per character (image file name is the 4th column) --%>
                <div class="gallery">
                    <% for (int i = 0; i < characters.length; i++) { %>
                    <figure class="img-frame card">
                        <span class="placeholder">images/<%= characters[i][3] %></span>
                        <img src="images/<%= characters[i][3] %>" alt="<%= characters[i][0] %>" onerror="this.style.display = 'none'">
                        <figcaption><%= characters[i][0] %></figcaption>
                    </figure>
                    <% } %>
                </div>
            </section>

            <%-- CATEGORY 3: FLOORS AND LOCATIONS --%>
            <section class="panel">
                <h2>Category 3: Floors and Locations</h2>
                <p class="desc">Each record is one place in the dungeon that matters to the story.</p>

                <ul class="field-list">
                    <% for (int i = 0; i < floorFields.length; i++) { %>
                    <li><%= floorFields[i] %></li>
                    <% } %>
                </ul>

                <div class="table-wrap">
                    <table>
                        <caption>Dungeon floors and locations (<%= floors.length %> records)</caption>
                        <thead>
                            <tr>
                                <th>Location</th>
                                <th>Theme</th>
                                <th>Notes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int i = 0; i < floors.length; i++) { %>
                            <tr>
                                <td class="title"><%= floors[i][0] %></td>
                                <td><%= floors[i][1] %></td>
                                <td><%= floors[i][2] %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <%-- One picture per location (image file name is the 4th column) --%>
                <div class="gallery">
                    <% for (int i = 0; i < floors.length; i++) { %>
                    <figure class="img-frame card wide">
                        <span class="placeholder">images/<%= floors[i][3] %></span>
                        <img src="images/<%= floors[i][3] %>" alt="<%= floors[i][0] %>" onerror="this.style.display = 'none'">
                        <figcaption><%= floors[i][0] %>: <%= floors[i][1] %></figcaption>
                    </figure>
                    <% } %>
                </div>
            </section>

        </main>

        <footer>
            <p>CSD 430 | Zachary White | November 15, 2026</p>
            <p class="fine">Fan-made student project. Dungeon Crawler Carl is written by <%= author %>.</p>
        </footer>

    </body>
</html>
