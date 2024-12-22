CREATE VIEW view_customer_wishlists AS
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
   
SELECT * FROM view_customer_wishlists vcw; 
