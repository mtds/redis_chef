#
# NOTE: explanations about all the attributes will be found
#       inside the template config file for the Redis server
#       (redis.conf.erb).
#
# Most of the values defined for these options are taken
# directly from the main configuration file of a production
# Redis server. 
#

default[:redis][:config]    =   "/etc/redis.conf"
default[:redis][:pidfile]   =   "/var/run/redis.pid"
default[:redis][:port]      =   6379
default[:redis][:bind]      =   false
default[:redis][:unixsocket] = false
default[:redis][:unixsocketperm] = false
default[:redis][:timeout]   =   300
default[:redis][:loglevel]  =   "notice"
default[:redis][:logfile]   =   "/var/log/redis.log"
default[:redis][:syslog_enabled] =  false
default[:redis][:syslog_ident]   =  "redis"
default[:redis][:syslog_facility] = "local0"
default[:redis][:databases] =  16
 default[:redis][:save_to_disk] = {
   900 => 1,
   300 => 10,
   60  => 10000
}
default[:redis][:dbfilename] = "redis_dump.rdb"
default[:redis][:datadir] = "/var/db/redis"
default[:redis][:slaveof] = false
default[:redis][:masterauth] = false
default[:redis][:slave_serve_stale_data] = "yes"
default[:redis][:repl_ping_slave_period] = 10
default[:redis][:repl_timeout] = 60
default[:redis][:requirepass] = false
default[:redis][:rename_command] = false
default[:redis][:appendonly] = "no"
default[:redis][:appendfsync] = "everysec"
