--Create database
Create database projects;


-- Create Tables

DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);


DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);



DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);



SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM Books 
WHERE Genre='Fiction';



-- 2) Find books published after the year 1950:
SELECT * FROM Books 
WHERE Published_year>1950;



-- 3) List all customers from the Canada:
SELECT * FROM Customers 
WHERE country='Canada';




-- 4) Show orders placed in November 2023:

SELECT * FROM Orders 
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';


-- 5) Retrieve the total stock of books available:

SELECT SUM(stock) AS Total_Stock
From Books;
 
-- 6) Find the details of the most expensive book:
SELECT * FROM Books 
order by price desc
limit 4




-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders 
WHERE quantity>1;



-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders 
WHERE total_amount>20;



-- 9) List all genres available in the Books table:
SELECT DISTINCT genre 
FROM Books;


-- 10) Find the book with the lowest stock:
SELECT * FROM Books 
ORDER BY stock 
LIMIT 1;


-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) As Revenue 
FROM Orders;


--12) Retrive the total number of book sold for each genre:
select b.Genre,sum(o.Quantity) as total_sold
from orders o
join books b
on b.book_id=o.order_id
group by b.genre



--13) Find the average price of book in "Fantasy" genre:
 Select avg(price) as price_avg
 from books
 where genre='Fantasy';

--14) List customer who have plased at least 2 order:
select customer_id , count(order_id) as order_count
from orders
group by customer_id 
having (count(order_id))>=2;



--This que using join operator
select o.customer_id ,c.name, count(o.order_id) as order_count
from orders o
join customers c 
on c.customer_id=o.customer_id
group by o.customer_id , c.name
having (count(o.order_id))>=2;


--15) Find the most frequently ordered book:
Select book_id, count(order_id) as order_count 
from orders
group by book_id
order by order_count desc 
limit 5;



--This que using join operator
Select o.book_id,b.title, count(o.order_id) as order_count 
from orders o
join books b
on b.book_id=o.book_id
group by o.book_id, b.title
order by order_count desc 
limit 5;


--16) Show the top 3 most expensive books of 'Fantasy' Genre :
Select title , genre, price
from books
where genre='Fantasy'
order by price desc
limit 3;


-- 17) Retrieve the total quantity of books sold by each author
select b.author,sum(o.quantity) as total_books
from orders o
join books b
on b.book_id=o.book_id
group by b.author



-- 18)List the cities where customers who spent over $30 are located:
Select distinct c.city, total_amount
from customers c
join orders o
on c.customer_id=o.customer_id
where o.total_amount>30;



-- 19) Find the customer who spent the most on orders:
select c.customer_id,c.name,sum(o.total_amount) as total_spent
from customers c
join orders o 
on c.customer_id=o.customer_id
group by c.customer_id,c.name
order by total_spent desc
limit 4;



--20) Calculate the stock remaining after fulfilling all orders:
Select b.book_id,b.title,b.stock , coalesce(sum(o.quantity),0) as order_quantity,
       b.stock-coalesce(sum(o.quantity),0) as Remaining_quantity
from books b
left join orders o
on b.book_id=o.book_id
group by b.book_id
order by b.book_id;

--book_id 187 -22 in stock orders coming 9 and remaining quantity is 13

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;




















