#!/usr/bin/env bash

echo "Building Docker containers"
docker-compose down
start=$(date +%s)
docker-compose up -d --build
end=$(date +%s)
leftover=$(($start + 25 - $end))
while [[ ${leftover} -gt 0 ]]
do
    echo -ne "Waiting ${leftover} seconds...\r"
    sleep 1
    leftover=$(($leftover - 1))
done
echo ""

#echo "Resetting var directory"
#docker-compose exec php rm -rf "var/"
#git checkout "var/"

echo "Deploying Pimcore application"
docker-compose exec php bash -c "COMPOSER_MEMORY_LIMIT=-1 composer install --no-scripts --no-suggest --no-interaction --dev -vvv"
docker-compose exec php bash -c "vendor/bin/pimcore-install --ignore-existing-config --no-interaction --env=dev -vvv"
docker-compose exec php bash -c "composer run-script post-install-cmd"
#docker-compose exec php bash -c "bin/console pimcore:deployment:classes-rebuild -vvv"

echo "Clearing cache"
docker-compose exec php bash -c "bin/console cache:clear --no-warmup --env=dev"
docker-compose exec php bash -c "bin/console pimcore:cache:clear --env=dev"

#echo "Enabling var directory write access"
#docker-compose exec php chmod -R og+rw "var/"

#echo "Updating git index"
#git update-index --assume-unchanged "var/config/system.php"

echo "Done!"