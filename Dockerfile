# Version 0.0.7

FROM tutum/tomcat:7.0

MAINTAINER "nmcspadden@gmail.com"

RUN mv /tomcat/webapps/ROOT /tomcat/webapps/OLD_ROOT
ADD ROOT.war /tomcat/webapps/ROOT.war
ADD tomcatKeystore.sh /home/docker/jss/tomcatKeystore.sh
RUN bash /home/docker/jss/tomcatKeystore.sh
RUN mkdir -p /home/docker/jss/logs
RUN mkdir -p /Library/JSS/
RUN ln -s /home/docker/jss/logs /Library/JSS/Logs
ADD server.xml /tomcat/conf/server.xml
RUN mv /usr/lib/jvm/java-7-oracle/jre/lib/security/US_export_policy.jar /usr/lib/jvm/java-7-oracle/jre/lib/security/US_export_policy.ORIG.jar
RUN mv /usr/lib/jvm/java-7-oracle/jre/lib/security/local_policy.jar /usr/lib/jvm/java-7-oracle/jre/lib/security/local_policy.ORIG.jar
ADD US_export_policy.jar /usr/lib/jvm/java-7-oracle/jre/lib/security/US_export_policy.jar
ADD local_policy.jar /usr/lib/jvm/java-7-oracle/jre/lib/security/local_policy.jar

EXPOSE 8443

