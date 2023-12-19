#!/bin/sh

## Write your code here to load the data from sales_data table in Mysql server to a sales.csv.
## Select the data which is not more than 4 hours old from the current time.
mysql sales --user=root --password=MzkyNS1tYXNhZGFt -B \
 -e "SELECT rowid, product_id, customer_id, price, quantity, timestamp \
  FROM sales_data WHERE TIMESTAMPDIFF(HOUR, timestamp, CURRENT_TIMESTAMP) <= 4" \
 | sed 's/\t/,/g' > sales.csv;


echo "sales.csv created";

head sales.csv;

export PGPASSWORD=MjA5MTMtbWFzYWRh;

psql --username=postgres --host=localhost --dbname=sales_new \
 -c "\COPY sales_data(rowid,product_id,customer_id,price,quantity,timestamp) FROM '/home/project/sales.csv' delimiter ',' csv header;";

 ## Delete sales.csv present in location /home/project
 rm sales.csv;
 echo "sales.csv removed";



 ## Write your code here to load the DimDate table from the data present in sales_data table

 psql --username=postgres --host=localhost --dbname=sales_new \
  -c  "INSERT INTO dimdate(dateid, day, month, year) \
  SELECT \
   CAST(to_char(timestamp, 'YYYYmmdd') AS INT), \
   EXTRACT(DAY FROM timestamp) AS day, \
   EXTRACT(MONTH FROM timestamp) AS month, \
   EXTRACT(YEAR FROM timestamp) AS year \
  FROM sales_data";


## Write your code here to load the FactSales table from the data present in sales_data table

psql --username=postgres --host=localhost --dbname=sales_new \
 -c "INSERT INTO factsales(rowid, product_id, customer_id, price, total_price) \
  SELECT rowid, product_id, customer_id, price, quantity * price \
  FROM sales_data";


 ## Write your code here to export DimDate table to a csv

 psql --username=postgres --host=localhost --dbname=sales_new \
  -c "\COPY public.dimdate TO '/home/project/DimDate.csv' CSV HEADER";


 ## Write your code here to export FactSales table to a csv
 
 psql --username=postgres --host=localhost --dbname=sales_new \
  -c "\COPY public.factsales TO '/home/project/FactSales.csv' CSV HEADER";

