**This is a suggestion of baremetal scripts I used to launch my redhat node**

## Instructions:
- Download scripts
- Modify env.sh to include your node details
- Modify entrypoint.sh to point to your installation paths, typically change just USERPATH
- Download desired geth version
- Launch using (where /data/opt/alastria is your USERPATH)
    - nohup /data/opt/alastria/entrypoint.sh start 2>&1 1>/data/opt/alastria/logs/quorum.log &


