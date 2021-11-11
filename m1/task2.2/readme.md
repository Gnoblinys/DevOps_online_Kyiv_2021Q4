## **TASK2.2** ##

**Amazon Lightsail. Create VM in the AWS cloud and connect to it.** 

![AWS](ex4.png)

![AWS](ex4.2.png)


**Created instans and get access**

![AWS](ex5.png)


**Take snapshot**

![AWS](ex6.png)

**Add EBS extended storadge, attached to instance, mount like /media/share.**
**Reboot mashine, check**

I create new instanse VM2 from snapshot VM1, but one created in different Availability Zone us-east-2c (VM1 and Disk_D  us-east-2a).
I tok shapshot for disk_D, and created new disk_D from this snapshot in target AZ - us-east-2c. Attached to VM2, mount in OS and chek.

![AWS](instances.png)

![AWS](volumes.png)

![AWS](snapshots.png)

![AWS](mount.png)









