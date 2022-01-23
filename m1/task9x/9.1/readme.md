# Install Jenkins to Ubuntu #

**Jenkins Debian Packages**

This is the Debian package repository of Jenkins to automate installation and upgrade. To use this repository, first add the key to your system:

```
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null

```
Then add a Jenkins apt repository entry:

```
  echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
```

Update your local package index, then finally install Jenkins:
```
sudo apt-get update
sudo apt-get install jenkins
```

**Java**
```
sudo apt install openjdk-11-jdk
```

**Start Jenkins**
```
systemctl daemon-reload
systemctl start jenkins
systemctl status jenkins
```

* Config file for change port

```
nano /etc/default/jenkins

add: 
HTTP_HOST=127.0.0.1
```

It's all!






