FROM ubuntu:20.04

RUN export TERM=dumb DEBIAN_FRONTEND=noninteractive \
    && echo "APT::Install-Suggests "0";\nAPT::Install-Recommends "0";\n" \
    | tee /etc/apt/apt.conf.d/99no-recommended \
    && apt-get -y update \
    && apt-get -y install apt-utils \
    && yes | unminimize \
    && apt-get -y dist-upgrade

RUN export TERM=dumb DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install \
    android-sdk-platform-tools \
    apache2-utils \
    apt-transport-https \
    automake \
    bash \
    build-essential \
    ca-certificates \
    colordiff \
    ctags \
    curl \
    docker-compose \
    docker.io \
    ethtool \
    gawk \
    git \
    glances \
    gnupg \
    hddtemp \
    htop \
    httpie \
    ipcalc \
    iputils-tracepath \
    jq \
    libbz2-dev \
    libffi-dev \
    libgdbm-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libstdc++6 \
    libtool \
    libxslt1-dev \
    libyaml-dev \
    lm-sensors \
    locales \
    manpages \
    moreutils \
    mtr-tiny \
    net-tools \
    ncdu \
    nmap \
    openssh-server \
    openssl \
    p7zip \
    patch \
    pigz \
    pkg-config \
    pwgen \
    software-properties-common \
    tar \
    tcpdump \
    telnet \
    ubuntu-minimal \
    ubuntu-standard \
    unrar \
    unzip \
    vim \
    xz-utils \
    zlib1g-dev \
    zsh \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8

RUN export TERM=dumb DEBIAN_FRONTEND=noninteractive \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/ssh/ssh_host_*_key*

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-amd64.tar.gz /tmp/s6-overlay-amd64.tar.gz
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
