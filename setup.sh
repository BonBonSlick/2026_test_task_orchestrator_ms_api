#!/bin/bash
set -e # Stop script if any command fails

# 1. Handle Repositories
update_repo() {
    local dir=$1
    local repo=$2
    if [ ! -d "$dir" ]; then
        echo "Cloning $dir..."
        git clone "$repo" "$dir"
    else
        echo "Updating $dir..."
        cd "$dir" && git pull origin master && cd ..
    fi
}

update_repo "service-products" "git@github.com:BonBonSlick/2026_test_task_products_ms_api.git"
update_repo "service-orders" "git@github.com:BonBonSlick/2026_test_task_orders_ms_api.git"

# 2. Fire up Docker
docker compose up -d --build

# Function to setup a service
setup_service() {
    local service_name=$1
    local env_file=$2
    local uri=$3

    echo "Setting up $service_name..."
    docker compose exec $service_name git config --global --add safe.directory /var/www/html

    # Create .env if missing, or ensure DEFAULT_URI is present
    if [ ! -f "$env_file" ]; then touch "$env_file"; fi
    grep -q "DEFAULT_URI" "$env_file" || echo "DEFAULT_URI=$uri" >> "$env_file"

    docker compose exec $service_name composer install
}

setup_service "products-php" "service-products/.env" "http://localhost:8081"
setup_service "orders-php" "service-orders/.env" "http://localhost:8082"

echo "System ready!"
