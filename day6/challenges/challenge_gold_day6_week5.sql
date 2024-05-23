-- Database: joins

-- DROP DATABASE IF EXISTS joins;

CREATE DATABASE joins
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_Israel.1251'
    LC_CTYPE = 'English_Israel.1251'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE product_orders (
    order_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    order_date DATE
);

CREATE TABLE items (
    item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES product_orders(order_id),
    item_name VARCHAR(255),
    price DECIMAL(10, 2)
);

--Creating a function to calculate the total price for a given order
CREATE OR REPLACE FUNCTION calculate_total_price(order_id_param INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    total_price DECIMAL(10, 2);
BEGIN
    SELECT SUM(price)
    INTO total_price
    FROM items
    WHERE order_id = order_id_param;
    
    RETURN total_price;
END;
$$ LANGUAGE plpgsql;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE
);

CREATE OR REPLACE FUNCTION calculate_total_price_for_user(user_id_param INTEGER, order_id_param INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    total_price DECIMAL(10, 2);
BEGIN
    SELECT SUM(price)
    INTO total_price
    FROM items
    WHERE order_id = order_id_param
    AND order_id IN (SELECT order_id FROM product_orders WHERE user_id = user_id_param);
    
    RETURN total_price;
END;
$$ LANGUAGE plpgsql;


