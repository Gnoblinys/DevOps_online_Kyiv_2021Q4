## HyperV and Vagrant ##

I uset to HyperV and have expiriens with a lot off virtuals servers and different network - external, internal and private.

I moved to learnd Vagrant.

**I Instal Vagrant and created work directory**

- init box
>vagrant init generic/ubuntu2004

- Edited vagrantfile

Added publick network (DHCP) and share folders

![network_share](https://github.com/Gnoblinys/DevOps_online_Kyiv_2021Q4/blob/master/m1/task2.1/network_share.png?raw=true)

![test share](https://github.com/Gnoblinys/DevOps_online_Kyiv_2021Q4/blob/master/m1/task2.1/test%20share.png?raw=true)

- Setup and start VM1 and 2

>vagrant up - start  box

![VMashines](https://github.com/Gnoblinys/DevOps_online_Kyiv_2021Q4/blob/master/m1/task2.1/HV_VM1_VM2.png?raw=true)

- Changed vagrantdfile and reload VM for update setup

>vagrant reload "generic/ubuntu2004"

 - Stop VM
>vagrant halt - shutdown VM








