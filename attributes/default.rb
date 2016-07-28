#
# NOTE: explanations about all the attributes will be found
#       inside the template config file for the Redis server
#       (redis.conf.erb).
#
# Most of the values defined for these options are taken
# directly from the main configuration file of a production
# Redis server.
#

# Used only by the Chef recipe:
default['redis']['user']      =   'redis'
default['redis']['version']   =   2.4 # Default version of Redis on Wheezy.

# Configure ulimit:
default['redis']['ulimit']       =  false
default['redis']['ulimit_arg']   =  2048
default['redis']['ulimit_file']  =  '/etc/default/redis-server'

#
# Redis specific attributes:
#
default['redis']['config']    =   '/etc/redis/redis.conf'
default['redis']['pidfile']   =   '/var/run/redis/redis-server.pid'
default['redis']['port']      =   6379
default['redis']['bind']      =   false
default['redis']['unixsocket'] = false
default['redis']['unixsocketperm'] = false
default['redis']['timeout']   =   300
default['redis']['loglevel']  =   'notice'
default['redis']['logfile']   =   '/var/log/redis/redis.log'
default['redis']['syslog_enabled']  =  false
default['redis']['syslog_ident']    = 'redis'
default['redis']['syslog_facility'] = 'local0'
default['redis']['databases'] =  16
default['redis']['save_to_disk'] = {
  900 => 1,
  300 => 10,
  60  => 100_00
}
default['redis']['rdbcompression'] = 'yes'
default['redis']['dbfilename'] = 'redis_dump.rdb'
default['redis']['datadir'] = '/var/lib/redis'
default['redis']['slaveof'] = false
default['redis']['masterauth'] = false
default['redis']['slave_serve_stale_data'] = 'yes'
default['redis']['repl_ping_slave_period'] = 10
default['redis']['repl_timeout'] = 60
default['redis']['srvpasswd'] = ''
default['redis']['rename_command'] = false
default['redis']['maxclients'] = 1024
default['redis']['appendonly'] = 'no'
default['redis']['appendfsync'] = 'everysec'
default['redis']['tcp_keepalive'] = 60
#
# Redis VirtualMemory overcommit:
# (refer to: http://redis.io/topics/faq)
# This setting will change:
# /proc/sys/vm/overcommit_memory
# of the Linux kernel.
default['redis']['vm_overcommit'] = 0
