#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2014, GSI HPC Team
#
# All rights reserved - Do Not Redistribute
#

class Chef::Recipe
  include Sys::Secret
end

package "redis-server"

user node[:redis][:user] do
  home node[:redis][:datadir]
  system true
  shell "/bin/false"
end

directory node[:redis][:datadir] do
  owner node[:redis][:user]
  mode "0750"
end

service "redis-server" do
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

# Set the ulimit (-n) used by the redis init script:
if node[:redis][:ulimit]
   template "#{node[:redis][:ulimit_file]}" do
     source "debian_default.erb"
     mode "0644"
   end
end

if node[:redis][:requirepass].empty?
   # Redis password is generated as a random hex number:
   node.set[:redis][:requirepass] = SecureRandom.hex
end

# Holds the encrypted data for all nodes
node.default_unless[:redis][:secrets] = Hash.new

# Search for all nodes sharing the secret
search(:node,"name:lxmtin*").each do |n|
# encrypt the secret for each node using the public key
    node.normal[:redis][:secrets][n.fqdn] = encrypt(node[:redis][:requirepass],n.fqdn)
end

# Choose the template depending on the redis version available:
if node[:redis][:version].to_f > 2.4

 template "#{node[:redis][:config]}" do
   source "redis.conf.erb"
   mode "0644"
   notifies :restart, "service[redis-server]"
 end

else

  template "#{node[:redis][:config]}" do
    source "redis-2.4.conf.erb"
    mode "0644"
    notifies :restart, "service[redis-server]"
  end

end
