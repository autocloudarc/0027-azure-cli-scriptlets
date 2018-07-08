#!/bin/bash
<<HEADER
DESCRIPTION: This is a simple script that can be used to demonstrate using Azure Linux Custom Script extensions to install Powershell core and create a new directory, file and adding some content to the new file.
REQUIREMENTS: The test was written for the Ubuntu LTS 16.04 and CentOS 7 distributions.
ARGUMENTS: NA
OUTPUTS: \var\log\tmp\testFile, which will have the content "This is a test file used to demonstrate executing a very simple script using Azure Linux custom script extensions."
EXAMPLE: NA
SYNTAX:
az vm extension set \
  --resource-group <resource-group-name> \
  --vm-name <vm-name> \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --settings '{"fileUris": ["fileUri"],"commandToExecute": "bash installPwshPlusDirectoryAndFile.sh"}'
KEYWORDS: Azure, Custom, Script, Extension, Linux, Pwsh, PowerShell Core

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
1. https://docs.microsoft.com/en-us/azure/virtual-machines/linux/extensions-customscript
Install Windows PowerShell Core 6.0 on Linux
2. https://github.com/PowerShell/PowerShell/blob/master/docs/installation/linux.md
3. https://www.ostechnix.com/how-to-install-windows-powershell-in-linux/
4. https://blogs.technet.microsoft.com/heyscriptingguy/2016/09/28/part-1-install-bash-on-windows-10-omi-cim-server-and-dsc-for-linux/
5. https://blogs.technet.microsoft.com/heyscriptingguy/2016/10/05/part-2-install-net-core-and-powershell-on-linux-using-dsc/
6. https://blogs.msdn.microsoft.com/linuxonazure/2017/02/12/extensions-custom-script-for-linux/
7. https://azure.microsoft.com/en-us/blog/automate-linux-vm-customization-tasks-using-customscript-extension/
8. https://docs.microsoft.com/en-us/windows-server/administration/Linux-Package-Repository-for-Microsoft-Software
9. http://www.linuxcommand.org/man_pages/yum8.html
10.https://blogs.technet.microsoft.com/stefan_stranger/2017/01/12/installing-linux-packages-on-an-azure-vm-using-powershell-dsc/
11.https://msdn.microsoft.com/en-us/powershell/dsc/lnxfileresource
12.https://github.com/PowerShell/PowerShell/blob/master/docs/installation/linux.md
13.https://github.com/Azure/azure-linux-extensions/tree/master/CustomScript
14.https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-powershell-core-on-linux?view=powershell-6
HEADER

# INITIALIZE VALUES
targetDir="/var/log/tmp"
testFile="$targetDir/testFile"
testMessage="This is a test file used to demonstrate executing a very simple script using Azure Linux custom script extensions."
powershellRepPubKeyUri="https://packages.microsoft.com/keys/microsoft.asc"

# To check Linux distro, use:
linuxDistro=$(cat /etc/os-release | grep -i '^NAME=')

if echo "$linuxDistro" | grep -q -i "Ubuntu"; then
    # Install PowerShell Core 6.0
    # Add PowerShell repository public key
    curl "$powershellRepPubKeyUri" | apt-key add -
    # Register the Microsoft Ubuntu repository
    # task-item: Test new installation command below from r15 reference in header
    # curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list
    curl -o /etc/apt/sources.list.d/microsoft.list https://packages.microsoft.com/config/ubuntu/16.04/prod.list
    # Update software sources list
    apt-get update
    # Install PowerShell
    apt-get install -y powershell
elif echo "$linuxDistro" | grep -q -i "CentOS"; then
    # Install PowerShell Core 6.0
    # Add PowerShell repository
    curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

    # Install PowerShell
    yum install -y powershell
elif echo "$linuxDistro" | grep -q -i "openSUSE Leap"; then
    # Install PowerShell Core 6.0
    # Register the Microsoft signature key
    rpm --import "$powershellRepPubKeyUri"
    # Add the Microsoft Product feed
    curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/zypp/repos.d/microsoft.repo
    # Update the list of products
    zypper --non-interactive update
    # Install PowerShell
    zypper --non-interactive install powershell
    # sudo zypper remove powershell
fi

# MAIN
# Create new target directory if necessary
if [ ! -d "$targetDir" ]; then
    mkdir "$targetDir"
fi
touch $testFile
echo $testMessage > $testFile

# FOOTER
# To check for file and remove
# cat /var/log/tmp/testFile
# rm /var/log/tmp/testFile
