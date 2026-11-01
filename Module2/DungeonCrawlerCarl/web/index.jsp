<%--
    File       : index.jsp
    Course     : CSD 430
    Author     : Zachary White
    Date       : November 1, 2026
    Professor  : Darrell Payne
    Purpose    : Dynamic HTML page built with JSP scriptlets. All Java code lives
                 inside scriptlets; all HTML tags are placed outside of them.
                 Topic: the Dungeon Crawler Carl book series by Matt Dinniman.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%-- Data section. Each category is a two-dimensional String array
I chose to store the data in two-dimensional String arrays 
because it was the simplest way to organize each category without creating extra classes or methods. 
Each row is one record and each column is one field, so a single loop can display every record in its table.
     (one row per record, one column per field).--%>
<%
    // ---------- Category 1: The Books ----------
    // Fields: Book Number | Title | Story Hook
    String[][] books = {
        {"1", "Dungeon Crawler Carl", "Carl and Princess Donut are pulled into a deadly alien game show dungeon."},
        {"2", "Carl's Doomsday Scenario", "The training stages end and the real game begins."},
        {"3", "The Dungeon Anarchist's Cookbook", "Carl's improvised, chaotic tactics push the show's rules to the limit."},
        {"4", "The Gate of the Feral Gods", "The crawlers face tougher floors and harsher consequences."},
        {"5", "The Butcher's Masquerade", "The gates fall and the hunters are loosed on the crawlers."},
        {"6", "The Eye of the Bedlam Bride", "A fan-favorite entry that raises the stakes again."},
        {"7", "This Inevitable Ruin", "Faction Wars arrive on the ninth floor."},
        {"8", "A Parade of Horribles", "The longest book in the series so far, released in May 2026."}
    };
    String[] bookFields = {
        "Book Number: the book's position in the series reading order",
        "Title: the name of the novel",
        "Story Hook: a one-line teaser of what the book is about"
    };

    // ---------- Category 2: The Characters ----------
    // Fields: Character | Role | Allegiance | Image file (used by the gallery only)
    String[][] characters = {
        {"Carl", "Main protagonist", "Crawlers", "carl.webp"},
        {"Princess Donut", "Carl's companion and fellow crawler", "Crawlers", "donut.webp"},
        {"Mongo", "Loyal companion", "Crawlers", "mongo.webp"},
        {"Mordecai", "Guide and manager", "Ally of the crawlers", "mordecai.jpeg"},
        {"The Borant Corporation", "Organizer of the dungeon game show", "Show runners", "borant.jpg"}
    };
    String[] characterFields = {
        "Character: the name of the person, creature, or group",
        "Role: what the character does in the story",
        "Allegiance: which side the character stands on"
    };

    // ---------- Category 3: Floors and Locations ----------
    // Fields: Location | Theme | Notes | Image file (used by the gallery only)
    String[][] floors = {
        {"Floor 1", "The first descent", "Where new crawlers begin the dungeon.", "floor1.webp"},
        {"Stairwells", "Safe rooms", "Brief places of rest between floors.", "stairwell.webp"},
        {"Floor 9", "Faction Wars", "The setting for the main events of book seven.", "floor9.png"}
    };
    String[] floorFields = {
        "Location: the floor or place in the dungeon",
        "Theme: the main idea or event tied to the location",
        "Notes: why the location matters to the story"
    };
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dungeon Crawler Carl | CSD 430 JSP Project</title>
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
                <h1>Dungeon Crawler Carl</h1>
                <p class="byline">by Matt Dinniman</p>
            </div>
            <%-- PICTURE SLOT: put your banner in web/images/banner.jpg --%>
            <div class="img-frame banner">
                <span class="placeholder">images/banner.jpg</span>
                <img src="images/banner.png" alt="Dungeon Crawler Carl banner" onerror="this.style.display = 'none'">
            </div>
        </header>

        <main>

            <%-- Overview section --%>
            <section class="panel intro">
                <h2>About This Page</h2>
                <p>
                    Dungeon Crawler Carl is a science fantasy LitRPG series about a man named
                    Carl and his ex-girlfriend's cat, Princess Donut, who are forced into a
                    multi-level dungeon built by the alien species that has taken over Earth.
                </p>
                <p class="stats">
                    Records loaded:
                    <span class="badge"><%= books.length %> books</span>
                    <span class="badge"><%= characters.length %> characters</span>
                    <span class="badge"><%= floors.length %> locations</span>
                </p>
            </section>

            <%-- CATEGORY 1: The Book series --%>
            <section class="panel">
                <h2>Category 1: The Books</h2>

                <div class="table-wrap">
                    <table>
                        <caption>Dungeon Crawler Carl books </caption>
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

                <%-- series cover art image // this is a ref to the 7th title, my personal favorite of the series --%>
                <figure class="img-frame cover">
                    <span class="placeholder">images/cover.jpg</span>
                    <img src="images/cover.jpg" alt="Dungeon Crawler Carl cover art" onerror="this.style.display = 'none'">
                </figure>
            </section>

            <%-- CATEGORY 2: CHARACTERS --%>
            <section class="panel">
                <h2>Category 2: The Characters</h2>

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

                <%-- one slot per character, images loaded from 'images' iirc / --%>
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

            <%-- ===== CATEGORY 3: FLOORS AND LOCATIONS ===== --%>
            <section class="panel">
                <h2>Category 3: Floors and Locations</h2>

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

                <%-- one slot per location images loaded from 'images' iirc --%>
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
            <p>CSD 430 | Zachary White | November 1, 2026</p>
            <p class="fine">Fan-made student project. Dungeon Crawler Carl is written by Matt Dinniman.</p>
        </footer>

    </body>
</html>

