Description
===========

This is a very basic Redis cookbook. It just provide a 
default recipe to install a basic Redis server instance,
with a certain amount of customizable default attributes.

Redis master-slave replication is not enables as a
configuration option by default: to turn it on or off
Redis slave nodes just need to know the IP address of
the master (and optionally a password).


Requirements
============

No specific requirements/dependencies.


Attributes
==========

Some of the most important attributes are:

* `node[:redis][:user]`: the default user used to launch the Redis instance
* `node[:redis][:conf_dir]`: config dir
* `node[:redis][:port]`: default TCP port
* `node[:redis][:bind_address]`: IP address to bind to.
* `node[:redis][:vm_enabled]`: Enable the use of Virtual Memory by Redis

A complete list of all the available attributes
can be found under attributes/default.rb.


Usage
=====

On systems which needs a Redis instance just add to their run
list: `recipe[redis]`.

