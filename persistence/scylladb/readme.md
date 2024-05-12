# Issue and Errors getting Scylla running on Docker Desktop

## Ascyn IO Error Starting SycllaDb on Docker Desktop

If you see the error below.

    (Could not setup Async I/O: Resource temporarily unavailable. The most common cause is not enough request capacity in /proc/sys/fs/aio-max-nr. Try increasing that number or reducing the amount of logical CPUs available for your application)

1. Install Ubuntu from MS Market Place
1. Start a linux terminal session
1. Check the value of `sysctl fs.aio-max-nr` and if default of 65536
1. Then run `sudo sysctl fs.aio-max-nr=1048576`

This will edit the default setting for the Linux OS that also sits under Docker. So should fix the issue.

* For testing also make sure the Scylla options `--overprovisioned 1 --smp 1` are set to limit the number of cores in use. Higher core pushes the IO up even more

## Manual start of three node cluster.

Inspect and use the IP for Node_X as the cluster seed.

     docker run --name Node_X -d scylladb/scylla:5.2.0 --overprovisioned 1 --smp 1
     docker inspect Node_Z -f "{{.NetworkSettings.IPAddress }}"
     docker run --name Node_Y -d scylladb/scylla:5.2.0 --seeds="172.17.0.2" --overprovisioned 1 --smp 1
     docker run --name Node_Z -d scylladb/scylla:5.2.0 --seeds="172.17.0.2" --overprovisioned 1 --smp 1
     docker exec -it Node_X nodetool status

and you should see (after a short wait for starting and joining)

    Datacenter: datacenter1
    =======================
    Status=Up/Down
    |/ State=Normal/Leaving/Joining/Moving
    --  Address     Load       Tokens       Owns    Host ID                               Rack
    UN  172.17.0.3  544 KB     256          ?       c507a447-27e1-4ac0-abc5-2ce8e1630347  rack1
    UN  172.17.0.2  260 KB     256          ?       28a154db-d235-4daa-b86c-5d92a58d6bc9  rack1
    UN  172.17.0.4  508 KB     256          ?       a4f0f285-e07f-45aa-a119-bd032fdcfd56  rack1

    Note: Non-system keyspaces don't have the same replication settings, effective ownership information is meaningless

## Access scylla from outside of K8s cluster

1. Create the service as NodePort
1. Find the WSL IP, open an Ubuntu shell on WSL then `ip a | grep eth0`
1. You can then connect via `cqlsh <ip> <port>` where IP is returned from above command and port is the port you defined in the NodePort service
1. e.g. `cqlsh 172.26.166.180 32000`