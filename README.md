# Getting started

`make init` will prepare the src/ sir with all the files you will need to customize for your setup

Cutomize any file you need to in src/

Once you have that `make bastion` will make the bastion container and tag it on your remote repo ready to push

## bastion

The bastion is the container that will grant a tunnel access inside the CTF infrastructure.
The file you want to customize is `src/authorized_keys` with the public ssh key of anyone who will partecipate in the CTF.

## clean targets

`make clean` will delete the individual build dirs leaving `src` and downloaded artifacts intact.

`make distclean` will delete the entire `build` dir.

`make nuke` will delete the entire `build` dir and `src`. This will destroy all of your configurations.
