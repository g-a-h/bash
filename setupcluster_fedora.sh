#!/bin/bash 
# gh - 2022
# setup pcs
#######

setup()
{ 
name=$1 
vipbo=$2
maskcidr=$3

pcscmds="pcs cluster auth ha-node-1 ha-node-2; pcs cluster setup --name ${name}-ha ha-node-1 ha-node-2; pcs cluster status; pcs status nodes; pcs cluster start --all; pcs status nodes; pcs status corosync; pcs property set stonith-enabled=false; pcs property set no-quorum-policy=ignore; pcs resource create VIP-BO ocf:heartbeat:IPaddr2 ip=${vipbo} cidr_netmask=${maskcidr} op monitor interval=30s; pcs cluster status; pcs status resources; pcs status| grep virtual_ip;" 

echo $pcscmds | sed 's/;/\n/g' | while read i ; do 
    pcs $i 
done 
} 

yum -y install corosync pacemaker pcs
systemctl enable pcsd.service && systemctl start pcsd.service
setup $1 $2 $3  
