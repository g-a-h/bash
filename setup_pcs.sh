#!/usr/bin/evn bash
# gh - 2022
# setup pcs
#######

setup()
{ 
pcscmds="pcs cluster auth ha-node-1 ha-node-2; pcs cluster setup --name ${1}-ha ha-node-1 ha-node-2; pcs cluster status; pcs status nodes; pcs cluster start --all; pcs status nodes; pcs status corosync; pcs property set stonith-enabled=false; pcs property set no-quorum-policy=ignore; pcs resource create VIP-BO ocf:heartbeat:IPaddr2 ip=${2} cidr_netmask=${3} op monitor interval=30s; pcs cluster status; pcs status resources; pcs status| grep virtual_ip;" 

echo $pcscmds | sed 's/;/\n/g' | \
| while read i ; do 
    pcs $i | tee -a $4 
done 
} 

name=$1 
vipbo=$2
maskcidr=$3
outlog="./cluster.log"

yum -y install corosync pacemaker pcs
systemctl enable pcsd.service && systemctl start pcsd.service
setup $name $vipbo $maskcidr $outlog
