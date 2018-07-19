# Create and persist SMB mounts to /etc/fstab while connected to each node [linux.user@hostname ~]$
# Initialize values
mount="pocmount"
share="pocshare"
storageAccountName="srmx3809"
fileServicesSuffix="file.core.windows.net"
fqdnFileServicesName="$storageAccountName.$fileServicesSuffix"
key1="b8hLKb+QVjmw4EfLQMmhXOUkjZYczRfk5pzBHMSOn341silWXBJQSurocEnZcRY+IpodAfviXrex26QZdcDTwQ=="
fstb="/etc/fstab"
sudo mkdir -p /mnt/$mount
# Mount the SMB share
sudo mount -t cifs //$fqdnFileServicesName/$share /mnt/$mount -o vers=3.0,username=$storageAccountName,password=$key1,dir_mode=0777,file_mode=0777
# Persist SMB mount through reboots by appending the /etc/fstab file
#[linux.user@<hostname> ~]$ sudo nano $fstb
# //srmx3809.file.core.windows.net/pocshare     /mnt/pocmount   cifs    vers=3.0,username=srmx3809,password=b8hLKb+QVjmw4EfLQMmhXOUkjZYczRfk5pzBHMSOn341silWXBJQSurocEnZcRY+IpodAfviXrex26QZdcDTwQ==,dir_mode=0777,file_mode=0777
# ^X, [y], [enter]
# Show and test new mount point:
# [linux.user@<hostname> ~]$ sudo mount --show-labels | grep $share
# [linux.user@<hostname> ~]$ ls -al /mnt/pocmount