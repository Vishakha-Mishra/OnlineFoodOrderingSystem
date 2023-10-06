CREATE DATABASE IF NOT EXISTS online_food_order_system;

use online_food_order_system;
 
CREATE TABLE food
(
	id INT NOT NULL,
	name VARCHAR(108) NOT NULL,
	PRIMARY KEY (id, name)
);

CREATE TABLE location
(
	pincode INT NOT NULL,
	area VARCHAR(51) NOT NULL,
	city VARCHAR(51) NOT NULL,
	state VARCHAR(51) NOT NULL,
	PRIMARY KEY (pincode, area),
	CHECK (pincode > 110000 AND pincode < 990001)
);

CREATE TABLE address
(
	id INT AUTO_INCREMENT NOT NULL,
	line1 VARCHAR(108),
	line2 VARCHAR(108),
	line3 VARCHAR(108),
	area VARCHAR(51) NOT NULL,
	pincode INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (pincode, area) REFERENCES location(pincode, area),
	CHECK (pincode > 110000 AND pincode < 990001)
);

-- A store can have multiple address, give same name
-- Example: McDonalds name with different address
CREATE TABLE store
(
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(108) NOT NULL,
	address_id INT,
	primary_phone INT,
	secondary_phone INT,
	PRIMARY KEY (id),
	FOREIGN KEY (address_id) REFERENCES address(id),
	CHECK (primary_phone > 999999999 AND primary_phone < 10000000000),
	CHECK (secondary_phone > 999999999 AND secondary_phone < 10000000000)
);

CREATE TABLE store_food
(
	store_id INT NOT NULL,
	food_id INT NOT NULL,
	price INT NOT NULL,
	FOREIGN KEY (store_id) REFERENCES store(id),
	FOREIGN KEY (food_id) REFERENCES food(id)
);

CREATE TABLE store_address_served
(
	store_id INT NOT NULL,
	pincode INT NOT NULL,
	delivery_charges INT NOT NULL,
	min_order INT,
	free_delivery_order_value INT,
	FOREIGN KEY (store_id) REFERENCES store(id),
	CHECK (pincode > 110000 AND pincode < 990001)
);

CREATE TABLE customer
(
	mobile INT NOT NULL,
	name VARCHAR(108) NOT NULL,
	email VARCHAR(108),
	gender CHAR NOT NULL,
	address_id INT NOT NULL,
	PRIMARY KEY(mobile),
	FOREIGN KEY (address_id) REFERENCES address(id),
	CHECK (gender = 'M' OR gender = 'F' OR gender = 'N' OR gender = 'S'),
	CHECK (mobile > 999999999 AND mobile < 10000000000)
);

CREATE TABLE orders
(
	id BIGINT NOT NULL,
	cust_id INT NOT NULL,
	store_id INT NOT NULL,
	food_id INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (cust_id) REFERENCES customer(id),
	FOREIGN KEY (store_id) REFERENCES store(id),
	FOREIGN KEY (food_id) REFERENCES food(id)
);
-- ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
-- LOAD DATA LOCAL INFILE 'D:/Vishakha/PICT/OnlineFoodOrderingSystem/location.csv' INTO TABLE location;
