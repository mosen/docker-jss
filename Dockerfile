# Version 0.0.7

FROM ubuntu:latest

MAINTAINER "nmcspadden@gmail.com"

RUN apt-get update
RUN apt-get install -y openjdk-7-jdk
RUN apt-get install -y tomcat7
RUN mv /var/lib/tomcat7/webapps/ROOT /var/lib/tomcat7/webapps/TOMCAT
ADD ROOT.war /var/lib/tomcat7/webapps/ROOT.war
RUN apt-get install -y mysql-client
ADD tomcatKeystore.sh /home/docker/jss/tomcatKeystore.sh
RUN bash /home/docker/jss/tomcatKeystore.sh
RUN mkdir -p /home/docker/jss/logs
RUN mkdir -p /Library/JSS/
RUN ln -s /home/docker/jss/logs /Library/JSS/Logs
RUN chown tomcat7:tomcat7 /home/docker/jss/logs

EXPOSE 8443
EXPOSE 8080
