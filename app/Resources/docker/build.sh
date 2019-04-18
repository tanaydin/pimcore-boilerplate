#!/usr/bin/env bash

#Removing containers and images
docker-compose down --volumes --remove-orphans --rmi local

#Pulling images
docker-compose pull

#Building mysql
docker-compose build "mysql"

#Starting mysql (giving it time to initialize)
docker-compose up --no-build --remove-orphans --detach "mysql"

#Building php (with build arguments to create hosting user)
docker-compose build --build-arg USERNAME=$(id -nu) --build-arg USERID=$(id -u) --build-arg GROUPID=$(id -g) "php"

#Building redis
docker-compose build "redis"

#Building apache
docker-compose build "apache"

#Starting redis
docker-compose up --no-build --remove-orphans --detach "redis"

#Starting php
docker-compose up --no-build --remove-orphans --detach "php"

#Starting apache
docker-compose up --no-build --remove-orphans --detach "apache"

#Clearing var directories
docker-compose exec php bash -c "rm -rf var/ web/var/ web/bundles/"
docker-compose exec php bash -c "mkdir var/"
docker-compose exec php bash -c "git checkout var/"

#Installing (only) composer packages
docker-compose exec php bash -c "COMPOSER_MEMORY_LIMIT=-1 composer install --no-scripts --no-suggest --no-interaction --dev -vvv"

#Installing (clean) pimcore project
docker-compose exec php bash -c "vendor/bin/pimcore-install --ignore-existing-config --no-interaction --env=dev -vvv"

#Running composer post install scripts
docker-compose exec php bash -c "composer run-script post-install-cmd"

#clearing symfony cache
docker-compose exec php bash -c "bin/console cache:clear --no-warmup --env=dev"

#clearing pimcore cache
docker-compose exec php bash -c "bin/console pimcore:cache:clear --env=dev"

#deploying pimcore models
#docker-compose exec php bash -c "bin/console pimcore:deployment:classes-rebuild -vvv"

echo "Done!"