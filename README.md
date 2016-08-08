docker-jss-confd
================

A Dockerfile for building a [JAMF Casper Software Suite](http://www.jamfsoftware.com/products/casper-suite/) container.
Additional configuration provided via [confd](https://github.com/kelseyhightower/confd).

Based on [the official Tomcat image, version 7.0.59-jre7](https://registry.hub.docker.com/_/tomcat/).

Based upon Nick McSpaddens original docker-jss repository.

How To Use The Container:
-----
1.	You need to obtain these things on your own, due to EULA agreements.  This is why I cannot distribute this as a Docker image:
	1.	The JSS Manual Installer.  This can be found in your [JamfNation software assets](https://jamfnation.jamfsoftware.com/login.html) section, under "Alternate Downloads."  Unzip the manual installer and place the "ROOT.war" file in the same directory as the Dockerfile.
	2.	[JCE Unlimited Encryption](http://www.oracle.com/technetwork/java/javase/downloads/jce-7-download-432124.html) files.  Unzip these and place the "US_export_policy.jar" and "local_policy.jar" in the same directory as the Dockerfile.

2.  To run the JSS and MySQL containers via `docker-compose`, you can simply run `docker-compose up` in this directory. If you have a different system for orchestrating your containers you can use that.
3.	Open a web browser on the Docker host and navigate to https://localhost:8443/.
4.	Accept the license agreement, enter in your activation code, set up your accounts and URLs, and you're good to go.

Confd Variables
---------------

## Database Configuration ##

The configuration variables displayed are the environment variables, but could just as easily be
sourced from etcd or consul.

- JSS_DB_HOST=<hostname, normally db if you have a link to a "db" container.
- JSS_DB_PORT=3306
- JSS_DB_NAME=<database name>
- JSS_DB_USERNAME=<mysql user name>
- JSS_DB_PASSWORD=<mysql password>

