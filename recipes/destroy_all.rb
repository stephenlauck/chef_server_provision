require 'chef/provisioning/aws_driver'
with_driver 'aws'

machine_batch do
  machines search(:node, '*:*').map { |n| n.name }
  action :destroy
end

aws_security_group 'chefserver-ssh' do
  action :delete
end

aws_security_group 'chefserver-http' do
  action :delete
end

aws_security_group 'chefserver-https' do
  action :delete
end