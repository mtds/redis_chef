#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2014, GSI HPC Team
#
# All rights reserved - Do Not Redistribute
#

package "redis-server"

user node[:redis][:user] do
  home node[:redis][:datadir]
  system true
end

directory node[:redis][:datadir] do
  owner node[:redis][:user]
  mode "0750"
end

service "redis" do
  supports :reload => false, :restart => true, :start => true, :stop => true
  action [ :enable, :start ]
end

# Check/Set the overcommit of the virtual memory:
if node[:redis][:vm_overcommit] == 1
  execute "echo 1 > /proc/sys/vm/overcommit_memory" do
    not_if "[ $(cat /proc/sys/vm/overcommit_memory) -eq 1 ]"
    notifies :restart, resources(:service => "redis"), :delayed
  end
end

template "#{node[:redis][:config]}" do
  source "redis.conf.erb"
  mode "0644"
  notifies :restart, "service[redis]"
end
