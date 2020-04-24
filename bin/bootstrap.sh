#!/bin/bash

set -e
set -u
set -o pipefail
set -x

apt-get() {
    (
        export TERM=dumb
        export DEBIAN_FRONTEND=noninteractive
        command apt-get --yes "$@"
    )
}

sc-disable() {
    for service in "$@"; do
        systemctl disable "${service}"
        systemctl stop "${service}"
    done
}

# disable services
sc-disable \
    atd \
    unattended-upgrades

# make our system lean
cat > /etc/apt/apt.conf.d/99no-recommended <<EOF
APT::Install-Suggests "0";
APT::Install-Recommends "0";
EOF

# system upgrade
apt-get update
apt-get upgrade --purge
apt-get dist-upgrade --purge

# clear manual package selection
apt-mark auto $(apt-mark showmanual)

# install everything we need
apt-get install \
    docker-compose \
    hddtemp \
    iotop \
    lm-sensors \
    ncdu \
    net-tools \
    nmap \
    openssh-server \
    powertop \
    python3-pip \
    ubuntu-minimal \
    ubuntu-server \
    ubuntu-standard \
    wireguard \
    zsh

# cleanup
apt-get autoremove --purge
apt-get clean

rm -rfv \
    /root/snap
    /var/lib/command-not-found \
    /var/log/unattended-upgrades

# generate proper locale
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8

# disable systemd stub resolver
sed -i -e 's/.*DNSStubListener.*/DNSStubListener=no/g' /etc/systemd/resolved.conf
ln -nfs /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl restart systemd-resolved
systemctl restart systemd-networkd

# silent login
eval USER_HOME="~$SUDO_USER"
touch ${USER_HOME}/.hushlogin

# automatic sudo login
sed -i -e 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/g' /etc/sudoers
echo 'exec sudo -Hi' > ${USER_HOME}/.bash_login

# use zsh
chsh -s /usr/bin/zsh root
