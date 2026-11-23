
/**
 * BookBean - JavaBean for the zachary_library_data table in the CSD430 database.
 *
 * Properties (one book record): bookId, title, author, genre, publicationYear, myRating.
 * Database methods: getAllIds(), loadBook(id), createTable(), populateTable(), dropTable().
 *
 * The bean connects as the MySQL user student1 / pass. Those permissions are granted
 * in MySQL (see zacharycreateTable.sql), not through this bean.
 *
 * @author Zachary White
 * @Professor Darrell Payne
 * Date 11.19.2026
 * Class: CSD430
 */

package csd430;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BookBean implements Serializable {

    private static final long serialVersionUID = 1L;

    // ---- Connection settings ----
    private static final String URL =
        "jdbc:mysql://localhost:3306/CSD430?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "student1";
    private static final String PASSWORD = "pass";
    private static final String TABLE = "zachary_library_data";

    // ---- Bean properties: one book record ----
    private int bookId;
    private String title;
    private String author;
    private String genre;
    private int publicationYear;
    private double myRating;

    /** Holds the last error message so the JSP can show it. Empty when all is well. */
    private String errorMessage = "";

    /** Required public no-argument constructor for a JavaBean. */
    public BookBean() { }

    /** Opens a connection to the CSD430 database. */
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    /** Returns every book_id in the table, used to fill the dropdown menu. */
    public List<Integer> getAllIds() {
        List<Integer> ids = new ArrayList<Integer>();
        String sql = "SELECT book_id FROM " + TABLE + " ORDER BY book_id";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ids.add(rs.getInt("book_id"));
            }
        } catch (Exception e) {
            errorMessage = "Could not read book IDs: " + e.getMessage();
        }
        return ids;
    }

    /**
     * Loads the record with the given key into this bean's properties.
     * @return true if a record was found, false otherwise
     */
    public boolean loadBook(int id) {
        String sql = "SELECT book_id, title, author, genre, publication_year, my_rating "
                   + "FROM " + TABLE + " WHERE book_id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    bookId = rs.getInt("book_id");
                    title = rs.getString("title");
                    author = rs.getString("author");
                    genre = rs.getString("genre");
                    publicationYear = rs.getInt("publication_year");
                    myRating = rs.getDouble("my_rating");
                    return true;
                }
            }
        } catch (Exception e) {
            errorMessage = "Could not load book: " + e.getMessage();
        }
        return false;
    }

    /** Creates the table if it does not already exist. */
    public void createTable() {
        String sql = "CREATE TABLE IF NOT EXISTS " + TABLE + " ("
                   + "book_id INT AUTO_INCREMENT PRIMARY KEY, "
                   + "title VARCHAR(120) NOT NULL, "
                   + "author VARCHAR(80) NOT NULL, "
                   + "genre VARCHAR(40) NOT NULL, "
                   + "publication_year INT NOT NULL, "
                   + "my_rating DECIMAL(2,1) NOT NULL)";
        runUpdate(sql);
    }

    /** Fills the table with the 11 favorite books (clears old rows first so it can be re-run). */
    public void populateTable() {
        runUpdate("DELETE FROM " + TABLE);
        runUpdate("ALTER TABLE " + TABLE + " AUTO_INCREMENT = 1");
        String sql = "INSERT INTO " + TABLE
            + " (title, author, genre, publication_year, my_rating) VALUES "
            + "('Pale Blue Dot', 'Carl Sagan', 'Astronomy', 1994, 5.0),"
            + "('Cosmos', 'Carl Sagan', 'Astronomy', 1980, 5.0),"
            + "('Contact', 'Carl Sagan', 'Science Fiction', 1985, 4.5),"
            + "('The Demon-Haunted World', 'Carl Sagan', 'Science', 1995, 4.5),"
            + "('A Brief History of Time', 'Stephen Hawking', 'Astronomy', 1988, 4.0),"
            + "('Astrophysics for People in a Hurry', 'Neil deGrasse Tyson', 'Astronomy', 2017, 4.0),"
            + "('Dungeon Crawler Carl', 'Matt Dinniman', 'LitRPG', 2020, 5.0),"
            + "('Carl''s Doomsday Scenario', 'Matt Dinniman', 'LitRPG', 2021, 5.0),"
            + "('The Dungeon Anarchist''s Cookbook', 'Matt Dinniman', 'LitRPG', 2021, 5.0),"
            + "('The Gate of the Feral Gods', 'Matt Dinniman', 'LitRPG', 2022, 4.5),"
            + "('The Butcher''s Masquerade', 'Matt Dinniman', 'LitRPG', 2022, 4.5)";
        runUpdate(sql);
    }

    /** Deletes the table. */
    public void dropTable() {
        runUpdate("DROP TABLE IF EXISTS " + TABLE);
    }

    /** Runs one non-SELECT statement and records any error. */
    private void runUpdate(String sql) {
        try (Connection con = getConnection(); Statement st = con.createStatement()) {
            st.executeUpdate(sql);
        } catch (Exception e) {
            errorMessage = "Database update failed: " + e.getMessage();
        }
    }

    /** Escapes HTML special characters so database text displays safely on the page. */
    public static String escape(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;").replace("<", "&lt;")
                .replace(">", "&gt;").replace("\"", "&quot;");
    }

    // ---- Getters and setters ----
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }
    public int getPublicationYear() { return publicationYear; }
    public void setPublicationYear(int publicationYear) { this.publicationYear = publicationYear; }
    public double getMyRating() { return myRating; }
    public void setMyRating(double myRating) { this.myRating = myRating; }
    public String getErrorMessage() { return errorMessage; }
}
