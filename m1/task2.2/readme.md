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

**Lightsail. Created WP Site**

![AWS](WP_site.png)

**Created backet**

![AWS](S3_backet.png)


**S3 work trough CLI**

![AWS](s3_cli.png)


**Created domenNAME**
>fluggegecheimen.click


**Instaled and configurate Docker in EC2**

![AWS](Docker_EC2.png)

**Pushed image to Amazon ECR (Elastic Container Registry)**

![AWS](PushRepo.png)

![AWS](PushRepo2.png)


**Created Cluster ans added Task Definition some types images: DockerHUB and ECR**

![AWS](Cluster.png)

![AWS](ClusterTasks.png)

![AWS](fromDockerHUB.png)

![AWS](fromECR.png)

![AWS](instanceActyvyty.png)


[fluggegecheimen.click](fluggegecheimen.click)






















