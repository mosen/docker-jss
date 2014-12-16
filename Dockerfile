# Version 0.0.7

FROM ubuntu:latest

MAINTAINER "nmcspadden@gmail.com"

RUN apt-get update
RUN apt-get install -y openjdk-7-jdk
RUN apt-get install tomcat7
RUN mv /var/lib/tomcat7/webapps/ROOT /var/lib/tomcat7/webapps/TOMCAT
ADD ROOT.war /var/lib/tomcat7/webapps/ROOT.war
RUN apt-get install -y mysql-client

EXPOSE 8443
EXPOSE 8080
