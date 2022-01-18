
 wget http://localhost:8080/jnlpJars/jenkins-cli.jar


java -jar jenkins-cli.jar -s http://localhost:8080 -auth JENKINS_USER_ID:JENKINS_USER_TOKEN who-am-i

#envariable for user:pass
export JENKINS_USER_ID=cliuser
export JENKINS_API_TOKEN=11302556d28eabf8acc83c7169eb64e2e1

env | grep JENKINS

#Than you can use short comand:
java -jar jenkins-cli.jar -s http://localhost:8080  who-am-i