CREATE DATABASE buscalibre;

USE buscalibre;

CREATE TABLE countries (
    country_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    currency VARCHAR(10) NOT NULL,
    language VARCHAR(10) NOT NULL,
    tax_rate DECIMAL(5, 2) NOT NULL
);

CREATE TABLE publishers (
    publisher_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    address TEXT NOT NULL
);

CREATE TABLE categories (
    category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE customers (
    customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    country_id INT,
    address TEXT NOT NULL
);

CREATE TABLE products (
    product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    country_id INT
);

CREATE TABLE promotions (
    promotion_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    discount_percentage DECIMAL(5, 2),
    start_date DATE,
    end_date DATE
);

CREATE TABLE reviews (
    review_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5) NOT NULL,
    comment TEXT NOT NULL,
    review_date DATE NOT NULL
);

CREATE TABLE orders (
    order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2)
);

CREATE TABLE shipments (
    shipment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    shipment_date DATE NOT NULL,
    tracking_number VARCHAR(50),
    status VARCHAR(50)
);
 
CREATE TABLE payments (
    payment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2),
    payment_method VARCHAR(50)
);

CREATE TABLE wishlist (
    wishlist_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT
);

CREATE TABLE product_categories (
    product_category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    category_id INT
);

CREATE TABLE wishlist_products (
    wishlist_product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    wishlist_id INT,
    product_id INT
);

CREATE TABLE product_promotions (
    product_promotion_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    promotion_id INT
);

CREATE TABLE order_details (
    order_detail_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL
);

ALTER TABLE
	customers
	ADD CONSTRAINT fk_customers
	FOREIGN KEY (country_id) REFERENCES countries(country_id);

ALTER TABLE
	products
	ADD CONSTRAINT fk_products
	FOREIGN KEY (country_id) REFERENCES countries(country_id);

ALTER TABLE
	reviews
	ADD CONSTRAINT fk_reviews_customers
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE
	reviews
	ADD CONSTRAINT fk_reviews_products
	FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE
	shipments
	ADD CONSTRAINT fk_shipments_orders
	FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE
	payments
	ADD CONSTRAINT fk_payments_orders
	FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE
	wishlist
	ADD CONSTRAINT fk_wishlist_customers
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

ALTER TABLE 
	product_categories
	ADD CONSTRAINT fk_product_categories_products
	FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE 
	product_categories
	ADD CONSTRAINT fk_product_categories_categories
	FOREIGN KEY (category_id) REFERENCES categories(category_id);

ALTER TABLE 
	wishlist_products
	ADD CONSTRAINT fk_wishlist_products_wishlist
	FOREIGN KEY (wishlist_id) REFERENCES wishlist(wishlist_id);

ALTER TABLE 
	wishlist_products
	ADD CONSTRAINT fk_wishlist_products_products
	FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE 
	product_promotions
	ADD CONSTRAINT fk_product_promotions_products
	FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE 
	product_promotions
	ADD CONSTRAINT fk_product_promotions_promotions
	FOREIGN KEY (promotion_id) REFERENCES promotions(promotion_id);

ALTER TABLE 
	order_details
	ADD CONSTRAINT fk_order_details_orders
	FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE 
	order_details
	ADD CONSTRAINT fk_order_details_products
	FOREIGN KEY (product_id) REFERENCES products(product_id);


-- INSERCION DE DATOS -----------------------------------------------------------------------------------------------


INSERT INTO customers (customer_id, name, email, phone_number, address, country_id)
VALUES
(12, 'pedro', 'pedro@email.com', '56987654321', 'calle las palmas 45, santiago, chile', 1),
(13, 'isabella', 'isabella@email.com', '5491165432101', 'avenida 9 de julio 4567, buenos aires, argentina', 2),
(14, 'esteban', 'esteban@email.com', '573015432109', 'carrera 30 # 10-22, medellin, colombia', 3),
(15, 'sofia', 'sofia@email.com', '349612345678', 'calle de vallehermoso 234, barcelona, españa', 4),
(16, 'raul', 'raul@email.com', '5215559876543', 'paseo de la reforma 1000, ciudad de mexico, mexico', 5),
(17, 'veronica', 'veronica@email.com', '51987865432', 'jr. de la union 178, lima, peru', 6);


-- VIEWS -----------------------------------------------------------------------------------------------

-- v_top_products
CREATE VIEW v_top_products AS
SELECT 
    p.product_id,
    p.name AS product_name,
    SUM(od.quantity) AS total_sold
FROM 
    products p
JOIN 
    order_details od ON p.product_id = od.product_id
GROUP BY 
    p.product_id, p.name
ORDER BY 
    total_sold DESC;


-- v_top_rated_books
CREATE VIEW v_top_rated_books AS
SELECT 
    p.product_id,
    p.name AS book_name,
    p.description,
    AVG(r.rating) AS average_rating
FROM 
    products p
JOIN 
    reviews r ON p.product_id = r.product_id
GROUP BY 
    p.product_id, p.name, p.description
HAVING 
    AVG(r.rating) >= 4.0
ORDER BY 
    average_rating DESC;

