# Pimcore Boilerplate

## Requirements

* `git`
* `docker` version `1.13+`
* `docker-compose` version `1.10+`

## Install

`git clone git@github.com:JeroenVanDerLaan/pimcore-boilerplate.git && cd pimcore-boilerplate && ./app/Resources/docker/build.sh`

Pimcore will be available at `127.0.0.1:8080/admin`

## Overview

...

## Known Issues

* Build process should be aware of mysql initialization status
* Not all container configuration is synchronized with `.env` values (like apache's virtual host)
* Pimcore complains about missing email settings
* Redis is not configured as the default Pimcore cache
