# Version 0.0.7

FROM tutum/tomcat:7.0

MAINTAINER "nmcspadden@gmail.com"

RUN mv /var/lib/tomcat7/webapps/ROOT /var/lib/tomcat7/webapps/TOMCAT
ADD ROOT.war /var/lib/tomcat7/webapps/ROOT.war
ADD tomcatKeystore.sh /home/docker/jss/tomcatKeystore.sh
RUN bash /home/docker/jss/tomcatKeystore.sh
RUN mkdir -p /home/docker/jss/logs
RUN mkdir -p /Library/JSS/
RUN ln -s /home/docker/jss/logs /Library/JSS/Logs
RUN chown tomcat7:tomcat7 /home/docker/jss/logs
ADD server.xml /var/lib/tomcat7/conf/server.xml

EXPOSE 8443

