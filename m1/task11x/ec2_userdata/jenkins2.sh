#!/bin/bash
sudo apt update
sudo apt install openjdk-11-jdk -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
sudo echo "JAVA_ARGS="-Djenkins.install.runSetupWizard=false"" >> /etc/default/jenkins
sudo mkdir /var/lib/jenkins/init.groovy.d
cat <<EOT > /var/lib/jenkins/init.groovy.d/basic-security.groovy
#!groovy
import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()
println "--> creating local user 'admin'"

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount('admin','admin123')
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)
instance.save()
EOT
sudo service jenkins restart
sleep 60
sudo wget http://localhost:8080/jnlpJars/jenkins-cli.jar
sudo java -jar jenkins-cli.jar -auth admin:admin123 -s http://localhost:8080/ install-plugin parameterized-trigger git Terraform workflow-job -restart