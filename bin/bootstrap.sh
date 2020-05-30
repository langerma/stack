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

# system upgrade
apt-get update
apt-get upgrade --purge
apt-get dist-upgrade --purge

# clear manual package selection
apt-mark auto $(apt-mark showmanual)

# install everything we need
apt-get install \
    docker.io \
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

# generate proper locale
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8

# disable systemd stub resolver
sed -i -e 's/.*DNSStubListener.*/DNSStubListener=no/g' /etc/systemd/resolved.conf
ln -nfs /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl restart systemd-resolved
systemctl restart systemd-networkd

# load wireguard modules
cat > /etc/modules-load.d/wireguard.conf <<EOF
wireguard
iptable_nat
ip6table_nat
EOF

# enable forwarding
cat > /etc/sysctl.d/wireguard.conf <<EOF
net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1
EOF

# use zsh
chsh -s /usr/bin/zsh root
