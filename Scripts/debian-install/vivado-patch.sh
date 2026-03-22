#!/bin/sh

# Script for patching for vivado to run on Debian
# run this with sudo!

ln -s /usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/crt1.o
ln -s /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/crti.o
ln -s /usr/lib/x86_64-linux-gnu/crtn.o /usr/lib/crtn.o

cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb http://deb.debian.org/debian/ bookworm main 
deb-src http://deb.debian.org/debian/ bookworm main" >> /etc/apt/sources.list

echo "APT::Default-Release stable;" > /etc/apt/apt.conf.d/99bookworm
sudo nala update && sudo nala install -t bookworm libncurses5
