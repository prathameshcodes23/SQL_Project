-- E-Commerce ER Diagram Implementation.

-- Database Creation
create database ecom;
use ecom;

-- User Table
create table User (User_ID integer primary key, 
User_Name varchar(100) not null, 
address text not null, 
email varchar(30) not null unique, 
phone_number integer not null unique
);

-- Seller Table
create table Seller (seller_id integer primary key,
seller_name varchar(100) not null,
rating integer not null check (rating between 1 and 5),
email_seller varchar(100) not null
);

-- Product Table
create table Product(product_id integer primary key,
product_name varchar(100) not null,
price decimal(10,2) not null,
product_description text,
seller_id integer,
foreign key(seller_id) references Seller(seller_id) on delete cascade
);
ALTER TABLE Product ADD COLUMN quantity INTEGER NOT NULL DEFAULT 0;


-- Review Table
create table Review(review_id integer primary key,
user_id integer not null,
product_id integer not null,
comments text,
rating_review integer not null check (rating_review between 1 and 5),
foreign key(user_id) references User(User_ID) on delete cascade,
foreign key(product_id) references Product(product_id) on delete cascade
);

-- Order Table
create table Orders(order_id integer primary key,
order_amount decimal(10,2) not null,
user_id integer not null,
order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
product_id integer,
foreign key(user_id) references User(User_ID) on delete cascade,
foreign key(product_id) references Product(product_id) on delete cascade
);

-- Cart Table
create table Cart(cart_id integer primary key,
user_id integer,
product_id integer,
foreign key(user_id) references User(User_ID) on delete cascade,
foreign key(product_id) references Product(product_id) on delete cascade
);

-- Track Table
create table Track (
    track_id integer primary key,
    order_id integer not null,
    status ENUM('Processing', 'Shipped', 'Delivered', 'Cancelled') not null,
    foreign key (order_id) references Orders(order_id) on delete cascade
);

-- Payment Table
create table Payment ( payment_id integer primary key,
user_id integer not null,
order_id integer not null,
payment_amount decimal(10,2) not null,
payment_method ENUM('Credit Card', 'Debit Card', 'UPI', 'Net Banking', 'COD') not null,
foreign key(user_id) references User(User_ID) on delete cascade,
foreign key(order_id) references Orders(order_id) on delete cascade
);


-- Insert into User table
INSERT INTO User (User_ID, User_Name, address, email, phone_number) VALUES
(1, 'Shriram Kekan', 'Pune, India', 'shriram@gmail.com', 98765789),
(2, 'Amit Sharma', 'Mumbai, India', 'amit@gmail.com', 98989898),
(3, 'Rishabh Joshi', 'Delhi, India', 'rishabh@gmail.com', 97654321),
(4, 'Rahul Gupta', 'Bangalore, India', 'rahul@gmail.com', 56743210),
(5, 'Pankaj Mehta', 'Hyderabad, India', 'pankaj@gmail.com', 97861230),
(6, 'Vikas Patil', 'Chennai, India', 'vikas@gmail.com', 96783410),
(7, 'Sanjay Kapoor', 'Kolkata, India', 'sanjay@gmail.com', 95473210);

INSERT INTO User (User_ID, User_Name, address, email, phone_number) VALUES
(8, 'Neha Verma', 'Lucknow, India', 'neha@gmail.com', 91234567),
(9, 'Aakash Singh', 'Jaipur, India', 'aakash@gmail.com', 93456789),
(10, 'Meera Iyer', 'Chennai, India', 'meera@gmail.com', 94561230),
(11, 'Rajiv Kumar', 'Patna, India', 'rajiv@gmail.com', 95671234),
(12, 'Karan Malhotra', 'Surat, India', 'karan@gmail.com', 96781234),
(13, 'Sneha Shah', 'Ahmedabad, India', 'sneha@gmail.com', 97892345),
(14, 'Ankit Tiwari', 'Bhopal, India', 'ankit@gmail.com', 98903456),
(15, 'Simran Kaur', 'Amritsar, India', 'simran@gmail.com', 99014567),
(16, 'Varun Chopra', 'Nagpur, India', 'varun@gmail.com', 99125678),
(17, 'Deepika Rao', 'Vishakhapatnam, India', 'deepika@gmail.com', 99236789),
(18, 'Saurabh Pandey', 'Kanpur, India', 'saurabh@gmail.com', 99347890),
(19, 'Nikita Dubey', 'Indore, India', 'nikita@gmail.com', 99458901),
(20, 'Arjun Nair', 'Kochi, India', 'arjun@gmail.com', 99569012);

