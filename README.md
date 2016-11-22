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
	2.	[JCE Unlimited Encryption for JRE7](http://www.oracle.com/technetwork/java/javase/downloads/jce-7-download-432124.html) files.  Unzip these and place the "US_export_policy.jar" and "local_policy.jar" in the same directory as the Dockerfile.
        or [JCE Unlimited Encryption for JRE8](http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html)

2.  To run the JSS and MySQL containers via `docker-compose`, you can simply run `docker-compose up` in this directory. If you have a different system for orchestrating your containers you can use that.
3.	Open a web browser on the Docker host and navigate to https://localhost:8443/.
4.	Accept the license agreement, enter in your activation code, set up your accounts and URLs, and you're good to go.

docker-compose files
--------------------

There are several docker-compose files in the repository available other
than the default to test out different configuration scenarios:

## (Default) `docker-compose.yml` ##
 
A basic JSS MySQL setup, adopted from Nick McSpadden's original idea.

I've added confd to generate the database configuration on startup instead of using the UI to type that in.

## `docker-compose-logging.yml` ##

This compose file extends the default by adding the ELK stack.

It showcases how to use the log4j socket appender for JSS logs.
You can connect to the kibana instance at http://localhost:5601.
The default index pattern of `logstash-*` has been used.

## `docker-compose-cluster.yml` ## 

This compose file extends the logging setup by adding a second JSS as a slave,
and a HAProxy load balancer. 

The master/slave cluster configuration is not handled for you.


## `docker-compose-kitchensink.yml` ##

This compose file is used to add all of the previous features and
incorporate even more containers. It is presently a dumping ground for
all kinds of integration.

Confd Variables
---------------

## Database Configuration ##

The configuration variables displayed are the environment variables, but could just as easily be
sourced from etcd or consul.

```
JSS_DB_HOST=<hostname, normally db if you have a link to a "db" container.
JSS_DB_PORT=3306
JSS_DB_NAME=<database name>
JSS_DB_USERNAME=<mysql user name>
JSS_DB_PASSWORD=<mysql password>
```

## Optional Configuration ##

```
CONFD_BACKEND=env # see confd docs for alternative backends
JSS_CACHE_TYPE=(memcached or ehcache)
JSS_MEMCACHED_SERVERS_0=memcached:11211 # first memcached server (index 0)
JSS_MEMCACHED_TTL=120
JSS_LOG4J_HOST=logshipper # hostname of logstash forwarder running the log4j socket input
JSS_LOG4J_PORT=4560

SELF_SIGNED=1 or SELF_SIGNED=0 (if using your own certs)
TLS_CERT=<path to public certificate>
TLS_KEY=<path to private key>
CA_CERT=<path to certificate authority certificate>
```
