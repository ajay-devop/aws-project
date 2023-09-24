FROM tomcat:8.0.20-jre8

COPY target/java-web-aap*.war /usr/local/tomact/webapps/java-web-app.war