-- Insert into Seller table
INSERT INTO Seller (seller_id, seller_name, rating, email_seller) VALUES
(1, 'TechStore', 5, 'contact@techstore.com'),
(2, 'FashionHub', 4, 'support@fashionhub.com'),
(3, 'GadgetWorld', 3, 'help@gadgetworld.com');

-- Insert into Product table
INSERT INTO Product (product_id, product_name, price, product_description, seller_id) VALUES
(1, 'Laptop', 55000.00, '15.6-inch, i5, 8GB RAM, 512GB SSD', 1),
(2, 'Smartphone', 25000.00, '128GB storage, 6.5-inch display', 3),
(3, 'T-Shirt', 799.00, 'Cotton, Blue, Large size', 2),
(4, 'Wireless Headphones', 1999.00, 'Bluetooth 5.0, Noise Cancellation', 3),
(5, 'Smartwatch', 4999.00, 'AMOLED Display, Heart Rate Sensor', 3);

INSERT INTO Product (product_id, product_name, price, product_description, seller_id, quantity) VALUES
(6, 'Tablet', 30000.00, '10-inch, 128GB Storage, WiFi', 1, 70),
(7, 'Jeans', 1499.00, 'Slim Fit, Blue Denim', 2, 120),
(8, 'Gaming Mouse', 1299.00, 'RGB Lights, 6 Buttons', 3, 90),
(9, 'Backpack', 999.00, 'Waterproof, 25L', 2, 110),
(10, 'Desk Lamp', 799.00, 'LED, Adjustable Brightness', 1, 60);

UPDATE Product SET quantity = 50 WHERE product_id = 1;
UPDATE Product SET quantity = 100 WHERE product_id = 2;
UPDATE Product SET quantity = 200 WHERE product_id = 3;
UPDATE Product SET quantity = 150 WHERE product_id = 4;
UPDATE Product SET quantity = 80 WHERE product_id = 5;

-- Insert into Review table
INSERT INTO Review (review_id, user_id, product_id, comments, rating_review) VALUES
(1, 1, 1, 'Great laptop for programming!', 5),
(2, 2, 2, 'Decent phone but battery life could be better.', 4),
(3, 3, 3, 'Very comfortable and stylish T-shirt.', 5),
(4, 4, 4, 'Good quality headphones for the price.', 4);

-- Insert into Orders table
INSERT INTO Orders (order_id, order_amount, user_id, order_date, product_id) VALUES
(1, 55000.00, 1, '2025-02-17 10:30:00', 1),
(2, 25000.00, 2, '2025-02-16 14:20:00', 2),
(3, 799.00, 3, '2025-02-15 18:00:00', 3),
(4, 1999.00, 4, '2025-02-14 12:10:00', 4),
(5, 4999.00, 5, '2025-02-13 16:45:00', 5),
(6, 25000.00, 6, '2025-02-12 11:30:00', 2);

INSERT INTO Orders (order_id, order_amount, user_id, order_date, product_id) VALUES
(7, 30000.00, 7, '2025-02-11 15:40:00', 6),
(8, 1499.00, 8, '2025-02-10 13:30:00', 7),
(9, 1299.00, 9, '2025-02-09 17:15:00', 8),
(10, 999.00, 10, '2025-02-08 14:05:00', 9),
(11, 799.00, 11, '2025-02-07 18:20:00', 10),
(12, 25000.00, 12, '2025-02-06 12:00:00', 2),
(13, 55000.00, 13, '2025-02-05 10:10:00', 1),
(14, 4999.00, 14, '2025-02-04 16:30:00', 5),
(15, 1999.00, 15, '2025-02-03 11:45:00', 4);

