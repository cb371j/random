

#!/bin/bash

#load Ubuntu image to  the brand new openstack cluster

#apt-get install python-openstackclient
#curl -O https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-amd64-disk1.img
#source openrc-dellgen10
#load Ubuntu image to  the brand new openstack cluster
#openstack image create  "ubuntu_16_04" --disk-format qcow2 --container-format bare --public  --file xenial-server-cloudimg-root.img
#create keypair
openstack keypair create key1 > key1
openstack security group create gvm
openstack security group rule create gvm --proto tcp  --dst-port 1:255 --remote-ip 0.0.0.0/0
#openstack security group rule create gvm --proto tcp --ingress --dst-port 1:255 --remote-ip 0.0.0.0/0
openstack security group rule create --protocol icmp gvm

#create public oam network
vlan=49
#start=210
#end=220
#gw=200
dns=172.28.9.74
netname=public-$vlan


openstack security group rule create gvm --proto tcp  --dst-port 1:255
openstack security group rule create --proto icmp gvm
neutron net-create net-49 --provider:physical_network bond0 --provider:network_type vlan --provider:segmentation_id 49
neutron subnet-create net-49 --allocation-pool start=172.27.49.221,end=172.27.49.230 172.27.49.0/24 --gateway 172.27.49.1 --dns-nameserver 172.28.9.74 --name subnet-49
openstack server create --flavor m1.large  --image 5b5fbab7-fa51-4605-9a5a-b248e83997a0 --nic net-id=40db886c-7498-4be6-a0ed-452ce4d50e93 --security-group gvm --key-name key1 vm-test1

#neutron net-create ${netname} --provider:physical_network bond0 --provider:network_type vlan --pro
#neutron subnet-create ${netname} --allocation-pool start=192.168.${vlan}.221,end=192.168.${vlan}.230 192.168.${vlan}.0/24 --gateway 192.168.${vlan}.200 --dns-nameserver ${dns} --name subnet-${vlan}
#public_net=`neutron net-list |grep $netname | sed 's/ //'|cut -f2 -d'|' `

# create sriov network and port
#neutron net-create sriov_2001 --provider:physical_network sriovnet2 --provider:network_type vlan --provider:segmentation_id 2001
#./openstack network create --share --provider-physical-network sriovnet1   --provider-network-type vlan --provider-segment 2001  sriov_2001
# openstack subnet create --network sriov_2001 --allocation-pool start=10.1.1.50,end=10.1.1.99   --dns-nameserver 8.8.4.4 --gateway 10.1.1.1  --#subnet-range 10.1.1.0/24 subnet_sriov_2001

#./openstack subnet create --network sriov_2001 --allocation-pool start=2.1.0.41,end=2.1.0.50   --dns-nameserver 8.8.4.4 --gateway 2.1.0.1  --#subnet-range 2.1.0.0/24 subnet_sriov_2001
#sriov_network=`neutron net-list |grep sriov_2001 | sed 's/ //'|cut -f2 -d'|' `
#sriov_subnet=`neutron subnet-list |grep subnet_sriov_2001 | sed 's/ //'|cut -f2 -d'|' `

# create sriov port


#openstack port create --network $sriov_network --vnic-type direct sriov_2001_port1
#openstack port create --network $sriov_network --vnic-type direct sriov_2001_port2
#./openstack port set sriov_2001_port --fixed-ip subnet=sriov_subnet
#sriov_port1=`neutron port-list |grep sriov_2001_port1 | sed 's/ //'|cut -f2 -d'|' `
#sriov_port2=`neutron port-list |grep sriov_2001_port2| sed 's/ //'|cut -f2 -d'|' `
#nova boot --flavor m1.large --image ubuntu16_04 --nic net-id=$public_net --nic port-id=$sriov_port1 --key-name sriov_key4 sriov_2001_vm1
#nova boot --flavor m1.large --image ubuntu16_04 --nic net-id=$public_net --nic port-id=$sriov_port2 --key-name sriov_key4 sriov_2001_vm2
#openstack server create --flavor m1.large --image Centos7 --nic net-id=ca375c40-2e58-4e39-b215-855540ea3b68 --security-group gvm vmtest1



#create public oam subnet
#create sriovnet1 nework for vlan2003
#create sriovnet1 subnet 2.1.1.0/24
#create sriovnet1 port on the network
#sriov_port=`neutron port-list |grep sriov_2001_port | sed 's/ //'|cut -f2 -d'|' `
#sriov_port=`neutron port-list |grep sriov_2001_port | sed 's/ //'|cut -f2 -d'|' `
#add ip to vlan2001 on host 40
#verify communication to sriov port

