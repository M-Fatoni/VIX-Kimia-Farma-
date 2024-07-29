--Import File csv
CREATE TABLE kf_final_transaction (
    transaction_id VARCHAR PRIMARY KEY,
    product_id VARCHAR,
    branch_id INT,
    customer_name VARCHAR,
    date DATE,
    price NUMERIC,
    discount_percentage NUMERIC,
    rating NUMERIC
);

CREATE TABLE kf_product (
    product_id VARCHAR PRIMARY KEY,
    product_name VARCHAR,
    product_category VARCHAR,
    price NUMERIC
);

CREATE TABLE kf_inventory (
    inventory_id VARCHAR PRIMARY KEY,
    branch_id INT,
    product_id VARCHAR,
    product_name VARCHAR,
    opname_stock INT
);

CREATE TABLE kf_kantor_cabang (
    branch_id INT PRIMARY KEY,
    branch_category VARCHAR,
    kota VARCHAR,
    branch_name VARCHAR,
    provinsi VARCHAR,
    rating NUMERIC
);


--Combined Table
CREATE TABLE combined_transactions AS
SELECT 
    ft.transaction_id,
    ft.date,
    ft.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.branch_category,
    ft.customer_name,
    ft.product_id,
    p.product_name,
    p.product_category,
    ft.price AS transaction_price,
    p.price AS product_price,
    ft.discount_percentage,
    ft.rating AS transaction_rating,
    kc.rating AS branch_rating
FROM 
    kf_final_transaction ft
JOIN 
    kf_kantor_cabang kc ON ft.branch_id = kc.branch_id
JOIN 
    kf_product p ON ft.product_id = p.product_id;


-- Combined All Table
CREATE TABLE combined_data AS
SELECT 
    ct.*,
    i.inventory_ID,
    i.opname_stock
FROM 
    combined_transactions ct
LEFT JOIN 
    kf_inventory i ON ct.branch_id = i.branch_id AND ct.product_id = i.product_id;