# Docker

* Install Docker

!!!Uninstal old version!
> sudo apt remove docker docker-angine docker.io containerd runc


- Set up the repository
Update the apt package index and install packages to allow apt to use a repository over HTTPS:

```
sudo apt update
sudo apt install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

- Add Docker’s official GPG key:

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

- Use the following command to set up the stable repository. To add the nightly or test repository, add the word nightly or test (or both) after the word stable in the commands below
```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

**Install Docker Engine**

```
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -y

 ```

 - Verify that Docker Engine is installed correctly by running the hello-world image.

 > sudo docker run hello-world

- start docker from current user (you need logout)

> sudo usermod -aG docker ubuntu



# Create docker image

Create docker dir and file
```
mkdir Dockerfiles
cd Dockerfiles/
touch dockerfile

nano dockerfile

add there:

FROM ubuntu:20.04
ENV TZ=Europe/Kiev
RUN apt -y update
RUN DEBIAN_FRONTEND="noninteractive" \ apt -y install apache2
RUN echo 'Hi there, what is love?' >> /var/www/html/index.html
RUN echo 'It is just a song...' >> /var/www/html/index.html
CMD ["/usr/sbin/apache2ctl","-DFOREGROUND"]
EXPOSE 80
```

- Finally build it:
> docker build -t <tag (from img)> 

example
> docker build -t web_server1:0.1 .

Port forwarding from host 7777 to 80 docker container
> docker run -d -p 7777:80 web_server1:0.1

list images
> docker images

list running containers
> docker ps

Delete images and containers
> docker system prune -a

# Repo Docker Hub

Create repo in https://hub.docker.com
and than login in docker host
> docker login

Tags before push
>docker login

```
docker images
REPOSITORY    TAG       IMAGE ID       CREATED       SIZE
web_server1   0.1       935b7acc3816   4 hours ago   219MB

```

```
docker tag <imageId or tag> <dockerhub id>/<imagename>:<tag>

docker tag 935b7acc3816 itigors/dev_online:latest

docker images
REPOSITORY            TAG       IMAGE ID       CREATED       SIZE
itigors/web_server1   latest    935b7acc3816   4 hours ago   219MB
web_server1           0.1       935b7acc3816   4 hours ago   219MB


docker push itigors/dev_online:latest

The push refers to repository [docker.io/itigors/web_server1]
510f54b3ad5a: Pushed
75275c17185e: Pushed
f19f853f4414: Pushed
8626e373f842: Pushed
0eba131dffd0: Pushed


```




the format used is this:
>docker tag local-image:tagname new-repo:tagname








 



