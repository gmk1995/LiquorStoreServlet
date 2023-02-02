FROM maven as build
WORKDIR /opt/apps   
COPY . /opt/apps
RUN mvn clean package
CMD [ "mvn" ]

FROM tomcat
COPY --from=build /opt/apps/target/LiquorStoreApp-1.0-SNAPSHOT.war /usr/local/tomcat/webapps