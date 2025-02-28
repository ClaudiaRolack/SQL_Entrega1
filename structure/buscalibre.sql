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


-- INSERCION DE DATOS 


INSERT INTO customers (customer_id, name, email, phone_number, address, country_id)
VALUES
(12, 'pedro', 'pedro@email.com', '56987654321', 'calle las palmas 45, santiago, chile', 1),
(13, 'isabella', 'isabella@email.com', '5491165432101', 'avenida 9 de julio 4567, buenos aires, argentina', 2),
(14, 'esteban', 'esteban@email.com', '573015432109', 'carrera 30 # 10-22, medellin, colombia', 3),
(15, 'sofia', 'sofia@email.com', '349612345678', 'calle de vallehermoso 234, barcelona, españa', 4),
(16, 'raul', 'raul@email.com', '5215559876543', 'paseo de la reforma 1000, ciudad de mexico, mexico', 5),
(17, 'veronica', 'veronica@email.com', '51987865432', 'jr. de la union 178, lima, peru', 6);