USE task6;

CREATE TABLE client_master (
    client_no VARCHAR(5) PRIMARY KEY,
    cname VARCHAR(50),
    state VARCHAR(20)
);

CREATE TABLE product_master (
    product_no VARCHAR(5) PRIMARY KEY,
    description VARCHAR(100),
    product_rate DECIMAL(10,2)
);

CREATE TABLE sales_order (
    order_no VARCHAR(5) PRIMARY KEY,
    client_no VARCHAR(5),
    order_date DATE,
    delivery_date DATE,
    FOREIGN KEY (client_no) REFERENCES client_master(client_no)
);

CREATE TABLE sales_order_details (
    order_no VARCHAR(5),
    product_no VARCHAR(5),
    qty_ordered INT,
    FOREIGN KEY (order_no) REFERENCES sales_order(order_no),
    FOREIGN KEY (product_no) REFERENCES product_master(product_no)
);


-- Insert

INSERT INTO client_master VALUES
('C1', 'Arik', 'WB'),
('C2', 'Bobai', 'MH'),
('C3', 'Arindam', 'TN');

INSERT INTO product_master VALUES
('P1', 'Pen', 10.00),
('P2', 'Notebook', 25.50),
('P3', 'Marker', 15.75);

INSERT INTO sales_order VALUES
('O1', 'C1', '2023-01-01', '2023-01-05'),
('O2', 'C1', '2023-01-10', '2023-01-15'),
('O3', 'C2', '2023-02-01', '2023-02-05');

INSERT INTO sales_order_details VALUES
('O1', 'P1', 2),
('O1', 'P2', 1),
('O2', 'P3', 3),
('O3', 'P1', 1),
('O3', 'P2', 2);


-- Query

-- 1. Scalar Subquery: Find client who placed the latest order
SELECT cname
FROM client_master
WHERE client_no = (
    SELECT client_no
    FROM sales_order
    ORDER BY order_date DESC
    LIMIT 1
);


-- 2. Correlated Subquery: Products that appear in more than 1 order
SELECT description
FROM product_master p
WHERE (
    SELECT COUNT(DISTINCT order_no)
    FROM sales_order_details d
    WHERE d.product_no = p.product_no
) > 1;


-- 3. Subquery with IN: Products that were ordered
SELECT *
FROM product_master
WHERE product_no IN (
    SELECT DISTINCT product_no
    FROM sales_order_details
);


-- 4. Subquery with EXISTS: Clients who placed orders
SELECT *
FROM client_master c
WHERE EXISTS (
    SELECT 1
    FROM sales_order s
    WHERE s.client_no = c.client_no
);


-- 5. Subquery in FROM: Average order amount per client
SELECT client_no, AVG(total_amt) AS avg_order
FROM (
    SELECT s.client_no, SUM(d.qty_ordered * p.product_rate) AS total_amt
    FROM sales_order s
    JOIN sales_order_details d ON s.order_no = d.order_no
    JOIN product_master p ON d.product_no = p.product_no
    GROUP BY s.order_no
) AS order_totals
GROUP BY client_no;