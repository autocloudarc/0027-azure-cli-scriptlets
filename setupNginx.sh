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
# 3. https://stackoverflow.com/questions/21984960/escaping-a-dollar-sign-in-unix-inside-the-cat-command


nginxRepo="/etc/yum.repos.d/nginx.repo"
rm $nginxRepo
# Add NGINX repo

function addNginxRepo ()
{
#Modify default repo
cat > "${nginxRepo}" << EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/\$basearch/
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
# Configure firewall ports. Note 22/tcp is enabled by default.
# Free up space taken by orphaned data from disabled or removed repos (-rf = recursive, force)
rm -rf /var/cache/yum/*
# yum -y install deltarpm
# Add NGINX repo
addNginxRepo

# Install NGINX
yum -y install nginx
Start NGINX service
systemctl start nginx.service
systemctl enable nginx.service

exit