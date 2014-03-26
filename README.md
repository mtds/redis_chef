Description
===========

This is a very basic Redis cookbook. It just provide a 
default recipe to install a basic Redis server instance,
with a certain amount of customizable attributes.

** Note **: 
Redis versions up to 2.4 will use a different template
for the configuration file, due to the fact that starting
from the 2.6.x branch there are more options available
and none of them is back compatible with older versions.

Requirements
============

No specific requirements/dependencies.

This cookbook was tested only on Debian Squeeze/Wheezy.
Deployment on Ubuntu may fail due to the use of Upstart.

Attributes
==========

Some of the most important attributes are:

* `node[:redis][:user]`: the default user used to launch the Redis instance.
* `node[:redis][:confg]`: configuration file.
* `node[:redis][:port]`: default TCP port.
* `node[:redis][:bind]`: IP address to bind to.
* `node[:redis][:vm_overcommit]`: Enable the overcommit of the Virtual Memory by the kernel.

A complete list of all the available attributes
can be found under attributes/default.rb, while
you have to look at the heavily commented redis.conf.erb
template to look for a complete explanation.

** Max clients connections **:
When Redis start to spew error messages like:
Accepting client connection: accept: Too many open files
then you'll have to increase the node[:redis][:maxclients]
attribute.

Info available at:
http://redis.io/topics/clients

For Redis 2.4 it can still be necessary to use change the
ulimit settings. Look at the node[:redis][:ulimit*] attributes.

Usage
=====

On systems which needs a Redis instance just add the following
line to their run list: `recipe[redis]`.

Redis replication
=================

Redis master-slave replication is not enabled by default: 
to turn it on or off you just need to use the [:redis][:slaveof]
attribute, specifying the IP address and the TCP port of
the master (and optionally a password).

More info on:
http://redis.io/topics/replication

Redis Sentinel
==============

Sentinel is a system designed to help managing Redis instances. 
It can basically perform the following tasks:

* Monitoring master and slave nodes.
* Notification.
* Automatic failover.
* Configuration provider.

This cookbook is shipping a default sentinel.conf file in the 
template section but without any customizable parameters. 
The redis-sentinel binary became part of the Redis distribution
starting from the 2.8 branch. Since this cookbook was used
to configure earlier versions of Redis this functionality is
not provided.

More info on:
http://redis.io/topics/sentinel

Redis Cluster
=============

Clustering functionality is not available with this cookbook.
Redis cluster is still a work in progress and is available
on the *unstable* branch of the official GIT repository:

 https://github.com/antirez/redis

More info on:
http://redis.io/topics/cluster-tutorial
http://redis.io/topics/cluster-spec
https://github.com/antirez/redis-rb-cluster

