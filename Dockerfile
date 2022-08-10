FROM tomcat:9.0.65-jre8

COPY target/01-maven-web-app.war /usr/local/tomcat/webapps/01-maven-web-app.war
