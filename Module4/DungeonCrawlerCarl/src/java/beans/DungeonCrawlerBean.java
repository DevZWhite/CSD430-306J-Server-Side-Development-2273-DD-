/*
 * File       : DungeonCrawlerBean.java
 * Course     : CSD 430
 * Author     : Zachary White
 * Date       : November 13, 2026
 * Professor  : Darrell Payne
 * Purpose    : JavaBean that holds the Dungeon Crawler Carl data used in the
 *              Module 2 scriptlet assignment. index.jsp reads this data
 *              through the bean's getter methods and displays it in tables.
 */
package beans;

import java.io.Serializable;

/**
 * JavaBean rules followed here:
 *   1. The class is public and implements java.io.Serializable.
 *   2. It has a public no-argument constructor.
 *   3. Every field is private and is reached through public getX/setX methods.
 */
public class DungeonCrawlerBean implements Serializable {

    /** Version id used when the bean is serialized/deserialized. */
    private static final long serialVersionUID = 1L;

    // ---------- Bean fields (all private) ----------

    /** Field 1: This section holds the title. */
    private String pageTitle;

    /** Field 2: retains the author of the series */
    private String author;

    /** Field 3: overall description of the data set. */
    private String overview;

    /** Field 4: books. Columns: Book Number | Title | Story Hook. */
    private String[][] books;

    /** Field 5: one description per column of the books table. */
    private String[] bookFields;

    /** Field 6: characters. Columns: Character | Role | Allegiance | Image file. */
    private String[][] characters;

    /** Field 7: one description per displayed column of the characters table. */
    private String[] characterFields;

    /** Field 8: floors. Columns: Location | Theme | Notes | Image file. */
    private String[][] floors;

    /** Field 9: one description per displayed column of the floors table. */
    private String[] floorFields;

    /**
     * No-argument constructor required by the JavaBean specification.
     * It loads the same data that was hard-coded in the Module 2 scriptlet.
     */
    public DungeonCrawlerBean() {
        pageTitle = "Dungeon Crawler Carl";
        author = "Matt Dinniman";
        overview = "Dungeon Crawler Carl is a science fantasy LitRPG series about a man "
                 + "named Carl and his ex-girlfriend's cat, Princess Donut, who are forced "
                 + "into a multi-level dungeon built by the alien species that has taken "
                 + "over Earth.";

        books = new String[][] {
            {"1", "Dungeon Crawler Carl", "Carl and Princess Donut are pulled into a deadly alien game show dungeon."},
            {"2", "Carl's Doomsday Scenario", "The training stages end and the real game begins."},
            {"3", "The Dungeon Anarchist's Cookbook", "Carl's improvised, chaotic tactics push the show's rules to the limit."},
            {"4", "The Gate of the Feral Gods", "The crawlers face tougher floors and harsher consequences."},
            {"5", "The Butcher's Masquerade", "The gates fall and the hunters are loosed on the crawlers."},
            {"6", "The Eye of the Bedlam Bride", "A fan-favorite entry that raises the stakes again."},
            {"7", "This Inevitable Ruin", "Faction Wars arrive on the ninth floor."},
            {"8", "A Parade of Horribles", "The longest book in the series so far, released in May 2026."}
        };
        bookFields = new String[] {
            "Book Number: the book's position in the series reading order",
            "Title: the name of the novel",
            "Story Hook: a one-line teaser of what the book is about"
        };

        characters = new String[][] {
            {"Carl", "Main protagonist", "Crawlers", "carl.webp"},
            {"Princess Donut", "Carl's companion and fellow crawler", "Crawlers", "donut.webp"},
            {"Mongo", "Loyal companion", "Crawlers", "mongo.webp"},
            {"Mordecai", "Guide and manager", "Ally of the crawlers", "mordecai.jpeg"},
            {"The Borant Corporation", "Organizer of the dungeon game show", "Show runners", "borant.jpg"}
        };
        characterFields = new String[] {
            "Character: the name of the person, creature, or group",
            "Role: what the character does in the story",
            "Allegiance: which side the character stands on"
        };

        floors = new String[][] {
            {"Floor 1", "The first descent", "Where new crawlers begin the dungeon.", "floor1.webp"},
            {"Stairwells", "Safe rooms", "Brief places of rest between floors.", "stairwell.webp"},
            {"Floor 9", "Faction Wars", "The setting for the main events of book seven.", "floor9.png"}
        };
        floorFields = new String[] {
            "Location: the floor or place in the dungeon",
            "Theme: the main idea or event tied to the location",
            "Notes: why the location matters to the story"
        };
    }

    // ---------- Getters and setters ----------

    public String getPageTitle() { return pageTitle; }
    public void setPageTitle(String pageTitle) { this.pageTitle = pageTitle; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getOverview() { return overview; }
    public void setOverview(String overview) { this.overview = overview; }

    public String[][] getBooks() { return books; }
    public void setBooks(String[][] books) { this.books = books; }

    public String[] getBookFields() { return bookFields; }
    public void setBookFields(String[] bookFields) { this.bookFields = bookFields; }

    public String[][] getCharacters() { return characters; }
    public void setCharacters(String[][] characters) { this.characters = characters; }

    public String[] getCharacterFields() { return characterFields; }
    public void setCharacterFields(String[] characterFields) { this.characterFields = characterFields; }

    public String[][] getFloors() { return floors; }
    public void setFloors(String[][] floors) { this.floors = floors; }

    public String[] getFloorFields() { return floorFields; }
    public void setFloorFields(String[] floorFields) { this.floorFields = floorFields; }
}