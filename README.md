# Getting started

`make init` will prepare the src/ sir with all the files you will need to customize for your setup.

Cutomize any file you need to in src/ .

Once you have that `make bastion` will make the bastion container and tag it on your remote repo ready to push.

Then `make database` will make the databse container and tag it on your remore repo ready to push.

Then `make app` will make the webapp container and tag it on your remore repo ready to push.

`terraform apply` will create registry, cluster and task definitions. You still need to push and have the EC2 stuff required to run a cluster beforehand.

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

## Infrastructure (WIP)

Definition of the infrastructure required to run in ECS is described as a terraform template.

You will need either an aws config file or the env vars set up to allow terraform access your aws account. The access key will work with the following policies (It probably needs less than that but this terraform thing is a wip):
- `AmazonEC2ContainerRegistryFullAccess`
- `AmazonEC2ContainerServiceFullAccess`

`terraform apply` will set up docker registries, cluster and task definitions.

You will need to grab the prefix of the registry created to use when tagging the shepherd containers, then push them.

This has been tested step-by-step pushing the containers between the registry creation and the task definition creation so it might as well fail horribly when applying all in one go.

If you already have a cluster you're probably better off modifying the .tf file and instruct the task to run on your pre-existing cluster instead of defining a new one.

### TODO

- create the EC2 resources to power the cluster
- test the "all in one go" thing
- figure out if the task definition needs the containers to be pushed before defining the task
- make-ize

## Limitations

- As there is currently no way to configure where the mongodb database required for the `NoSQL Injection 1` level is located, that level does not currently work.
- The infra stuff is a WIP
