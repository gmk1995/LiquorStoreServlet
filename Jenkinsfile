pipeline {
    agent any
    tools {
        maven 'maven-3.8.7'
    }

    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')
        timestamps()
    }
    stages {
        stage('GitCheckOut') {
            steps {
                git branch: 'main', credentialsId: '026f781b-368d-4626-ab66-08d71d1d7d82', url: 'https://github.com/gmk1995/LiquorStoreServlet.git'
            }
        }
        stage('DockerBuild') {
            steps {
                sh "sudo docker build -t gmk1995/java-liquorstoreservlet:v1 ."
            }
        }
        stage('DockerPush'){
            steps { withCredentials([string(credentialsId: 'Docker-Credentials', variable: 'DOCKER-CREDENTIALS')]) {
                sh "sudo docker login --username \"gmk1995\" --password \"${DOCKER-CREDENTIALS}\""

        }
                sh "sudo docker push gmk1995/java-liquorstoreservlet:v1"
        }
        }

        stage('KubernetesDeployment') {
            steps {
                sh "sudo kubectl apply -f LiquorServlet-Java-Web-App-Deployment.yaml"
            }
        }
    }
}