# Version 0.0.3

FROM ubuntu:latest

MAINTAINER "nmcspadden@gmail.com"

ADD jssinstaller.run /home/docker/jssinstaller.run
ADD expectInstaller /home/docker/expectInstaller
RUN apt-get update
RUN apt-get install -y openjdk-6-jdk
RUN apt-get install -y expect
RUN /home/docker/expectInstaller
RUN mkdir -p /home/docker/jss/logs
RUN mkdir -p /Library/JSS/
RUN ln -s /home/docker/jss/logs /Library/JSS/Logs
RUN chown tomcat7:tomcat7 /home/docker/jss/logs

EXPOSE 8443
