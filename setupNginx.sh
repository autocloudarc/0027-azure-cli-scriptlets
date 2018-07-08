#!/bin/bash
# SYNOPSIS:     Installs the NGINX service on a CentOS 7 server
# DESCRIPTION:  This shell script install a basic NGINX server on a CentOS 7 machine with the default web page.
# EXAMPLE:      bash 13-setupNginx.sh
# ARGUMENTS:    None
# OUTPUTS:      The NGIX service will be available with the default web page.
# REQUIREMENTS: See references.
# AUTHOR:       Preston K. Parsard
# REFERENCES:
# 1. http://nginx.org/en/linux_packages.html
# 2. https://www.attosol.com/installing-load-balancing-nginx-on-centos-7-in-azure/


# nginxRepo="/etc/yum.repos.d/nginx.repo"
# rm $nginxRepo
# Add NGINX repo

function addNginxRepo ()
{
#Modify default repo
cat > "${nginxRepo}" << EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1
EOF

}
# end function

## START

# Clear yum metadata
yum -y clean all
# Update packages
yum -y update
# Install httpd
yum -y install httpd
# Configure firewall ports. Note 22/tcp is enabled by default.
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --reload
# Free up space taken by orphaned data from disabled or removed repos (-rf = recursive, force)
rm -rf /var/cache/yum/*
yum -y install deltarpm
# yum-config-manager --save --setopt=nginx.skip_if_unavailable=true
# Add NGINX repo
# addNginxRepo

# Install NGINX
# yum -y install nginx
# Start NGINX service
# systemctl start nginx.service
# start Apache daemon
systemctl start httpd
# Ensure Apache starts on boot
systemctl enable httpd


exit