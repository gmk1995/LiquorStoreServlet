pipeline {
    agent any 

    tools {
        maven 'maven3.8.7'
       }
       
    options {
  buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')
}

    stages {
        stage('GitCheckOut') {
            steps{
                git branch: 'main', credentialsId: '026f781b-368d-4626-ab66-08d71d1d7d82', url: 'https://github.com/gmk1995/LiquorStoreServlet.git'
            }
        }

        stage('Maven Build') {
            steps {
                sh "mvn clean package"
            }
        }

        stage('SonarQubeReport') {
            steps{
                sh "mvn sonar:sonar"
            }
        }

        stage('UploadToArtifacts') {
            steps{
                sh "mvn clean deploy"
            }
        }

        stage('DeployingWarFileInTomcatServer') {
            steps{ sshagent(['Tomcat-ssh-connection-key']) { 
                sh "scp -o StrictHostKeyChecking=no target/LiquorStoreApp-1.0-SNAPSHOT.war ec2-user@13.233.121.198:/opt/apache-tomcat-9.0.71/webapps/LiquorStoreApp-1.0-SNAPSHOT.war"
            }
            }
        }
    }
}