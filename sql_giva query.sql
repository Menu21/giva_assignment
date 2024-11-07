CREATE DATABASE sales_database;

USE sales_data;

/*
Q) Create a sales table with the following fields:

Customer Name
Email
Phone
Date of purchase
SKUs bought (multiple comma separated values)
Total price
Discount
Date of purchase
*/

CREATE TABLE sales (
    id SERIAL PRIMARY KEY,  -- SERIAL auto-increments the ID
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    date_of_purchase DATE,
    skus_bought VARCHAR(255),  -- For comma-separated SKU values
    total_price DECIMAL(10, 2),
    discount DECIMAL(5, 2)
);

/*
Please populate the data with sample data that can be downloaded online.
*/

INSERT INTO sales (customer_name, email, phone, date_of_purchase, skus_bought, total_price, discount)
VALUES 
('John Doe', 'johndoe@example.com', '1234567890', '2023-08-10', 'SKU123,SKU124', 1500, 150),
('Jane Smith', 'janesmith@example.com', '0987654321', '2023-08-15', 'SKU125', 500, 0),
('John Doe', 'johndoe@example.com', '1234567890', '2023-09-01', 'SKU124,SKU126', 2000, 200),
('Alice Brown', 'alicebrown@example.com', '1122334455', '2023-09-05', 'SKU127', 800, 80),
('Michael Green', 'michaelgreen@example.com', '9988776655', '2023-09-20', 'SKU123,SKU128', 2500, 250),
('Jane Smith', 'janesmith@example.com', '0987654321', '2023-09-25', 'SKU129', 1000, 50);
-- 1. Name and list of customers who purchased more than once
SELECT customer_name, COUNT(*) AS purchase_count
FROM sales
GROUP BY customer_name
HAVING COUNT(*) > 1;
-- Highest selling item name
SELECT skus_bought AS highest_selling_item, COUNT(*) AS frequency
FROM sales
GROUP BY skus_bought
ORDER BY frequency DESC
LIMIT 1;
-- Number of times a customer purchases on an average in a month
SELECT 
    customer_name,
    COUNT(*) AS total_purchases,
    COUNT(*) / NULLIF(
        TIMESTAMPDIFF(MONTH, MIN(date_of_purchase), MAX(date_of_purchase)) + 1, 0
    ) AS avg_purchases_per_month
FROM 
    sales
GROUP BY 
    customer_name;
-- List of all customers who have purchased items worth more than Rs. X (here X should be a variable)    
SELECT 
    customer_name, 
    email, 
    phone, 
    SUM(total_price) AS total_spent
FROM 
    sales
GROUP BY 
    customer_name, email, phone
HAVING 
    SUM(total_price) > 1000;
