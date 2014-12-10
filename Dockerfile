# Version 0.0.1

FROM ubuntu:latest

MAINTAINER "nmcspadden@gmail.com"

ADD jssinstaller.run /home/docker/jssinstaller.run
RUN apt-get update
RUN apt-get install -y openjdk-6-jdk
RUN ./home/docker/jssinstaller.run
