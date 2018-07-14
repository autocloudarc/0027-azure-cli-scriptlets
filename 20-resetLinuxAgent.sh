#!/bin/bash
<<HEADER
SYNOPSIS:     Resets the Windows Azure Linux Agent to disable auto update, and sets the resource disk to disable swap files and specifies the default swap size as 0 MB.
DESCRIPTION:  This script is used to reset the /etc/waagent.conf file to it's original default values for testing and demonstration purposes, so that the desired settings of enabling auto updates
              and swap files be applied during the development and integration testing phases.
EXAMPLE:      bash .\20-resetLinuxAgent
ARGUMENTS:    None
OUTPUTS:      The waagent will reset autoupdate to disabled, and the swap file disabled to preclude using the resource disk as well as resetting the swap space to 0 MB.
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
1. https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/update-linux-agent
2. https://docs.microsoft.com/en-us/azure/virtual-machines/linux/optimization
HEADER

# Udpate Linux Agent (waagent) on CentOS 7
# Intialize varaibles
autoUpdateEnabled='AutoUpdate.Enabled=y'
resourceDiskEnableSwap="ResourceDisk.EnableSwap=y"
resourceDiskSwapSize="ResourceDisk.SwapSizeMB=4096"
waagentConf='/etc/waagent.conf'
# Install the latest package version
sudo yum -y install WALinuxAgent
# Set waagent to auto update
if [[ $(grep -q "$autoUpdateEnabled" $waagentConf) ]]
then
  sudo sed -i 's/AutoUpdate.Enabled=y/# AutoUpdate.Enabled=n/' /etc/waagent.conf
fi
# Enable resource disk swap
if [[ $(grep -q "$resourceDiskEnableSwap" $waagentConf) ]]
then
  sudo sed -i 's/ResourceDisk.EnableSwap=y/ResourceDisk.EnableSwap=n/' /etc/waagent.conf
fi
# Set resource disk swap size to 4096 MB
if [[ $(grep -q "$resourceDiskSwapSize" $waagentConf) ]]
then
  sudo sed -i 's/ResourceDisk.SwapSizeMB=4096/ResourceDisk.SwapSizeMB=0/' /etc/waagent.conf
fi

# Restart the waagent service
sudo systemctl restart waagent.service
# end of bash script
