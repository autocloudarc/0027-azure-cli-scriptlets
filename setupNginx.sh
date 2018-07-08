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


nginxRepo="/etc/yum.repos.d/nginx.repo"

# Add NGINX repo
function addNginxRepo ()
{
#Modify default repo
cat > "$nginxRepo" << EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1
EOF
}
# end function

## START
addNginxRepo
# Install NGINX
sudo yum install nginx
# Start NGINX service
sudo systemctl start nginx.service