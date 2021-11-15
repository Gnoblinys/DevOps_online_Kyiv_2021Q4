## **TASK2.2** ##

**Amazon Lightsail. Create VM in the AWS cloud and connect to it.** 

![AWS](images/ex4.png)

![AWS](images/ex4.2.png)


**Created instans and get access**

![AWS](images/ex5.png)


**Take snapshot**

![AWS](images/ex6.png)

**Add EBS extended storadge, attached to instance, mount like /media/share.**
**Reboot mashine, check**

I create new instanse VM2 from snapshot VM1, but one created in different Availability Zone us-east-2c (VM1 and Disk_D  us-east-2a).
I tok shapshot for disk_D, and created new disk_D from this snapshot in target AZ - us-east-2c. Attached to VM2, mount in OS and chek.

![AWS](images/instances.png)

![AWS](images/volumes.png)

![AWS](images/snapshots.png)

![AWS](images/mount.png)

**Lightsail. Created WP Site**

![AWS](images/WP_site.png)

**Created backet**

![AWS](images/S3_backet.png)


**S3 work trough CLI**

![AWS](images/s3_cli.png)


**Created domenNAME**
>fluggegecheimen.click


**Instaled and configurate Docker in EC2**

![AWS](images/Docker_EC2.png)

**Pushed image to Amazon ECR (Elastic Container Registry)**

![AWS](images/PushRepo.png)

![AWS](images/PushRepo2.png)


**Created Cluster ans added Task Definition some types images: DockerHUB and ECR**

![AWS](images/Cluster.png)

![AWS](images/ClusterTasks.png)

![AWS](images/fromDockerHUB.png)

![AWS](images/fromECR.png)

![AWS](images/instanceActyvyty.png)


[fluggegecheimen.click](www.fluggegecheimen.click)






















