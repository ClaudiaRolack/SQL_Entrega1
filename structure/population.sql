-- Tabla: countries

INSERT INTO countries (name, currency, language, tax_rate)
VALUES 
('Canada', 'CAD', 'English', 13.00),
('Australia', 'AUD', 'English', 10.00);

-- Tabla: publishers

INSERT INTO publishers (name, contact_email, phone_number, address)
VALUES 
('Penguin Random House', 'contact@penguin.com', '123-456-7890', '1745 Broadway, New York, NY'),
('HarperCollins', 'info@harpercollins.com', '987-654-3210', '195 Broadway, New York, NY');

-- Tabla: categories

INSERT INTO categories (name)
VALUES 
('Biografias');

-- Tabla: customers

INSERT INTO customers (name, email, phone_number, country_id, address)
VALUES 
('Alice', 'alice@example.com', '4567891234', 1, '123 Maple Street, Toronto, ON'),
('Michael', 'michael@example.com', '6543219876', 2, '45 George Street, Sydney, NSW');

-- Tabla: products

INSERT INTO products (name, description, base_price, stock, country_id)
VALUES 
('Dune', 'Una novela de ciencia ficcion de Frank Herbert', 29.99, 100, 1),
('The Martian', 'Una novela de ciencia ficcion Andy Weir', 19.99, 50, 2);

-- Tabla: promotions

INSERT INTO promotions (name, discount_percentage, start_date, end_date)
VALUES 
('Summer Sale', 15.00, '2025-06-01', '2025-06-30'),
('Holiday Discount', 25.00, '2025-12-01', '2025-12-31');

-- Tabla: reviews

INSERT INTO reviews (customer_id, product_id, rating, comment, review_date)
VALUES 
(21, 1, 5, 'Amazing book! Highly recommended', '2025-01-20'),
(22, 2, 4, 'Great read, but a bit slow in the middle', '2025-01-21');

-- Tabla: orders

INSERT INTO orders (customer_id, order_date, total_amount)
VALUES 
(21, '2025-01-15', 29.99),
(22, '2025-01-16', 19.99);

-- tabla: shipments

INSERT INTO shipments (order_id, shipment_date, tracking_number, status)
VALUES 
(12, '2025-01-17', 'TRACK123345684', 'entregado'),
(13, '2025-01-18', 'TRACK654432163', 'en transito');

-- Tabla: payments

INSERT INTO payments (order_id, payment_date, amount, payment_method)
VALUES 
(12, '2025-01-15', 29.99, 'Tarjeta de credito'),
(13, '2025-01-16', 19.99, 'Tarjeta de debito');

-- Tabla: wishlist

INSERT INTO wishlist (customer_id)
VALUES 
(21),
(22);

--Tabla: product_categories

INSERT INTO product_categories (product_id, category_id)
VALUES 
(22, 10),
(23, 10);

-- Tabla: wishlist_products

INSERT INTO wishlist_products (wishlist_id, product_id)
VALUES 
(13, 11),
(14, 5);

-- Tabla: product_promotions

INSERT INTO product_promotions (product_id, promotion_id)
VALUES 
(1, 1),
(2, 2);

-- Tabla: order_details

INSERT INTO order_details (order_id, product_id, quantity, price_at_purchase)
VALUES 
(12, 21, 1, 29.99),
(13, 22, 1, 19.99);