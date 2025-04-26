# Library Management System

This project is a simple Library Management System using SQL Server. It manages books, authors, members, and borrowing transactions. It includes functionalities such as:

- Managing books and authors
- Tracking borrowings and returns
- Listing available books
- Overdue borrowings
- Counting the most borrowed books and active members

## Database Structure

The database contains the following tables:

- **Authors**: Stores information about authors.
- **Books**: Stores book details, linked to authors.
- **Members**: Stores information about library members.
- **Borrowings**: Stores borrowing transactions (book, member, borrow date, and return date).

## Sample Data

The database includes sample data for authors, books, members, and borrowings to demonstrate the functionality.

## Queries

This project demonstrates several useful SQL queries, such as:

- List of all available books
- Overdue borrowings
- Most borrowed books
- Member who borrowed the most books

## Setup Instructions

1. Clone this repository to your local machine.
2. Run the SQL script `LibraryDB.sql` to set up the database and tables.
3. Execute queries in your preferred SQL client (e.g., SQL Server Management Studio) to interact with the database.

## Technologies Used

- SQL Server (T-SQL)
- SQL Queries
