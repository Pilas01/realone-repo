FROM tomcat:9
COPY SampleWebApp/target/vprofile-v2.war /usr/local/tomcat/webapps
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
EXPOSE 8080
