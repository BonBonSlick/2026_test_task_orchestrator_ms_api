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

# Set up rmq

```docker compose exec products-php php bin/console messenger:setup-transports```

# Check Count

```docker compose exec products-php php bin/console messenger:stats --format=json```

# Start Worker

```docker compose exec products-php php bin/console messenger:consume```

# Clear Queue

```docker compose exec products-php bin/console messenger:stop-workers```

# Debug Logic

```docker compose exec products-php php bin/console messenger:consume -vv```

# Check service inside container

```docker compose exec products-php ping messenger-hub```
