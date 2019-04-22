# Pimcore Boilerplate

## Requirements

* `git`
* `docker` version `1.13+`
* `docker-compose` version `1.10+`

## Install

**Quick Install:**

```
git clone git@github.com:JeroenVanDerLaan/pimcore-boilerplate.git && \ 
cd pimcore-boilerplate && \
./app/Resources/docker/install.sh
```

**Custom Install:**

* Clone the repo `git clone git@github.com:JeroenVanDerLaan/pimcore-boilerplate.git`
* Go to the project root `cd pimcore-boilerplate`
* (Optional) Edit `.env` to customize the environment
* Run the build `./app/Resources/docker/install.sh`

Pimcore will be available at `127.0.0.1:8080/admin`

## Usage

The installation will build and start four docker service containers on your machine: `mysql`, `php`, `apache` and `redis`.
They are all required to be up and running in order for your Pimcore application to work properly.

* To start the service containers, run `docker-compose up -d`.
* To stop running service containers, run `docker-compose stop`.
* To access a service container bash shell, run `docker-compose exec [service] bash` (this requires the service to be running).
* To remove all service containers, run `docker-compose down --volumes` (this requires a rebuild).

The `php` service will be used most often, as it contains the compiled PHP installation,
has access to composer, can run your unit tests, etc.

## Known Issues

* Build process should be aware of mysql initialization status
* Build script should stop and clean up if something goes wrong along the way
* Internal service ports are not set according to `.env`, but use their default ports.
* Not all `.env` values are used yet to configure Pimcore on installation (like email)
* Pimcore complains about missing email settings
* Redis is not configured as the default Pimcore cache
* Redis logs are not yet generated to mounted `var` volume
