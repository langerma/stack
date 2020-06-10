FROM ubuntu:20.04

RUN export TERM=dumb DEBIAN_FRONTEND=noninteractive \
    && echo "APT::Install-Suggests "0";\nAPT::Install-Recommends "0";\n" \
    | tee /etc/apt/apt.conf.d/99no-recommended \
    && apt-get -y update \
    && apt-get -y install apt-utils \
    && yes | unminimize \
    && apt-get -y dist-upgrade

RUN export TERM=dumb DEBIAN_FRONTEND=noninteractive \
    && apt-mark auto $(apt-mark showmanual) \
    && apt-get -y install \
    android-sdk-platform-tools \
    apache2-utils \
    automake \
    build-essential \
    colordiff \
    docker.io \
    docker-compose \
    hddtemp \
    httpie \
    iotop \
    ipcalc \
    jq \
    ldnsutils \
    libbz2-dev \
    libffi-dev \
    libgdbm-dev \
    libncurses-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libstdc++6 \
    libtool \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    lm-sensors \
    moreutils \
    ncdu \
    net-tools \
    nmap \
    openssh-server \
    openssh-sftp-server \
    pkg-config \
    powertop \
    pwgen \
    ubuntu-minimal \
    ubuntu-server \
    ubuntu-standard \
    unrar \
    unzip \
    wireguard \
    zlib1g-dev \
    zsh \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8

RUN export TERM=dumb DEBIAN_FRONTEND=noninteractive \
    && apt-get -y autoremove --purge \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/ssh/ssh_host_*_key*

ADD https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-amd64.tar.gz \
    /tmp/s6-overlay-amd64.tar.gz

RUN export TERM=dumb DEBIAN_FRONTEND=noninteractive \
    && tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude="./bin" \
    && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin \
    && rm -f /tmp/s6-overlay-amd64.tar.gz

RUN echo root:$(openssl rand -base64 32) | chpasswd \
    && chsh -s /usr/bin/zsh root \
    && mkdir -p /ssh /run/sshd

COPY rootfs /

CMD ["/usr/sbin/sshd", "-D", "-e", "-o", "PidFile=none"]

ENTRYPOINT ["/init"]
