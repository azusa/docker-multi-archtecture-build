FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN adduser node
RUN apt-get update -y
RUN apt-get install -y git sudo
RUN echo 'node ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

RUN apt-get install -y gcc libssl-dev build-essential curl language-pack-ja-base language-pack-ja locales


RUN cd /tmp; \
    ARCH="$(dpkg-architecture --query DEB_BUILD_GNU_CPU)"; \
    case "$ARCH" in \
        'aarch64') \
            NODE_URL='https://nodejs.org/dist/v20.5.1/node-v20.5.1-linux-arm64.tar.xz'; \
            ;; \
        'x86_64') \
            NODE_URL='https://nodejs.org/dist/v20.5.1/node-v20.5.1-linux-x64.tar.xz'; \
            ;; \
        *) echo >&2 "error: unsupported architecture '$ARCH'" ; exit 1 ;; \
    esac; \
    curl -L -o node.tgz "$NODE_URL";
RUN (cd /usr && tar xvJf  /tmp/node.tgz --strip-components 1)

RUN locale-gen ja_JP.UTF-8
RUN echo "export LANG=ja_JP.UTF-8" >> /home/node/.bashrc
