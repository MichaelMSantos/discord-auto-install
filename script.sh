#!/bin/sh

### Ensure script is run as root/sudo
if ! [ $(id -u) = 0 ]; then
    if [ "$1" ]; then
        echo "Error: root privileges required"
        exit 1
    fi
    sudo sh $0 "1"
    exit $?
fi

### Check if necessary tools are installed
if ! command -v wget > /dev/null; then
    echo "Error: wget is not installed. Please install it first."
    exit 1
fi

if ! command -v dpkg > /dev/null; then
    echo "Error: dpkg is not installed. Please install it first."
    exit 1
fi

### Download the Discord .deb package
echo "Downloading Discord installer..."
wget -O /tmp/discord-installer.deb "https://discordapp.com/api/download?platform=linux&format=deb"

### Install Discord package
echo "Installing Discord..."
dpkg -i /tmp/discord-installer.deb

### Fix missing dependencies (if any)
echo "Fixing dependencies..."
apt-get install -f -y

### Clean up the .deb file
rm -f /tmp/discord-installer.deb
