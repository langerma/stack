# Wolkenlos Stack

## Installation

You need a fresh installation of Ubuntu 20.04.

Now (as root) clone this repository and run the bootstrap script:

    git clone https://github.com/wolkenlos-io/stack /stack
    bash /stack/bin/bootstrap.sh

Create a stack configuration and start the admin ssh container:

    cd /stack
    pip3 install -r requirements.txt
    cp config.yaml.dist config.yaml
    $EDITOR config.yaml # add ssh keys etc
    bin/stack up -d ssh

You can now login to the admin container:

    ssh root@<host-ip> -p 22222
