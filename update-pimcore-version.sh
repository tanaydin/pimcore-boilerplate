#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Please add new version number as a command-line argument"
fi

cp composer.json .composer-base.json

line=$(grep \"pimcore/pimcore\":\ \" composer.json)
version=$(echo $line | cut -d '"' -f 4)
sed "s/$version/$1/g" .composer-base.json > composer.json

docker-compose exec php bash -c "COMPOSER_MEMORY_LIMIT=-1 composer update --no-suggest --no-interaction --dev -vvv"
