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

### Kubernetes Manifest

The Kubernetes manifest LiquorServlet-Java-Web-App-Deployment.yaml defines a deployment and a service for the Java Servlet application. The deployment creates two replicas of the application and the service exposes the application on port 80.

#### Jenkinsfile

The Jenkinsfile describes a Jenkins pipeline for building, pushing and deploying the Java Servlet application. The pipeline consists of four stages:

Git checkout: Check out the source code from the repository on GitHub.
Docker build: Build a Docker image of the Java Servlet application.
Docker push: Push the Docker image to Docker Hub.
Kubernetes deployment: Apply the Kubernetes deployment configuration to create a deployment and a service for the application.
