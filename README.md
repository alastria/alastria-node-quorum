# Alastria Node for Alastria-T Network

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![Slack Status](https://img.shields.io/badge/slack-join_chat-white.svg?logo=slack)](https://alastria.slack.com/)

Alastria-T Network is a [GoQuorum](https://github.com/ConsenSys/quorum) public-permissioned network that uses the [IBFT 1.0](https://docs.goquorum.consensys.net/en/stable/Concepts/Consensus/IBFT/) consensus algorithm, and it's managed by [Alastria](https://alastria.io/en/) partners.



[GoQuorum](https://github.com/ConsenSys/quorum) it's a fork of [Geth](https://geth.ethereum.org/) (the Official Go implementation of the Ethereum protocol) ownership by [Consensys](https://consensys.net/) that implements [Raft](https://docs.goquorum.consensys.net/en/stable/Concepts/Consensus/Raft/) and [IBFT](https://docs.goquorum.consensys.net/en/stable/Concepts/Consensus/IBFT/) consensus algorithm, and is licensed under the
[GNU Lesser General Public License v3.0](https://www.gnu.org/licenses/lgpl-3.0.en.html)

In Alastria-T Network there are 3 types of nodes.

* **Validators:** Nodes that are in charge of guaranteeing the consensus of the network and the generation of blocks. To do this, they run the consensus algorithm (IBFT).
* **Bootnodes:** Authorization or enabling of the Permitting Nodes to the Regular Nodes so that, using the gas limit granted, they propose (initiate), carry out (write), or consult (read) transactions. They acts like _proxy_ between Regular and Validator nodes.
* **Regular:** They participate by replicating the blockchain, accepting the blocks generated by the validators and executing the transactions included in them. They are also allowed to inject transactions into the Network from sources external to the blockchain. These kind of nodes are use for the interaction from `Web3.JS`, `EtherJS` and `Smart Contracts`, and should be the option for deploy uses cases of Blockchain. 


There are 2 main steps to set up an Alatria Node:

**1. Installation & configuration:** Follow the Docker installation steps and your node will be ready to be permissioned.

**2. Getting permissioned:** In order to use Alastria Network, your node must be previously accepted, after filling the form. 

If a member wants to remove a node from the network, please send us a **removal request** using the same [electronic form](https://forms.gle/UCnATiaJ4LPdGjP97).

---


# 1) Installation

The following process explain the installation for a Regular (also called _general_) nodes:

* Clone or download this repository to the machine where you want to install and operate the Red T node and enter into the cloned directory.

* :fire: Edit the `.env` file and modify the lines with:

>+ NODE_TYPE if your not sure what option its need, select _general_
>+ NODE_NAME attribute according to the name you want for this node. The name SHOULD follow the convention: `TYPE_COMPANY_T_Y_Z_NN`

Where _TYPE_ is the rol for the node in the network (use `REG` for regular/general nodes), _XX_ is your company/entity name, _Y_ is the number of processors of the machine, _Z_ is the amount of memory in Gb and _NN_ is a sequential counter for each machine that you may have (starting at 00). For example:

>+ `NODE_NAME="REG_IN2_T_2_8_00"`
>+ `NODE_NAME="REG_DigitelTS_T_2_8_00"`

This is the name that will appear in the public listings of nodes of the network. It does not have any other usage.

* :fire: Edit the `docker-compose.yml` file, and make your own changes.

* In the root directory of the repository (where the file `docker-compose.yml` exists) run:

```console
$ docker-compose up -d
```

* The command runs the service in the background, and you can check it's activity by running:

```console
$ docker-compose logs -f --tail=20
```
  * **You're done!** :sunglasses: :dancer: :v: :beers:

### :bulb: Quick Guide for [docker-compose](https://docs.docker.com/compose/)

### :bulb: For more specific information about to using or updating to higher versions of GoQuorum, please, refer to [this section](#upgrading-to-higher-goquorum-versions).

  
# 2) Permissioning new node

You should see the node initializing and starting to try to contact peers. However, the node is not yet permissioned, so it can not participate in the blockchain network yet.

All nodes in  Alastria Networks must be permissioned. To ask for permission you must enter your data in this [electronic form](https://forms.gle/7CxGn2gE4GwRRLBt7), providing these information of your node: 

**1. ENODE:** String from ENODE_ADDRESS file (enode://YOUR_ENODE@YOUR_IP:21000?discport=0)

**2. Public IP:** The external IP of your node.

**3. System details:** Number of cores (vCPUs), RAM Memory & Hard disk size.


If an associated want to remove a node from the network, it is kindly appreciated that a request must be notified through an issue. 

In order to get permissioning, follow these steps (you will be asked for this information in the previous form):

* Display the contents of the ENODE_ADDRESS file (the actual contents of your file will be different than in the example):

```console
$ docker exec -it REG_ExampleOrg_T_2_8_00 geth --exec "admin.nodeInfo.enode" attach /root/alastria/data/geth.ipc
```

* Get the IP address of your node, as seen from the external world. 

```console
$ curl https://ifconfig.me/
```

* Create the full enode address like:

 `enode://YOUR_ENODE@YOUR_IP:21000?discport=0`

 where

 >+ **YOUR_ENODE** is the value of the ENODE_ADDRESS file
 >+ **YOUR_IP** is the external IP of your node


* Once your request is fulfilled after form submission, you will see that your node starts connecting to its peers and starts synchronizing the blockchain. The process of synchronization can take hours or even one or two days depending on the speed of your network and machine.

Now it's time to start knowing more about `GoQuorum`:
* https://geth.ethereum.org/docs/interface/command-line-options
* https://docs.goquorum.consensys.net/en/stable/
* https://github.com/ConsenSys/quorum 


# Infraestructure details

### System requirements

| Hardware  | Minimum | Desired |
|---        |---      |--- |
| CPU's     | 2       |  4 |
| Memory    | 4Gb     |  8Gb |
| Hard Disk | 128 Gb  |  256 Gb |

DLT database grows 1Gb/week: keep in mind for future updates. SSD disc it's also mandatory.

### System ports (INPUT)

The following ports must be open, at least, to the nodes defined in the `/root/alastria/data/static-nodes.json` and `/root/alastria/data/permissioned-nodes.json` files. We recommend that these ports be universally open: the `whisper protocol` defined in `GoQuorum` is robust enough to be published without the need for control through the firewall.

| Port  | Type    | Definition |
|---    |---      |--- |
| 21000 | TCP/UDP | Geth process application port (inbound and outbound for ethereum traffic) |
| 53    | TCP/UDP | Access to external Internet based resolvers |
| 6060  | TCP     | Inbound for **Prometheus** scraping from IP address 185.180.8.152 |

`tcp/21000` and `udp/21000`port are mandatory, as is the common standard for the Alastria-T Network.

Other ports are optional, and can be used from applications like `Metamask`, `Truffle` or `Remix`

| Port  | Type | Definition |
|---    |---   |--- |
| 22000 | TCP  | *Optional* port for JSON-RPC connections |
| 22001 | TCP  | *Optional* port for WebSockets connections |

### System ports (OUTPUT)

We strongly advise not to filter outgoing ports. If necessary, these are the destinations

| Port | Type | Definition |
|---   |---   |--- |
| 80   | TCP  | Outbound for WebSockets feed to [Netstats Server](http://netstats.telsius.alastria.io/) (in case you're running core node)|
| 6060 | TCP  | Outbound for **Prometheus** scraping from IP address 185.180.8.152 (in case you're running regular node) |

### Mandatory parameters

Some parameters are high hardcoded in this installer, but can be change:

* Working directory: The install procedure expect use of `/root/alastria/data` as the main directory.
* `GoQuorum` and `Go` versions: Changing the `alastria-node/Dockerfile` it's easy to change the build version.
* Data directory: Because of the size that the DLT database can reach, a Docker volume has been deployed to set the storage on some independent path from the one set by the Docker installation. This parameter is set in `docker-compose.yml`, in _volumes_ tag.
* Geth parameters: Other geth options can be personalized in `geth.node.bootnode.sh`, `geth.node.general.sh` or `geth.node.validator.sh`.

### Environment Variables

These variables should be use for any script in:

* `NODE_TYPE=[general|boot|validator]`: Rol for your node in the network.
* `NODE_NAME=REG_ExampleOrg_T_2_8_00`: Name for your node.
* `NODE_BRANCH=main`: Used for future improvements.



# Regular Node

### Maintenance

You can use the standard docker-compose commands to manage your node. For example:

```console
# Stop node:
$ docker-compose down

# To restart the node:
$ docker-compose restart

# Delete current container
$ docker rm REG_ExampleOrg_T_2_8_00
```

Node management is done through the geth console. It can be accessed through the following commands:

```console
$ geth attach http://localhost:22000 (in case geth were started with --rpc options)
# or
$ geth attach /root/alastria/data/geth.ipc
```

```
$ curl -X POST --header 'Content-Type: application/json' --data '{"jsonrpc":"2.0","method":"admin_nodeInfo","params":[], "id":1}' http://127.0.0.1:22
000
```

The commands can be invoked from the Docker client, or by accessing the container: 

```console
$ docker ps -a
# or
$ docker exec -it <container_name> /bin/bash
```

Some useful commands:

```console
root@62369c8b018e:/usr/local/bin# geth attach /root/alastria/data/geth.ipc
Welcome to the Geth JavaScript console!

instance: Geth/REG_DigitelTS-pre_T_2_4_00/v1.8.18-stable(quorum-v2.2.3-0.Alastria_EthNetstats_IBFT)/linux-amd64/go1.9.5
coinbase: 0x1e02232b297055717e3381ad458f8b23cb9ada03
at block: 60568501 (Mon, 25 Jan 2021 21:37:51 UTC)
 datadir: /root/alastria/data
 modules: admin:1.0 debug:1.0 eth:1.0 istanbul:1.0 miner:1.0 net:1.0 personal:1.0 rpc:1.0 txpool:1.0 web3:1.0

> personal.newAccount()
Passphrase:
Repeat passphrase:
"0x1234..."
> admin.peers
> admin.nodeInfo
> eth.blockNumber
> eth.syncing
> eth.mining
> eth.coinbase
> web3.version.network
> net.peerCount
> admin.datadir
> txpool.status
```

Full documentacion can be found in https://geth.ethereum.org/docs/interface/javascript-console

An easy way to test that your node is operating normally is to generate a fund transfer transaction from the node's account, itself from 0 weis.

```console
> personal.unlockAccount(eth.accounts[0],"_your_eth0_password_",2000)
> Unlock account 0x1234...
Passphrase:
true
> eth.sendTransaction({from: eth.accounts[0], to: eth.accounts[0], value:0 })
"0x1234..."
```

If the transaction appears in Alastria-T [Network explorer](https://blkexplorer1.telsius.alastria.io/blocks), the node it's working correctly.
### Backup

The following items should be backed up:

>+ `/root/alastria/data/geth/nodekey`: This file contains the cryptographic information for joying the network. This file can be restored to start over a new installation without restarting the permissioning process.
>+ ` /root/alastria/data/keystore/`: This directory contains local accounts created from the node.

### Resetting DLT

```console:
$ cp /root/alastria/data/geth/nodekey <enode-backup>
$ geth removedb_DONOTDELETEACCIDENTALY --datadir /root/alastria/data
$ geth --datadir /root/alastria/data init /root/genesis.json
$ cp <enode-backup> /root/alastria/data/geth/nodekey
$ (restart-container)
```

### Istanbul Governance IBFT

As the T-network uses the Istanbul BFT consensus protocol, the way to generate new blocks in the test-net is to have validator nodes available in the network and integrate them into the set of nodes that are part of the validation round.

Each round is initiated by a different node that "proposes" a set of transactions in a block and distributes them to the rest of the nodes.

The validator nodes must focus on operating the consensus protocol, integrating the transactions in the blockchain and distributing them to the rest of the nodes. 

### geth args for regular/general Nodes

```console
NODE_ARGS=" --rpc --rpcaddr 127.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,istanbul --rpcport 22000"
```

Also WebSockets connection is allowed:
```console
NODE_ARGS=" --ws --wsaddr 127.0.0.0 --wsport 22001 --wsorigins source.com"
```

> NOTE: use of [GraphQL](https://docs.goquorum.consensys.net/en/stable/HowTo/Use/graphql/) will be available soon.

### Application Ports
To use your node through web3 applications, some connection method must be enabled. In this case, the following connection methods are offered:

* JSON-RPC connection: you should upgrade the following files, in order to allow `Web3.JS` or `EtherJS` connections; `docker-compose.yml` allow new connection from `tcp/22000`, or the one defined in `alastria-node-data/env/geth.common.sh` related to `JSON-RPC` connections.
> NOTE: exposing this port should be controlled by any kind of firewall, or using any proxy filtering, as proposed in [alastria-access-point](https://github.com/alastria/alastria-access-point) project.
* WebSockets connection: please, follow this article [Connecting to an Alastria-T Network node using WebSockets](https://tech.tribalyte.eu/blog-websockets-red-t-alastria) created by Ronny Demera, from Tribalyte.

# Boot Nodes

Boot nodes are responsible for permitting the nodes in the network. They are visible to all types of nodes. The boot node should not be used in any case to operate directly with it to interact with the network, so only `IPC` ports are allowed.

### geth args for boot nodes

```console
NODE_ARGS="--maxpeers 256"
```

# Validator Nodes

The validator nodes should not be used in any case to operate directly with it to interact with the network, so nor `JSON-RPC` nor `WebSockets` ports are not allowed.

* `istanbul.getValidators()` retrieves the list of validators that make up the validation round.

* `istanbul.propose ("0x ...", true)` votes for the validator represented by the coinbase to be integrated into the validation round. It must be accepted by at least half of the nodes.

* `istanbul.propose ("0x ...", false)` votes for the validator represented by the coinbase to be excluded from the validation round. It must be rejected by at least half of the nodes. 

* `istanbul.getSnapshot()` get current status for changes in validator nodes.

```console
$ geth attach alastria/data/geth.ipc
> istanbul.getValidators() 
[...]
> istanbul.propose("_coinbase_of_node_validator_", true) #add validator node
> istanbul.propose("_coinbase_of_node_validator_", false) #remove validator node
```

## geth args for validator nodes

```console
NODE_ARGS=" --maxpeers 32 --mine --minerthreads $(grep -c "processor" /proc/cpuinfo)"
```

# Upgrading to higher GoQuorum versions

If your node is fully synced with the chain, you can skip step 1. To see if your node is still syncing or not, you can use the following RPC call:
```sh
$ curl -X POST -H "Content-type: application/json" --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' http://127.0.0.1:22000
```
If the response contains a `"result":false`, your node is already synced and you can go ahead to step 2.

### Step 1: Syncing the node
For GoQuorum versions strictly higher than v21.1.0 the node won't sync with the chain. To get your node syncing you must downgrade your node's version to v21.1.0, or less. Also, you must set the syncing option to fast: `--syncmode fast`.

Once your node is fully synced, you can got to step 2.

### Step 2: Upgrading GoQuorum version

To upgrade your node's GoQuorum version you must update the GoQuorum binaries with which you are running your node and restart it.

With this, your node should be running fine and on the desired GoQuorum version.

# Other Resources

+ [Wiki](https://github.com/alastria/alastria-node/wiki)
+ [FAQ ES](https://github.com/alastria/alastria-node/wiki/FAQ_ES)
+ [FAQ EN](https://github.com/alastria/alastria-node/wiki/FAQ_EN)

| URL | Managed by | Notes|
|--- |--- |--- |
| [http://netstats.core-redt.alastria.io/](http://netstats.core-redt.alastria.io/) | Alastria | |
| [https://alastria-netstats2.planisys.net:8443/login](https://alastria-netstats2.planisys.net) | Planisys | Prometheus + Grafana stats, pulled from each node (user alastria, pass alastria) |
| [https://blkexplorer1.telsius.alastria.io](https://blkexplorer1.telsius.alastria.io) | CouncilBox | |
| [https://alastria-caliper.planisys.net/](https://alastria-caliper.planisys.net/) | Planisys | Prometheus generated by geth 1.9.7 - quorum 2.6.0 |

# Contributing

The following developments are in place or in backlog. Any help/volunteers are welcomed:

* Create `Ansible`, `Swarm`, `Makefile`, `Chef`,... recipes in order to performing `node` installs.
* Upgrade to the new EVM and the new GoQuorum version. `WIP` :fire::fire::fire:
* Netstats improvements, to allow this tool to handle a very big number of nodes.
* Validator nodes automatic round, to allow the network to make automatic change of the validator nodes without intervention of the humans administrators, in case of any fault/malfunctioning of the nodes.
* HardFork to upgrade Geth binary to prepare for Gas implementation Faucet or Gas Distributor.
* Upcoming releases of Alastria-T Network will use [Orion](https://docs.orion.consensys.net/en/stable/) or [EtherSigner](https://docs.ethsigner.consensys.net/en/stable/) as layer for private transactions.
* Promote the use of local explorers.
* Improve monitoring system for nodes in network.

# Help Resources

Please, use Github to contribute and collaborate on open issues that are in development on Alastria Github platform.
Do not hesitate to contact Alastria Support Team to solve any doubt in support@alastria.io.

* [Slack](https://alastria.slack.com)
* [Github](https://github.com/alastria/alastria-node/wiki/HELP)

# Changes from alastria-node repo

The following lines are changes from [testnet2](https://github.com/alastria/alastria-node/tree/testnet2) branch:

* Use of [Constellation](https://github.com/ConsenSys/constellation) it's no longer supported. Previous documentation can be found in [Constellation Using Pivate Transactions in Alastria T](https://github.com/alastria/alastria-node/wiki/Constellation---Using-Pivate-Transactions-in-Alastria-T).
* Use of `nginx` as proxy it's no longer supported. However, the repository https://github.com/alastria/alastria-access-point it's still available.
* Tool `monitor` is deprecated, and no longer used.
* The Alastria fork of `quorum`, https://github.com/alastria/quorum it's not used anymore.


# FAQs

##
* __Q:__ How conncent Truffle with AlastriaB network?
* __A:__ Lastest versions of `GoQuorum` use HDWallet for accesing the node. This is an example:

```
const fs = require("fs");
const HDWalletProvider = require("@truffle/hdwallet-provider");
const keythereum = require('keythereum');

/**
 * Use https://iancoleman.io/bip39/ for generate a .secret file
 */
const mnemonic = fs.readFileSync(".secret").toString().trim();
const localNode = "http://your-node:22000"

module.exports = {
  networks: {
    'alastriaT': {
      gasPrice: 0x0,
      provider: () => {
        return new HDWalletProvider(mnemonic, localNode);
      },
      network_id: "83584648538",
    },
  },
  compilers: {
    solc: {
      version: "0.5.17",
      settings: {
        optimizer: {
          enabled: true,
          runs: 100
        },
        evmVersion: "byzantium"
      }
    }
  }
}

```


## Changelog 

### Monitoring 2022/02/14

Alastria T Network dashboard is at https://alastria-netstats2.planisys.net:8443/login , user alastria, pass alastria

In order for your Node to be listed here please run geth with following options:

* --metrics --pprof --pprof.addr=0.0.0.0

and open port 6060 to IP address 185.180.8.152


## Operation documents of Alastria nodes 
Other guides related with operation of Alastria Node are available in following documents:

* [Alastria-T Network Operation and Government Policies (en_GB)](https://alastria.io/wp-content/uploads/2020/04/POLI-TICAS-GOBIERNO-Y-OPERACIO-N-RED-ALASTRIA-V1.01-DEF-en-GB.pdf)
* [Alastria-T Network Operation and Government Policies (es_ES)](https://alastria.io/wp-content/uploads/2020/04/POLI-TICAS-GOBIERNO-Y-OPERACIO-N-RED-ALASTRIA-V1.01-DEF.pdf)

* [Conditions of operation of the Alastria-T Network Regular Nodes (en_GB)](https://alastria.io/wp-content/uploads/2020/06/CONDICIONES-USO-RED-NODOS-REGULARES-A-LA-RED-ALASTRIA-v1.1-DEF-en-GB.pdf)
* [Conditions of operation of the Alastria-T Network Regular Nodes (es_ES)](https://alastria.io/wp-content/uploads/2020/06/CONDICIONES-USO-RED-NODOS-REGULARES-A-LA-RED-ALASTRIA-v1.1-DEF.pdf)

* [Conditions of operation of the Alastria-T Network Critical (boot && validator) Nodes (en_GB)](https://alastria.io/wp-content/uploads/2020/06/CONDICIONES-OPERACIO-N-RED-T-POR-PARTE-DE-NODOS-CRI-TICOS-V1.1-DEF-en-GB.pdf)
* [Conditions of operation of the Alastria-T Network Critical (boot && validator) Nodes (es_ES)](https://alastria.io/wp-content/uploads/2020/06/CONDICIONES-OPERACIO%CC%81N-RED-T-POR-PARTE-DE-NODOS-CRI%CC%81TICOS-V1.1-DEF.pdf)



Based on the work of:
* Jesús Ruiz, https://github.com/hesusruiz.
* Marcos Serradilla, https://github.com/marcosio.
* Alfonso de la Rocha, https://github.com/adlrocha.
* ... and many other contributors to the [Alastria](https://alastria.io/en/) ecosystem, :raised_hands: :raised_hands: :raised_hands:
