#!/bin/bash
<<HEADER
DESCRIPTION: This is a simple script that can be used to demonstrate creating a new directory, file and adding some content to the new file.
REQUIREMENTS: NA
ARGUMENTS: NA
OUTPUTS: \var\log\tmp\testFile, which will have the content "This is a test file used to demonstrate executing a very simple script using Azure Linux custom script extensions."
EXAMPLE: NA
SYNTAX: .\21-createDirectoryAndFileWithContent.sh
KEYWORDS: Azure, Linux, File, Directory

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

HEADER

# INITIALIZE VALUES
targetDir="/var/log/tmp"
testFile="$targetDir/testFile"
testMessage="This is a test file used to demonstrate executing a very simple script to demonstrate file backup and recovery using the recovery services vault resource."

# MAIN
# Create new target directory if necessary
if [ ! -d "$targetDir" ]; then
    sudo mkdir "$targetDir"
fi
sudo touch $testFile
echo $testMessage > $testFile

# FOOTER
# To check for file and remove
find $testFile
cat $testFile
# Uncomment below to remove testFile
# rm /var/log/tmp/testFile