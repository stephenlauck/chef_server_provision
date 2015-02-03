# include_recipe 'iptables'

# iptables_rule "http"
# iptables_rule "https"

service 'iptables' do
  action :stop
end