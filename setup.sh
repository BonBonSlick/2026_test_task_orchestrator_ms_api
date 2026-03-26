#!/bin/bash

# 1. Clone repos if they don't exist
if [ ! -d "service-products" ]; then
    git clone git@github.com:BonBonSlick/2026_test_task_products_ms_api.git service-products
fi

if [ ! -d "service-orders" ]; then
    git clone git@github.com:BonBonSlick/2026_test_task_orders_ms_api.git service-orders
fi

# 2. Fire up Docker
docker compose up -d --build

# 3. Fix Git Ownership & Setup Environment for Products
docker compose exec products-php git config --global --add safe.directory /var/www/html
if [ ! -f "service-products/.env" ]; then
    cp service-products/.env.dev service-products/.env 2>/dev/null || touch service-products/.env
fi
docker compose exec products-php composer install

# 4. Fix Git Ownership & Setup Environment for Orders
docker compose exec orders-php git config --global --add safe.directory /var/www/html
if [ ! -f "service-orders/.env" ]; then
    cp service-orders/.env.dev service-orders/.env 2>/dev/null || touch service-orders/.env
fi
docker compose exec orders-php composer install

echo "System ready!"
