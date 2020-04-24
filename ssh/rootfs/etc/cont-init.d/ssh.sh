#!/usr/bin/with-contenv bash

fperms() {
    local file=$1
    local usgr=$2
    local mode=$3
    chown ${usgr} ${file}
    chmod ${mode} ${file}
}

mkperms() {
    local file=$1
    local usgr=$2
    local mode=$3
    mkdir -p ${file}
    fperms ${file} ${usgr} ${mode}
}

readonly SSH_BASE_PATH=/ssh
readonly SSH_HOST_ED25519_KEY=${SSH_BASE_PATH}/ssh_host_ed25519_key

mkperms ${SSH_BASE_PATH} root:root 0755

# generate host key
if [[ ! -f "${SSH_HOST_ED25519_KEY}" ]]; then
    ssh-keygen -t ed25519 -f "${SSH_HOST_ED25519_KEY}" -N ""
fi

fperms ${SSH_HOST_ED25519_KEY} root:root 0600
fperms ${SSH_HOST_ED25519_KEY}.pub root:root 0644

# add ssh keys
echo "${SSH_AUTHORIZED_KEYS}" > /ssh/ssh_authorized_keys
