-- VIEWS

-- v_top_products


DROP VIEW IF EXISTS v_top_products;

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


DROP VIEW IF EXISTS v_top_rated_books;

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


DROP VIEW IF EXISTS v_sales_summary;

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


DROP VIEW IF EXISTS v_customer_wishlists;

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


DROP VIEW IF EXISTS v_promotions_active;

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


DROP VIEW IF EXISTS v_shipments_status;

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


DROP VIEW IF EXISTS v_country_tax_rates;

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