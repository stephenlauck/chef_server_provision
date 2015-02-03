#
# Cookbook Name:: provision
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# ~/chef-repo/cookbooks/web/recipes/servers.rb
require 'chef/provisioning/aws_driver'
with_driver 'aws'

# declare security groups
aws_security_group 'chefserver-ssh' do
  inbound_rules [{:ports => 22, :protocol => :tcp, :sources => ['0.0.0.0/0'] }]
end

aws_security_group 'chefserver-http' do
  inbound_rules [{:ports => 80, :protocol => :tcp, :sources => ['0.0.0.0/0'] }]
end

aws_security_group 'chefserver-https' do
  inbound_rules [{:ports => 443, :protocol => :tcp, :sources => ['0.0.0.0/0'] }]
end

# specify what's needed to create a machine
with_machine_options({
  :bootstrap_options => {
    :instance_type => 'm3.medium',
    :security_groups => ['chefserver-ssh','chefserver-https','chefserver-http']
  },
  :ssh_username => 'root',
  :image_id => 'ami-b6bdde86'
})

# declare a machine to act as our web server
machine 'chefserver-1' do
  recipe 'iptables'
  recipe 'chef_server::default'
  tag 'chefserver'
  converge true
end