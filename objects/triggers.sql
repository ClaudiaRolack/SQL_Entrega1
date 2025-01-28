-- TRIGGERS 

-- trg_update_total_amount


DELIMITER //

DROP TRIGGER IF EXISTS trg_update_total_amount;

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


-- trg_reduce_stock


DELIMITER //

DROP TRIGGER IF EXISTS trg_reduce_stock;

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