-- Insert into Cart table
INSERT INTO Cart (cart_id, user_id, product_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 5, 4),
(5, 6, 5);

-- Insert into Track table
INSERT INTO Track (track_id, order_id, status) VALUES
(1, 1, 'Shipped'),
(2, 2, 'Processing'),
(3, 3, 'Delivered'),
(4, 4, 'Cancelled'),
(5, 5, 'Processing');

-- Insert into Payment table
INSERT INTO Payment (payment_id, user_id, order_id, payment_amount, payment_method) VALUES
(1, 1, 1, 55000.00, 'Credit Card'),
(2, 2, 2, 25000.00, 'UPI'),
(3, 3, 3, 799.00, 'Net Banking'),
(4, 4, 4, 1999.00, 'Debit Card'),
(5, 5, 5, 4999.00, 'Credit Card'),
(6, 6, 6, 25000.00, 'UPI');

INSERT INTO Payment (payment_id, user_id, order_id, payment_amount, payment_method) VALUES
(7, 7, 7, 30000.00, 'Credit Card'),
(8, 8, 8, 1499.00, 'UPI'),
(9, 9, 9, 1299.00, 'Net Banking'),
(10, 10, 10, 999.00, 'Debit Card'),
(11, 11, 11, 799.00, 'Credit Card'),
(12, 12, 12, 25000.00, 'UPI'),
(13, 13, 13, 55000.00, 'Net Banking'),
(14, 14, 14, 4999.00, 'Debit Card'),
(15, 15, 15, 1999.00, 'UPI');


-- Select commands to all tables
select * from User;
select * from Seller;
select * from Product;
select * from Orders;
select * from Review;
select * from Track;
select * from Cart;
select * from Payment;

-- Queries on the Database

-- 1. Retrieve all orders with user details
select Orders.order_id, Orders.order_amount, Orders.order_date, User.User_Name, User.email from Orders inner join User on Orders.user_id = User.User_ID;

-- 2. Get product details along with seller details
select Product.product_id, Product.product_name, Product.price, Seller.seller_id, Seller.seller_name, Seller.email_seller from Product inner join Seller on Product.seller_id = Seller.seller_id;

-- 3. List users and the products they have ordered
select User.User_ID, User.user_name, Product.product_name, Orders.order_date from Orders inner join User on Orders.user_id = User.User_ID inner join Product on Orders.product_id = Product.product_id;

-- 4. Count total orders per user
select User.user_name, count(order_id) as total_order from User inner join Orders on User.User_ID=Orders.user_id group by User.user_name;

-- 5. Find users who have not made any orders
select User.user_id, User.user_name from User left join Orders on User.User_ID=Orders.user_id where Orders.order_id IS NULL;

-- 6. List users whose payments done via UPI
select User.User_ID, User.user_name from User inner join Payment on User.User_ID=Payment.user_id where Payment.payment_method='UPI';

-- 7. Retrieve all orders and their tracking status
select Orders.order_id, Orders.order_amount, Orders.order_date, Track.status from Orders left join Track on Orders.order_id=Track.order_id;

-- 8. Retrieve all users along with the number of orders they placed
select User.user_name, count(Orders.order_id) as total_orders from User inner join Orders on User.user_ID=Orders.user_id group by User.user_name;

-- 9. Retrieve all orders where the total amount is greater than RS.10,000
select order_id, user_id, product_id from Orders where order_amount>10000;

-- 10. Retrieve products that have been ordered at least twice
select product_name, count(Orders.order_id) as ordered from Product inner join Orders on Product.product_id=Orders.order_id group by product_name having ordered>1;

-- 11. Find the seller with the highest-priced product
select seller.seller_name from Product inner join seller on Product.seller_id=seller.seller_id order by price desc limit 1;

-- 12. Find the seller with the highest-rated products
select seller.seller_id, seller.seller_name, avg(Review.rating_review) as avg_rating from Seller inner join Product on Seller.seller_id = Product.seller_id inner join Review on Product.product_id = Review.product_id group by Seller.seller_id, Seller.seller_name order by avg_rating desc limit 1;

