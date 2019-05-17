#!/usr/bin/env bash

user=$(id -nu)
uid=$(id -u)
gid=$(id -g)

#Removing containers and images
docker-compose down --volumes --remove-orphans --rmi all

#Removing var directories
bash -c "rm --recursive --force vendor/ var/ web/var/ web/bundles/"

#Warming up var directories
bash -c "mkdir var/"
bash -c "cp --recursive app/Resources/docker/mysql/log var/mysql/"
bash -c "cp --recursive app/Resources/docker/php/log var/php/"
bash -c "cp --recursive app/Resources/docker/apache/log var/apache/"

#Building images
docker-compose build "mysql" "redis" "php" "apache"

#Starting containers
docker-compose up --no-build --remove-orphans --detach "mysql" "redis" "php" "apache"

#Installing composer packages
docker-compose exec php bash -c "COMPOSER_MEMORY_LIMIT=-1 composer install --no-suggest --no-interaction --dev -vvv"

#Installing pimcore
docker-compose exec php bash -c "vendor/bin/pimcore-install --env=dev --ignore-existing-config --no-interaction -vvv"

#Installing assets
docker-compose exec php bash -c "bin/console assets:install --env=dev --symlink -vvv"

#clearing symfony cache
docker-compose exec php bash -c "bin/console cache:clear --env=dev --no-interaction --no-warmup -vvv"

#clearing pimcore cache
docker-compose exec php bash -c "bin/console pimcore:cache:clear --env=dev --no-interaction -vvv"
