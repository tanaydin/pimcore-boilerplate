#!/usr/bin/env bash

user=$(id -nu)
uid=$(id -u)
gid=$(id -g)

#Removing containers and images
docker-compose down --volumes --remove-orphans --rmi all

#Warming up directories
bash -c "rm -rf vendor/ var/ web/var/ web/bundles/"
bash -c "mkdir --parents vendor/ var/ web/var/ web/bundles/"
bash -c "git checkout var/ web/var/ web/bundles/"
bash -c "cp --no-clobber --recursive app/Resources/docker/logs/* var/"

#Building mysql
docker-compose build --build-arg user=${user} --build-arg uid=${uid} --build-arg gid=${gid} "mysql"

#Starting mysql (giving it time to initialize)
docker-compose up --no-build --remove-orphans --detach "mysql"

#Building remaining images
docker-compose build --build-arg user=${user} --build-arg uid=${uid} --build-arg gid=${gid} "redis" "php" "apache"

#Starting remaining containers
docker-compose up --no-build --remove-orphans --detach "redis" "php" "apache"

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