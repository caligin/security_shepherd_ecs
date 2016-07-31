# Getting started

`make init` will prepare the src/ sir with all the files you will need to customize for your setup.

Cutomize any file you need to in src/ .

Once you have that `make bastion` will make the bastion container and tag it on your remote repo ready to push.

Then `make database` will make the databse container and tag it on your remore repo ready to push.

Then `make app` will make the webapp container and tag it on your remore repo ready to push.

## bastion

The bastion is the container that will grant a tunnel access inside the CTF infrastructure.
The file you want to customize is `src/authorized_keys` with the public ssh key of anyone who will partecipate in the CTF.

## database

The database container is a mysql with the core and levels schema pre-initialized.

There is no customization needed for this container.

`make database` is enough to build.

## app

The database container is a tomcat with the webapp installed, a simple `server.xml` configuration and a `database.properties` set to point to a container linked with the name `database`.

There is no customization needed for this container.

`make app` is enough to build.

### patch

The `moduleSchemas.sql` file is patched to allow access from an host different than localhost as the containers for database and webapp will be different.

## clean targets

`make clean` will delete the individual build dirs leaving `src` and downloaded artifacts intact.

`make distclean` will delete the entire `build` dir.

`make nuke` will delete the entire `build` dir and `src`. This will destroy all of your configurations.

## Limitations

As there is currently no way to configure where the mongodb database required for the `NoSQL Injection 1` level is located, that level does not currently work.
