CREATE TABLE Books(
Book_ID SERIAL PRIMARY KEY,
Tittle VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(120),
Published_Year INT,
Price NUMERIC(10,2),
Stock INT
);

CREATE TABLE Customers(
Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR(100),
Emial VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(150)
);

CREATE TABLE Orders(
Order_id SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_DATE DATE,
Quantity INT,
Total_Amount NUMERIC(10,2)
);
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- Import data into Books Table from import option
-- Import data into Customers Table from import option
 -- Import data into Orders Table from import option

 -- Retrives all Books in the 'Fiction'
 SELECT * FROM Books
 WHERE Genre='Fiction';
 -- Find books published after the year 1950
 SELECT * FROM Books
 WHERE published_year>1950;
 -- List all the customer from the canada
 SELECT * FROM Customers
 WHERE country='Canada';
-- Retrives all the record only november months
 SELECT * FROM Orders
 WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';
-- Retrives the total stock of books avialable
SELECT SUM(stock) AS Total_Stock
 FROM Books;
 -- Find the details of the most expensive books
 SELECT * FROM Books
 ORDER BY price DESC
 LIMIT 1;
 -- Show who all ordered more then 1 quantity of the books
 SELECT * FROM Orders
 WHERE quantity>1;
 -- Retrives all orders where the total amont exceeds $20
 SELECT * FROM Orders
 WHERE total_amount>20;
 -- lIST ALL the Gendra available in the books table
SELECT DISTINCT Genre FROM Books;
-- find the books with the lowest stock
SELECT * FROM Books
ORDER BY stock
LIMIT 1;
-- Calculate the total revenue from orders table
SELECT SUM(total_amount) AS Revenues FROM Orders;

-- Advance Question And Quaries
-- Retrive the total number of books sold for each gendra
SELECT Genre ,SUM(Quantity) AS total_sold
FROM Orders AS o
JOIN Books b ON o.book_id=b.book_id
GROUP BY Genre;
-- find the average price of books in the 'Fantasy' genre
SELECT AVG(price) AS average_price FROM Books
WHERE Genre='Fantasy';
-- List customer who have placed at list two orders
SELECT Customer_ID,COUNT(Order_ID) AS ORDER_COUNT
FROM Orders
GROUP BY Customer_ID
HAVING COUNT(Order_ID)>=2;
-- Find the most frequantly order book
SELECT book_id,COUNT(order_id) AS count_book FROM Orders
GROUP BY book_id
ORDER BY count_book DESC
limit 1;
-- with book name quary
SELECT o.Book_id, b.title,COUNT(o.order_id) AS count_book
FROM Orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id,b.title
ORDER BY count_book DESC
LIMIT 1;
-- Show the top three most expensive book 'Fantasy' Genre
SELECT * FROM Books
WHERE genre='Fantasy'
ORDER BY price DESC
LIMIT 3;
-- Retrives the total quantity of books sold by each author
SELECT b.author,SUM(o.quantity) AS total_sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.author;
-- LIST the cities where customer who spent over $30 are located
SELECT c.city,total_amount
FROM orders o
JOIN Customers c ON o.customer_id=c.customer_id
WHERE o.total_amount>30;
-- Find the customer who spent the most on order
SELECT c.customer_id,c.name, SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id,c.name
ORDER BY total_spent DESC
LIMIT 1;
-- Calculate the stock remaining after fullfiling all orders
SELECT b.book_id,b.title,b.stock,COALESCE(SUM(o.quantity),0) AS Order_quantity,
b.stock - COALESCE(SUM(o.quantity),0) AS remaining_stock
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY book_id;




