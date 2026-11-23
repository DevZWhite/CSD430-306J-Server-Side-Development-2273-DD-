-- zacharypopulateTable.sql
USE CSD430;

INSERT INTO zachary_library_data (title, author, genre, publication_year, my_rating) VALUES
('Pale Blue Dot', 'Carl Sagan', 'Astronomy', 1994, 5.0),
('Cosmos', 'Carl Sagan', 'Astronomy', 1980, 5.0),
('Contact', 'Carl Sagan', 'Science Fiction', 1985, 4.5),
('The Demon-Haunted World', 'Carl Sagan', 'Science', 1995, 4.5),
('A Brief History of Time', 'Stephen Hawking', 'Astronomy', 1988, 4.0),
('Astrophysics for People in a Hurry', 'Neil deGrasse Tyson', 'Astronomy', 2017, 4.0),
('Dungeon Crawler Carl', 'Matt Dinniman', 'LitRPG', 2020, 5.0),
('Carl''s Doomsday Scenario', 'Matt Dinniman', 'LitRPG', 2021, 5.0),
('The Dungeon Anarchist''s Cookbook', 'Matt Dinniman', 'LitRPG', 2021, 5.0),
('The Gate of the Feral Gods', 'Matt Dinniman', 'LitRPG', 2022, 4.5),
('The Butcher''s Masquerade', 'Matt Dinniman', 'LitRPG', 2022, 4.5);

SELECT * FROM zachary_library_data;
