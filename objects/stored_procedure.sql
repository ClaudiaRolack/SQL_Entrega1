-- STORED PROCEDURE 

-- sp_create_promotion

DELIMITER //

DROP PROCEDURE IF EXISTS sp_create_promotion;

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


-- sp_sales_report


DELIMITER //

DROP PROCEDURE IF EXISTS sp_sales_report;

CREATE PROCEDURE sp_sales_report()
BEGIN
    SELECT p.name AS product_name, SUM(od.quantity) AS total_sold, SUM(od.quantity * od.price_at_purchase) AS total_revenue
    FROM order_details od
    JOIN products p ON od.product_id = p.product_id
    GROUP BY p.product_id;
END 

//

DELIMITER ;