-- 13. Retrieve all orders along with user and product details
select User.user_ID, User.user_name, Orders.order_id, Product.product_name, Orders.order_amount from User inner join Orders on User.user_ID=Orders.user_id inner join Product on Orders.product_id=Product.product_id;

-- 14. Find the number of products available per seller
select seller.seller_name, count(Product.product_id) as total_products from Product right join seller on Product.seller_id=seller.seller_id group by seller_name;

-- 15. Retrieve users who have never placed an order
select User.user_id, User.user_name from User where not exists ( select * from Orders where Orders.user_id = User.user_id );

-- 16. Find all users who have written reviews
select distinct User.user_ID, User.user_name from User inner join Review on User.user_ID=Review.user_id;

-- 17. Retrieve the top 3 most expensive orders
select order_id, order_amount, order_date, user_id from Orders order by order_amount desc limit 3;

-- 18. Find the average price of products per seller
select seller.seller_name, avg(Product.price) as avg_price from Product inner join seller on Product.seller_id=seller.seller_id group by seller_name;

-- 19. Retrieve all orders with their payment details
select Orders.order_id, User.user_name, Payment.payment_id, Payment.payment_amount, Payment.payment_method from Orders inner join Payment on Orders.order_id=Payment.order_id inner join User on Payment.user_id=User.user_ID;

-- 20. Find users who have spent more than RS.30,000 in total
select User.user_ID, User.user_name, sum(Orders.order_amount) as total_amount from User inner join Orders on User.user_id=Orders.user_id group by user_name having total_amount>30000;

-- 21. Find products that have not received any reviews
select Product.product_id, Product.product_name from Product left join Review on Product.product_id = Review.product_id where Review.review_id is null;

-- 22. Find the total revenue generated by each seller
select seller_name, sum(order_amount) as total_revenue from seller inner join product on seller.seller_id=product.seller_id inner join Orders on Product.product_id=Orders.product_id group by seller_name;

-- 23. Find the most reviewed product
select Product.product_id, Product.product_name, count(review_id) as total_reviews from Product inner join Review on Product.product_id=Review.product_id group by Product.product_id, Product.product_name order by total_reviews desc limit 1; 

-- 24. List all products with their stock quantity
select product_id, product_name, quantity from Product;

-- 25. Find sellers who have not listed any products
select Seller.seller_id, Seller.seller_name from seller left join Product on seller.seller_id=Product.seller_id where product.product_id is null;

-- 26. Retrieve users and their most recent order
select User.user_ID, User.user_name, Orders.order_id, Orders.order_date from User inner join Orders on User.user_ID=Orders.user_id order by Orders.order_date desc;

-- 27. Retrieve all cancelled orders
select Orders.order_id, Orders.order_amount, Track.status from Orders inner join Track on Orders.order_id = Track.order_id where Track.status = 'Cancelled';

-- 28. Retrieve customers who have both ordered and reviewed a product
select User.user_ID, User.user_name from User inner join Orders on User.user_id=Orders.user_id inner join Review on User.user_ID=Review.user_id;

-- 29. Retrieve all payments made using Credit or Debit Card
select payment_id, payment_amount, payment_method from payment where payment_method='Credit Card' or payment_method='Debit Card';

-- 30. Retrieve sellers who have sold more than 3 different products
select seller.seller_id, seller.seller_name, count(product.product_name) as tot_count from seller inner join product on seller.seller_id=product.seller_id group by seller.seller_id, seller.seller_name having tot_count>3;

-- 31. Retrieve the highest and lowest order amounts in the database
select max(order_amount) as highest_amt, min(order_amount) as lowest_amt from orders;

-- 32. Retrieve the top 3 customers based on total spending
select User.user_ID, User.user_name, sum(Orders.order_amount) as total_spent from User inner join Orders on User.user_ID=Orders.user_id group by User.user_ID, User.user_name order by total_spent desc limit 3;

-- 33. Retrieve the month-wise total revenue
select month(order_date), sum(order_amount) as month_revenue from Orders group by month(order_date) order by month(order_date);
