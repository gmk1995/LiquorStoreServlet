# LiquorStoreServlet

The code consists of several Java classes and a pom.xml file for a liquor store application. The main classes are:

LiquorType.java - An enum class that defines the different types of liquor (WINE, BEER, WHISKY).

LiquorService.java - A class that provides the available brands of liquor based on the type. It contains a method getAvailableBrands that takes the type of liquor as an input and returns a list of available brands.

SelectLiquorServlet.java - A servlet class that is called when a user submits the form on the index.html page. This class retrieves the selected liquor type from the form and calls the getAvailableBrands method of the LiquorService class. It then sets the returned list of brands as an attribute of the request and forwards the request to the result.jsp page.

web.xml - The web deployment descriptor for the application. It defines the tracking mode for the application's sessions.

index.html - A HTML page that allows the user to select the type of liquor from a dropdown list.

result.jsp - A JSP page that displays the available brands of liquor based on the user's selection.

pom.xml - The Maven Project Object Model (POM) file that contains information about the project and its dependencies.

This repository contains code for a Java Servlet application that runs in a Tomcat container and a Kubernetes deployment configuration.

## Dockerfile

The Dockerfile builds two Docker images, one for building the Java Servlet application using Maven and another for running the application in a Tomcat container.

Copy code
FROM maven as build
WORKDIR /opt/apps
COPY . /opt/apps
RUN mvn clean package
CMD [ "mvn" ]

FROM tomcat
COPY --from=build /opt/apps/target/LiquorStoreApp-1.0-SNAPSHOT.war /usr/local/tomcat/webapps
Kubernetes Manifest
The Kubernetes manifest LiquorServlet-Java-Web-App-Deployment.yaml defines a deployment and a service for the Java Servlet application. The deployment creates two replicas of the application and the service exposes the application on port 80.

apiVersion: apps/v1
kind: Deployment
metadata:
  name: java-liquorstoreservlet-deployment
  namespace: testing-env
spec:
  replicas: 2
  selector:
    matchLabels:
      app: java-liquorstoreservlet
  template:
    metadata:
      labels:
        app: java-liquorstoreservlet
    spec:
      containers:
      - name: java-liquorstoreservlet
        image: gmk1995/java-liquorstoreservlet:v1
        resources:
          limits:
            memory: "128Mi"
            cpu: "500m"
        ports:
        - containerPort: 8080
---

apiVersion: v1
kind: Service
metadata:
  name: java-liquorstoreservlet-service
  namespace: testing-env
spec:
  type: NodePort
  selector:
    app: java-liquorstoreservlet
  ports:

- port: 80
    targetPort: 8080

### Jenkinsfile

The Jenkinsfile describes a Jenkins pipeline for building, pushing and deploying the Java Servlet application. The pipeline consists of four stages:

Git checkout: Check out the source code from the repository on GitHub.
Docker build: Build a Docker image of the Java Servlet application.
Docker push: Push the Docker image to Docker Hub.
Kubernetes deployment: Apply the Kubernetes deployment configuration to create a deployment and a service for the application.

pipeline {
    agent any
    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')
        timestamps()
    }
    environment {
        DOCKERHUB_CREDENTIALS= credentials('Docker-Hub-Credentials')
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
            steps {
                sh "echo $DOCKERHUB_CREDENTIALS | sudo  docker login -u gmk1995 --password-stdin"
                sh "sudo docker push gmk1995/java-liquorstoreservlet:v1"

        }             
        }
        stage('KubernetesDeployment') {
            steps {
                sh "kubectl apply -f LiquorServlet-Java-Web-App-Deployment.yaml"
            }
        }
    }

    post {
        always {
            sh "docker logout"
        }
    }
}
