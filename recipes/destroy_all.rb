require 'chef/provisioning/aws_driver'
with_driver 'aws'

machine_batch do
  machines search(:node, '*:*').map { |n| n.name }
  action :destroy
end
