From debian:buster-slim

# If you want to install "debian:bullseye-slim" on the Raspberry Pi, you need first to install libseccomp2 from debian buster backports on your host.
#From debian:bullseye-slim


ARG UID=1000
ARG GID=1000

ENV GROUPID=$GID
ENV USERID=$UID

ENV TERM=screen-256color

ENV USER=pi
ENV HOME=/home/$USER

RUN set -xe \
  && cd / \
  && sed -i "s/ main/ main non-free/g" /etc/apt/sources.list \
  && apt-get update && apt-get dist-upgrade -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo gnupg2 dirmngr apt-transport-https apt-utils \
  && groupadd --gid ${GROUPID} ${USER} \
  && useradd --uid ${USERID} --gid ${GROUPID} --create-home --shell /bin/bash $USER \
  && echo 'export PATH="$PATH:$HOME/bin"' >> $HOME/.bashrc \
  && echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
  && chown -R $USER:$USER $HOME \
  && apt update \
  && apt dist-upgrade \
  && DEBIAN_FRONTEND=noninteractive apt install -y  \
      tzdata \
      apt-transport-https \
      apt-utils \
      mc joe nano less \
      curl \
      wget \
      git \
      psmisc \
      procps \
      supervisor \
      alsa-utils \
      zip \
      unzip \
      mpg123 \
      dirmngr \
      gcc \
      make \
      pkg-config \
      automake \
      libtool \
      libicu-dev \
      libpcre2-dev \
      libasound2-dev \
      portaudio19-dev \
      mosquitto \
      mosquitto-clients \
      libxml2-dev \
      libxslt-dev \
      flac \
      lsof \
  && apt-get clean \
  && apt-get -y auto-remove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -xe \
  && apt-get update \
  && apt-get install -y python3-pip \
  && wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - \
  && wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/buster.list \
  && apt update \
  && apt install -y mopidy \
  && apt install -y \
    mopidy-mpd \
    mopidy-local \
    mopidy-tunein \
    mopidy-podcast \
    mopidy-spotify \
    #mopidy-podcast-itunes \
  && apt-get clean \
  && apt-get -y auto-remove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


USER $USER
WORKDIR $HOME


# Remove it when finish developing.
RUN set -xe \
  && sudo apt-get update


CMD ["tail", "-f", "/dev/null"]
