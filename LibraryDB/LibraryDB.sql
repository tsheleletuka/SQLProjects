-- Create the database
CREATE DATABASE LibraryDB;

-- Use the database
USE LibraryDB;

-- Create the tables
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(150),
    author_id INT,
    genre VARCHAR(50),
    publish_year INT,
    available_copies INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    name VARCHAR(100),
    join_date DATE,
    email VARCHAR(100)
);

CREATE TABLE Borrowings (
    borrow_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

INSERT INTO Authors (author_id, name, country) VALUES
(1, 'J.K. Rowling', 'United Kingdom'),
(2, 'George Orwell', 'United Kingdom'),
(3, 'Haruki Murakami', 'Japan'),
(4, 'Chinua Achebe', 'Nigeria'),
(5, 'Jane Austen', 'United Kingdom'),
(6, 'F. Scott Fitzgerald', 'United States'),
(7, 'Leo Tolstoy', 'Russia'),
(8, 'Gabriel Garcia Marquez', 'Colombia'),
(9, 'Mark Twain', 'United States'),
(10, 'Isabel Allende', 'Chile');

INSERT INTO Books (book_id, title, author_id, genre, publish_year, available_copies) VALUES
(1, 'Harry Potter and the Sorcerer''s Stone', 1, 'Fantasy', 1997, 5),
(2, '1984', 2, 'Dystopian', 1949, 3),
(3, 'Norwegian Wood', 3, 'Romance', 1987, 4),
(4, 'Things Fall Apart', 4, 'Historical Fiction', 1958, 2),
(5, 'Pride and Prejudice', 5, 'Classic', 1813, 6),
(6, 'The Great Gatsby', 6, 'Classic', 1925, 5),
(7, 'War and Peace', 7, 'Historical Fiction', 1869, 2),
(8, 'One Hundred Years of Solitude', 8, 'Magical Realism', 1967, 4),
(9, 'Adventures of Huckleberry Finn', 9, 'Adventure', 1884, 3),
(10, 'The House of the Spirits', 10, 'Magical Realism', 1982, 4);


INSERT INTO Members (member_id, name, join_date, email) VALUES
(1, 'Alice Johnson', '2023-01-15', 'alice.johnson@example.com'),
(2, 'Bob Smith', '2022-12-01', 'bob.smith@example.com'),
(3, 'Charlie Brown', '2023-02-20', 'charlie.brown@example.com'),
(4, 'Diana Prince', '2023-03-05', 'diana.prince@example.com'),
(5, 'Ethan Hunt', '2022-11-10', 'ethan.hunt@example.com'),
(6, 'Fiona Gallagher', '2023-04-12', 'fiona.gallagher@example.com'),
(7, 'George Costanza', '2023-05-22', 'george.costanza@example.com'),
(8, 'Hannah Montana', '2023-06-01', 'hannah.montana@example.com'),
(9, 'Ian Malcolm', '2022-10-25', 'ian.malcolm@example.com'),
(10, 'Jenny Matrix', '2023-07-14', 'jenny.matrix@example.com');

INSERT INTO Borrowings (borrow_id, book_id, member_id, borrow_date, return_date) VALUES
(1, 1, 1, '2023-04-01', '2023-04-15'),
(2, 2, 2, '2023-04-05', NULL),
(3, 3, 3, '2023-04-10', '2023-04-20'),
(4, 4, 4, '2023-04-15', NULL),
(5, 5, 5, '2023-04-20', '2023-05-01'),
(6, 6, 6, '2023-05-01', NULL),
(7, 7, 7, '2023-05-05', '2023-05-18'),
(8, 8, 8, '2023-05-10', NULL),
(9, 9, 9, '2023-05-15', '2023-05-30'),
(10, 10, 10, '2023-05-20', NULL);

-- Add a second book for 'J.K. Rowling'
INSERT INTO Books (book_id, title, author_id, genre, publish_year, available_copies) 
VALUES (11, 'Harry Potter and the Chamber of Secrets', 1, 'Fantasy', 1998, 5);

-- Add a second book for 'George Orwell'
INSERT INTO Books (book_id, title, author_id, genre, publish_year, available_copies) 
VALUES (12, 'Animal Farm', 2, 'Political Satire', 1945, 3);



-- List all available books (more than 0 copies left)
SELECT title, available_copies
FROM Books
WHERE available_copies > 0
ORDER BY title;

-- List all overdue borrowings (not yet returned and borrowed more than 30 days ago)
SELECT 
	b.borrow_id,								-- Selecting the borrowing transaction ID
	m.name AS member_name,						-- Selecting the member's name who borrowed the book
	bo.title AS book_title,						-- Selecting the title of the borrowed book
	b.borrow_date								-- Selecting the date the book was borrowed
FROM Borrowings b
JOIN Members m ON b.member_id = m.member_id		-- Joining with the Members table to get the member's information
JOIN Books bo ON b.book_id = bo.book_id			-- Joining with the Books table to get the book's information
-- Filtering the results to include only overdue borrowings that haven't been returned
WHERE b.return_date IS NULL						-- Only include borrowings that have not been returned yet
AND b.borrow_date < DATEADD(DAY, -30, GETDATE());	-- Only include borrowings older than 30 days


--Find the top 3 most borrowed books
SELECT TOP 3
	bo.title,
	COUNT(*) AS times_borrowed
FROM Borrowings b
JOIN Books bo ON b.book_id = bo.book_id
GROUP BY bo.title
ORDER BY times_borrowed DESC;

-- Find the member who borrowed the most books
SELECT TOP 1
	m.name,
	COUNT(*) AS books_borrowed
FROM Borrowings b
JOIN Members m ON b.member_id = m.member_id
GROUP BY m.name
ORDER BY books_borrowed DESC;

-- See all books with their authors
SELECT 
	bo.title,
	a.name AS author_name
FROM Books bo
JOIN Authors a ON bo.author_id = a.author_id
ORDER BY bo.title;


--List authros who have more than 1 book in the library
SELECT
	a.name,
	COUNT(*) AS number_of_books
FROM Books bo
JOIN Authors a ON bo.author_id = a.author_id
GROUP BY a.name
HAVING COUNT(*) > 1;