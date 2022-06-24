# Upgrading node to GoQuorum version 21.10.2

Follow the instructions to upgrade your node to GoQuorum version 21.10.2, if you already installed your node with docker-compose following the instructions from [Alastria Node for Alastria-T Network](https://github.com/alastria/alastria-node-quorum#alastria-node-for-alastria-t-network).

In this instructions we will assume that the alastria-node-quorum repository was cloned into the user's home directory. If not, set the appropriate base path for the commands instead of `~/`.

## 1. Stop the running node
Go to the docker-compose folder, and stop the running node:

```console
$ cd ~/alastria-node-quorum/docker-compose
$ docker-compose down
```

## 2. Clone the upgrade-branch/GoQuorum-21.10.2 branch and configure the node
Return to the base path and clone this branch:
```console
$ cd ~
$ git clone -b upgrade-branch/GoQuorum-21.10.2 https://github.com/alastria/alastria-node-quorum alastria-node-quorum-21.10.2
```

Here you will have to edit the `.env` and `docker-compose.yml` files to correctly configure de node:

#### .env
Check the file `~/alastria-node-quorum-21.10.2/docker-compose/.env` and edit the values of the variables to conform the correct values for your node. You can directly copy the content from the original installation:
```console
$ cp ~/alastria-node-quorum/docker-compose/.env ~/alastria-node-quorum-21.10.2/docker-compose/.env
```

#### docker-compose.yml
In the file `~/alastria-node-quorum-21.10.2/docker-compose/docker-compose.yml` you have to make the following changes:

* In the `volumes` section write the correct path for the `/path/to/geth/datadir` placeholder. It should be `~/alastria-node-quorum/docker-compose/alastria-node-data/data` if no changes where made in this section in the original installation. Otherwise, write the correct path for the geth datadir of the node.
* If you are configuring a regular node uncomment lines `- "22000:22000/tcp"` and `- "22001:22001/tcp"` in the `ports` section to be able to use the HTTP and WS connections.

## 3. Restart the node
Once everything is configured you can start the node with the upgraded GoQuorum version:
```console
$ cd ~/alastria-node-quorum-21.10.2/docker-compose
$ docker-compose up -d
```

# Troubleshooting
## Failing to fetch DEB packages from repositories in image building process
If you get errors like `E: Failed to fetch xxxxx 404  Not Found` when executing `docker-compose up -d` try the following:
* First build the image discarding the cache with `docker-compose build --no-cache`
* Start the container with `docker-compose up -d`