-- v_sales_summary
CREATE VIEW v_sales_summary AS
SELECT 
    o.order_id,
    o.order_date,
    SUM(od.quantity) AS total_items_sold,
    SUM(od.price_at_purchase * od.quantity) AS total_revenue
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id
GROUP BY 
    o.order_id, o.order_date
ORDER BY 
    o.order_date DESC;


--v_customer_wishlists
CREATE VIEW v_customer_wishlists AS
SELECT 
    c.customer_id,
    c.name AS customer_name,
    w.wishlist_id,
    p.name AS product_name,
    p.description
FROM 
    customers c
JOIN 
    wishlist w ON c.customer_id = w.customer_id
JOIN 
    wishlist_products wp ON w.wishlist_id = wp.wishlist_id
JOIN 
    products p ON wp.product_id = p.product_id
ORDER BY 
    c.customer_id, w.wishlist_id;


-- v_promotions_active
CREATE VIEW v_promotions_active AS
SELECT 
    pr.promotion_id,
    pr.name AS promotion_name,
    pr.discount_percentage,
    p.name AS product_name,
    p.base_price,
    (p.base_price - (p.base_price * (pr.discount_percentage / 100))) AS discounted_price,
    pr.start_date,
    pr.end_date
FROM 
    promotions pr
JOIN 
    product_promotions pp ON pr.promotion_id = pp.promotion_id
JOIN 
    products p ON pp.product_id = p.product_id
WHERE 
    CURDATE() BETWEEN pr.start_date AND pr.end_date
ORDER BY 
    pr.start_date;


--v_shipments_status
CREATE VIEW v_shipments_status AS
SELECT 
    s.shipment_id,
    s.tracking_number,
    s.status AS shipment_status,
    s.shipment_date,
    o.order_id,
    c.name AS customer_name
FROM 
    shipments s
JOIN 
    orders o ON s.order_id = o.order_id
JOIN 
    customers c ON o.customer_id = c.customer_id
ORDER BY 
    s.shipment_date DESC;


-- v_country_tax_rates
CREATE VIEW v_country_tax_rates AS
SELECT 
    c.name AS country_name,
    c.tax_rate,
    p.name AS product_name,
    p.base_price,
    (p.base_price + (p.base_price * (c.tax_rate / 100))) AS price_with_tax
FROM 
    countries c
JOIN 
    products p ON c.country_id = p.country_id
ORDER BY 
    country_name, product_name;


-- FUNCTIONS -----------------------------------------------------------------------------------------------

-- get_product_count_by_category
DELIMITER //

CREATE FUNCTION get_product_count_by_category(category_name VARCHAR(100))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE product_count INT;
    SELECT COUNT(p.product_id) INTO product_count
    FROM products p
    JOIN product_categories pc ON p.product_id = pc.product_id
    JOIN categories c ON pc.category_id = c.category_id
    WHERE c.name = category_name;
    RETURN product_count;
END 

//

DELIMITER ;

SELECT get_product_count_by_category('ficcion clasica') AS product_count;


-- get_total_sales_by_customer
DELIMITER //

CREATE FUNCTION get_total_sales_by_customer(customer_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_sales DECIMAL(10,2);
    
    SELECT SUM(od.quantity * od.price_at_purchase) 
    INTO total_sales
    FROM order_details od
    JOIN orders o ON od.order_id = o.order_id
    WHERE o.customer_id = customer_id;
    
    IF total_sales IS NULL THEN
        SET total_sales = 0;
    END IF;
    
    RETURN total_sales;
END 

//

DELIMITER ;


SELECT get_total_sales_by_customer(1)


-- STORED PROCEDURE -----------------------------------------------------------------------------------------------


-- sp_create_promotion
DELIMITER //

CREATE PROCEDURE sp_create_promotion(
    IN promotion_name VARCHAR(100),
    IN discount_percentage DECIMAL(5,2),
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    INSERT INTO promotions (name, discount_percentage, start_date, end_date)
    VALUES (promotion_name, discount_percentage, start_date, end_date);
END 

//

DELIMITER ;

CALL sp_create_promotion('aniversario', 45.00, '2024-03-18', '2024-03-24');


-- sp_sales_report
DELIMITER //

CREATE PROCEDURE sp_sales_report()
BEGIN
    SELECT p.name AS product_name, SUM(od.quantity) AS total_sold, SUM(od.quantity * od.price_at_purchase) AS total_revenue
    FROM order_details od
    JOIN products p ON od.product_id = p.product_id
    GROUP BY p.product_id;
END 

//

DELIMITER ;

CALL sp_sales_report()


-- TRIGGERS -----------------------------------------------------------------------------------------------


-- trg_update_total_amount
DELIMITER //

CREATE TRIGGER trg_update_total_amount
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
    UPDATE orders
    SET total_amount = (
        SELECT SUM(quantity * price_at_purchase)
        FROM order_details
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END;

//

DELIMITER ;

INSERT INTO order_details (order_id, product_id, quantity, price_at_purchase)
VALUES (1, 2, 3, 15.50);

SELECT total_amount FROM orders WHERE order_id = 1;


-- trg_reduce_stock
DELIMITER //

CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END;

//

DELIMITER ;

INSERT INTO order_details (order_id, product_id, quantity, price_at_purchase)
VALUES (1, 1, 5, 19.99);

SELECT stock FROM products WHERE product_id = 1;
