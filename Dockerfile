# Version 0.0.6

FROM ubuntu:latest

MAINTAINER "nmcspadden@gmail.com"

RUN apt-get -o Acquire::http::Proxy=http://_insert_apt_cache_IP:3142 update
RUN apt-get -o Acquire::http::Proxy=http://_insert_apt_cache_IP:3142 install -y openjdk-7-jdk
RUN apt-get -o Acquire::http::Proxy=http://_insert_apt_cache_IP:3142 install tomcat7
RUN mv /var/lib/tomcat7/webapps/ROOT /var/lib/tomcat7/webapps/TOMCAT
ADD ROOT.war /var/lib/tomcat7/webapps/ROOT.war

EXPOSE 8443
EXPOSE 8080
