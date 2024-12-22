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


SELECT get_total_sales_by_customer(2)
