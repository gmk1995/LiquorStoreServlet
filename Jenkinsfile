pipeline {
    agent any 

    stages {
        stage('GitCheckOut') {
            steps{
                
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
            steps{
                sh ""
            }
        }
    }
}