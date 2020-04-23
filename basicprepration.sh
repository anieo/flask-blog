#!/bin/bash
# Appropriate values should be plugged in here
export WHITELIST_IPADDR=0.0.0.0


# Lock down the firewall immediately
# - Block all incoming connections, even ssh
# - Allow all incoming from our specified IP
#   SSH is only going to function from this allowed IP
# - Allow incoming connections on web ports
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --zone=public --add-service=http
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --add-service=https
firewall-cmd --zone=public --add-service=https --permanent
firewall-cmd --zone=trusted --add-source=${WHITELIST_IPADDR}
firewall-cmd --zone=trusted --add-source=${WHITELIST_IPADDR} --permanent
firewall-cmd --zone=public --remove-service=ssh
firewall-cmd --zone=public --remove-service=ssh --permanent


# Update system, install LAMP packages
yum -y update
yum -y install epel-release
yum -y install \
    httpd \
    psacct
yum clean all


# SSH Hardening
sed -i 's/^#?PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^#?AllowTcpForwarding yes/AllowTcpForwarding no/' /etc/ssh/sshd_config
sed -i 's/^#?ClientActiveCountMax 3/ClientActiveCountMax 2/' /etc/ssh/sshd_config
sed -i 's/^#?Compression DELAYED/Compression no/' /etc/ssh/sshd_config
sed -i 's/^#?LogLevel INFO/LogLevel VERBOSE/' /etc/ssh/sshd_config
sed -i 's/^#?MaxAuthTries 6/MaxAuthTries 1/' /etc/ssh/sshd_config
sed -i 's/^#?MaxSessions 10/MaxSessions 2/' /etc/ssh/sshd_config
sed -i 's/^#?TCPKeepAlive yes/TCPKeepAlive no/' /etc/ssh/sshd_config
sed -i 's/^#?UseDNS yes/UseDNS no/' /etc/ssh/sshd_config
sed -i 's/^#?X11Forwarding yes/X11Forwarding no/' /etc/ssh/sshd_config
sed -i 's/^#?AllowAgentForwarding yes/AllowAgentForwarding no/' /etc/ssh/sshd_config
