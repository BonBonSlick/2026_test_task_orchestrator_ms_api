-- This runs only when the volume is empty/new
CREATE DATABASE products_db;
CREATE DATABASE orders_db;

GRANT ALL PRIVILEGES ON DATABASE products_db TO symfony;
GRANT ALL PRIVILEGES ON DATABASE orders_db TO symfony;
