CREATE TABLE MyDimDate (
	date_id INT NOT NULL PRIMARY KEY,
	date_value DATE,
	year_value INT,
	quarter_value INT,
	quarter_name VARCHAR(255),
	month_value INT,
	month_name VARCHAR(255),
	day_value INT,
	day_of_week VARCHAR(255),
	day_name VARCHAR(255)
);

CREATE TABLE MyDimWaste (
	waste_id INT NOT NULL PRIMARY KEY,
	waste_type VARCHAR(255)
);

CREATE TABLE MyDimZone (
	zone_id INT NOT NULL PRIMARY KEY,
	zone_name VARCHAR(255),
	zone_city VARCHAR(255)
);

CREATE TABLE MyFactTrips (
	trip_id INT NOT NULL PRIMARY KEY,
	zone_id INT,
	waste_id INT,
	date_id INT,
	tons_waste_collected FLOAT
);
