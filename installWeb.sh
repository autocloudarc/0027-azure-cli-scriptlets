#!/bin/bash
<<HEADER
SYNOPSIS:     Installs the NGINX service on a CentOS 7 server
DESCRIPTION:  This shell script install a basic NGINX server on a CentOS 7 machine with the default web page.
EXAMPLE:      bash .\installWeb.sh
ARGUMENTS:    None
OUTPUTS:      The NGIX service will be available with the default web page, customized with the $HOSTNAME
REQUIREMENTS: See references.
AUTHOR:       Preston K. Parsard
LICENSE:

MIT License
Copyright (c) 2018 Preston K. Parsard

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the SoftwSare is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
S
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

LEGAL DISCLAIMER:
This Sample Code is provided for the purpose of illustration only and is not intended to be used in a production environment.�
THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.�
We grant You a nonexclusive, royalty-free right to use and modify the Sample Code and to reproduce and distribute the object code form of the Sample Code, provided that You agree:
(i) to not use Our name, logo, or trademarks to market Your software product in which the Sample Code is embedded;
(ii) to include a valid copyright notice on Your software product in which the Sample Code is embedded; and
(iii) to indemnify, hold harmless, and defend Us and Our suppliers from and against any claims or lawsuits, including attorneys� fees, that arise or result from the use or distribution of the Sample Code.
This posting is provided "AS IS" with no warranties, and confers no rights.
REFERENCES:
1. http://nginx.org/en/linux_packages.html
2. https://www.attosol.com/installing-load-balancing-nginx-on-centos-7-in-azure/
3. https://stackoverflow.com/questions/21984960/escaping-a-dollar-sign-in-unix-inside-the-cat-command
4. https://www.cyberciti.biz/tips/find-out-if-file-exists-with-conditional-expressions.html
5. https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php
HEADER

# ---copy start---

nginxRepo="/etc/yum.repos.d/nginx.repo"
nginxConf="/etc/nginx/nginx.conf"
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
} # end function

function cleanAndUpdate ()
{
    # Clear yum packages and headers
    yum -y clean all
    # Free up space taken by orphaned data from disabled or removed repos (-rf = recursive, force)
    rm -rf /var/cache/yum/*
    # Download and install any updates
    yum -y update
} #end function

# Install NGNIX if not arleady installed
function installAndConfigureWebService ()
{
    yum -y install nginx
    # Add hostname
    sed -i "s/Welcome to nginx/Welcome to nginx on $HOSTNAME/" $nginxIndex
    # Enable NGIX for persistent start on boot
    systemctl enable nginx.service
    # Start NGINX
    systemctl start nginx.service
} #end function

## MAIN

# Add NGINX repo if it doesn't already exist
if [ ! -e "$nginxRepo" ]
then
    addNginxRepo
fi

# Clean packages, headers, recover space and download + install any updates
cleanAndUpdate

# Install and configure static web site
if [ ! -e "$nginxConf" ]
then
    installAndConfigureWebService
fi

# ---copy end---

# End of scriptlet
exit