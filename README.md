- install docker
- run ```bash setup.sh```
- use postman to test API

### Additional commands:

# Restart all containers

- ```docker restart $(docker ps -q)```

# Stop and remove existing containers

```docker compose down```

# Build the new images

```docker compose build --no-cache```

# Bring the system back up

```docker compose up -d```

# run migration diff to get schema updated

```docker compose exec products-php php bin/console doctrine:migrations:diff```
