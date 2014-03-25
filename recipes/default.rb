#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2014, GSI HPC Team
#
# All rights reserved - Do Not Redistribute
#
package "redis"

user node[:redis][:user] do
  home node[:redis][:data_dir]
  system true
end

directory node[:redis][:config] do
  owner "root"
  group "root"
  mode "0755"
end

directory node[:redis][:db_dir] do
  owner node[:redis][:user]
  mode "0750"
end

service "redis" do
  supports :reload => false, :restart => true, :start => true, :stop => true
  action [ :enable, :start ]
end

template "#{node[:redis][:config]}" do
  source "redis.conf.erb"
  mode "0644"
  notifies :restart, "service[redis]"
end
