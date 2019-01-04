#!/bin/bash
########Install Chrome################
dnf install -y fedora-workstation-repositories
dnf config-manager --set-enabled google-chrome
cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF
dnf install -y google-chrome-stable
#######Set Timezone############
sudo timedatectl set-timezone "Asia/Kolkata"
#######Install Sublime#########
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf install sublime-text
