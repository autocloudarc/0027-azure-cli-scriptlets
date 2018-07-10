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
# 4. https://www.cyberciti.biz/tips/find-out-if-file-exists-with-conditional-expressions.html


nginxRepo="/etc/yum.repos.d/nginx.repo"
nginxSbin="/usr/sbin/nginx"
nginxIndex="/usr/share/nginx/html/index.html"

# Add NGINX repo
function addNginxRepo ()
{
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
# Free up space taken by orphaned data from disabled or removed repos (-rf = recursive, force)
rm -rf /var/cache/yum/*

# Uninstall NGNIX if arleady installd
if [ -e "$nginxSbin" ]; then
    # Install NGINX
    # Start NGINX
    systemctl stop nginx.service
    yum -y erase nginx
fi

# Add NGINX repo if it doesn't already exist, then and install and configure NGINX
if [ -e "$nginxRepo" ]; then
    rm $nginxRepo
fi

exit