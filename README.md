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

The installation will build and start four docker services on your machine: `mysql`, `php`, `apache` and `redis`.
They are all required to be up and running in order for your Pimcore application to work properly.
This can be done easily by navigating to the project root, and executing `docker-compose up -d`.
To (temporarily) stop all services, run `docker-compose stop`.
If you want to remove all services, run `docker-compose down` (this requires a rebuild!)

The environment consists of four services `mysql`, `php`, `apache` and `redis`.

All of these services can be accessed via `docker-compose exec [service] bash`.

The `php` service will be used most often, as it contains the compiled PHP installation,
has access to composer, can run your unit tests, etc.

## Known Issues

* Build process should be aware of mysql initialization status
* Build script should stop and clean up if something goes wrong
* Not all container configuration is synchronized with `.env`
* Pimcore complains about missing email settings
* Redis is not configured as the default Pimcore cache
