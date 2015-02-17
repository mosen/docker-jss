jss-docker
==========

A Dockerfile for building a [JAMF Casper Software Suite](http://www.jamfsoftware.com/products/casper-suite/) container.  

Based on [the official Tomcat image, version 7.0.59-jre7](https://registry.hub.docker.com/_/tomcat/).

How To Use The Container:
-----
1.	You need to obtain these things on your own, due to EULA agreements.  This is why I cannot distribute this as a Docker image:
	1.	The JSS Manual Installer.  This can be found in your [JamfNation software assets](https://jamfnation.jamfsoftware.com/login.html) section, under "Alternate Downloads."  Unzip the manual installer and place the "ROOT.war" file in the same directory as the Dockerfile.
	2.	[JCE Unlimited Encryption](http://www.oracle.com/technetwork/java/javase/downloads/jce-7-download-432124.html) files.  Unzip these and place the "US_export_policy.jar" and "local_policy.jar" in the same directory as the Dockerfile.
	3.	Run a mysql data-only container to store the mysql db in permanently: 

		`docker run --name jss-data --entrypoint /bin/echo mysql Data-only container for mysql-jss`
	4.	Run a mysql database container for the JSS to use. Change "mysecretpassword" to something more useful, but leave the others alone: 

		`docker run --name mysql-jss -e MYSQL_ROOT_PASSWORD=mysecretpassword -e MYSQL_USER=jamfsoftware -e MYSQL_PASSWORD=jamfsw03 -e 
MYSQL_DATABASE=jamfsoftware -d --volumes-from mysql-jss mysql`

2.	Change the variables in the tomcatKeystore.sh script to match your own organization.  Use a useful password that isn't "changeit".
3.	Change server.xml to match the password ("changeit" by default) to what you set in the tomcatKeystore.sh script.
4.	Build the docker image from the directory of the Docker file:
	
	`docker build -t "nmcspadden/jss" .`
5.	Run the docker image:

	`docker run -d -p 8443:8443 --name "jss" --link mysql-jss:db nmcspadden/jss`
6.	Open a web browser on the Docker host and navigate to https://localhost:8443/.
7.	It will complain about not being able to access the mysql database.  Choose "Edit Connection" and change the connection settings.  Use "db" for the host and leave everything else the same.
8.	Accept the license agreement, enter in your activation code, set up your accounts and URLs, and you're good to go.