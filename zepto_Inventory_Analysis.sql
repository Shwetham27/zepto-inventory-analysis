CREATE DATABASE zepto_inventory;
USE zepto_inventory;
CREATE TABLE zepto_inventory_data (
    sku_id INT,
    category VARCHAR(100),
    name VARCHAR(255),
    mrp DECIMAL(10,2),
    discountPercent DECIMAL(5,2),
    availableQuantity INT,
    discountedSellingPrice DECIMAL(10,2),
    weightInGms INT,
    outOfStock TINYINT
);
USE zepto_inventory;

DROP TABLE zepto_inventory_data;

CREATE TABLE zepto_inventory_data (
    Category VARCHAR(100),
    name VARCHAR(255),
    mrp DECIMAL(10,2),
    discountPercent DECIMAL(5,2),
    availableQuantity INT,
    discountedSellingPrice DECIMAL(10,2),
    weightInGms INT,
    outOfStock BOOLEAN,
    quantity INT
);
USE zepto_inventory;

SELECT COUNT(*) AS total_products
FROM zepto_v1;

SELECT *
FROM zepto_v1
LIMIT 10;
USE zepto_inventory;

-- Business Question 1: How many product records are in the dataset?

SELECT COUNT(*) AS total_products
FROM zepto_v1;
-- Business Question 2: Which product categories have the most products?

SELECT
    `ï»¿Category` AS category,
    COUNT(*) AS total_products
FROM zepto_v1
GROUP BY `ï»¿Category`
ORDER BY total_products DESC;

-- Business Question 3: Which products have the highest discount percentages?

SELECT
    name,
    mrp,
    discountPercent,
    discountedSellingPrice
FROM zepto_v1
ORDER BY discountPercent DESC
LIMIT 10;

-- Business Question 4: Which products are out of stock?

SELECT
    name,
    `ï»¿Category` AS category,
    availableQuantity,
    outOfStock
FROM zepto_v1
WHERE outOfStock = 'TRUE'
ORDER BY availableQuantity ASC;

-- Business Question 5: What percentage of products are out of stock?

SELECT
    COUNT(*) AS total_products,
    SUM(CASE WHEN outOfStock = 'TRUE' THEN 1 ELSE 0 END) AS out_of_stock_products,
    ROUND(
        100.0 * SUM(CASE WHEN outOfStock = 'TRUE' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS out_of_stock_percentage
FROM zepto_v1;

-- Business Question 6: Which categories have the highest average discount?

SELECT
    `ï»¿Category` AS category,
    ROUND(AVG(discountPercent), 2) AS average_discount_percentage
FROM zepto_v1
GROUP BY `ï»¿Category`
ORDER BY average_discount_percentage DESC
LIMIT 10;

-- Business Question 7: Which products have the highest discounted selling prices?

SELECT
    name,
    `ï»¿Category` AS category,
    mrp,
    discountPercent,
    discountedSellingPrice
FROM zepto_v1
ORDER BY discountedSellingPrice DESC
LIMIT 10;

-- Business Question 8: Which products have the highest available quantity?

SELECT
    name,
    `ï»¿Category` AS category,
    availableQuantity,
    discountedSellingPrice,
    outOfStock
FROM zepto_v1
WHERE outOfStock = 'FALSE'
ORDER BY availableQuantity DESC
LIMIT 10;

-- Business Question 9: Which categories have the highest number of out-of-stock products?

SELECT
    `ï»¿Category` AS category,
    COUNT(*) AS out_of_stock_products
FROM zepto_v1
WHERE outOfStock = 'TRUE'
GROUP BY `ï»¿Category`
ORDER BY out_of_stock_products DESC;

-- Business Question 10: Which products have the lowest discounted selling prices?

SELECT
    name,
    `ï»¿Category` AS category,
    mrp,
    discountPercent,
    discountedSellingPrice
FROM zepto_v1
WHERE outOfStock = 'FALSE'
ORDER BY discountedSellingPrice ASC
LIMIT 10;

-- Business Question 11: Which products have discounts greater than 20%?

SELECT
    name,
    `ï»¿Category` AS category,
    mrp,
    discountPercent,
    discountedSellingPrice
FROM zepto_v1
WHERE discountPercent > 20
ORDER BY discountPercent DESC
LIMIT 15;

-- Business Question 12: Which categories have the highest average MRP?

SELECT
    `ï»¿Category` AS category,
    ROUND(AVG(mrp), 2) AS average_mrp
FROM zepto_v1
WHERE mrp > 0
GROUP BY `ï»¿Category`
ORDER BY average_mrp DESC;

-- Business Question 13: Which products have the largest price reductions?

SELECT
    name,
    `ï»¿Category` AS category,
    mrp,
    discountedSellingPrice,
    (mrp - discountedSellingPrice) AS price_difference,
    discountPercent
FROM zepto_v1
WHERE mrp > discountedSellingPrice
ORDER BY price_difference DESC
LIMIT 10;

-- Business Question 14: Which categories have the highest total available inventory quantity?

SELECT
    `ï»¿Category` AS category,
    SUM(availableQuantity) AS total_available_quantity
FROM zepto_v1
WHERE outOfStock = 'FALSE'
GROUP BY `ï»¿Category`
ORDER BY total_available_quantity DESC;

-- Business Question 15: Which products have invalid or suspicious price and quantity values?

SELECT
    name,
    `ï»¿Category` AS category,
    mrp,
    discountedSellingPrice,
    discountPercent,
    availableQuantity,
    outOfStock
FROM zepto_v1
WHERE mrp <= 0
   OR discountedSellingPrice < 0
   OR discountPercent < 0
   OR discountPercent > 100
   OR availableQuantity < 0
ORDER BY name;
