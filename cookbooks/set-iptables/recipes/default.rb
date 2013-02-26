include_recipe "simple_iptables"

# Reject packets other than those explicitly allowed
simple_iptables_policy "INPUT" do
  policy "DROP"
end

# The following rules define a "system" chain; chains
# are used as a convenient way of grouping rules together,
# for logical organization.

# Allow all traffic on the loopback device
simple_iptables_rule "system:loopback" do
  rule "--in-interface lo"
  jump "ACCEPT"
end

# Allow any established connections to continue, even
# if they would be in violation of other rules.
simple_iptables_rule "system:established" do
  rule "-m conntrack --ctstate ESTABLISHED,RELATED"
  jump "ACCEPT"
end

if node['set-iptables']['open_port']['ssh']
  # Allow SSH
  simple_iptables_rule "ssh" do
    rule "--proto tcp --dport 22"
    jump "ACCEPT"
  end
end

if node['set-iptables']['open_port']['http']
  # Allow HTTP
  simple_iptables_rule "http" do
    rule "--proto tcp --dport 80"
    jump "ACCEPT"
  end
end

if node['set-iptables']['open_port']['https']
  # Allow HTTPS
  simple_iptables_rule "https" do
    rule "--proto tcp --dport 443"
    jump "ACCEPT"
  end
end

if node['set-iptables']['open_port']['redis']
  # Allow Redis
  simple_iptables_rule "redis" do
    rule "--proto tcp --dport 6379"
    jump "ACCEPT"
  end
end

if node['set-iptables']['open_port']['mysql']
  # Allow MySQL
  simple_iptables_rule "mysql" do
    rule "--proto tcp --dport 3306"
    jump "ACCEPT"
  end
end