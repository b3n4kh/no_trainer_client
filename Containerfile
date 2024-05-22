FROM lscr.io/linuxserver/webtop:fedora-xfce

RUN dnf update -y && dnf install -y man && dnf install -y nmap openssh-server iputils iproute

COPY /etc /etc

COPY --from=ghcr.io/b3n4kh/nmap:latest /nmap/zenmap/zenmap /usr/local/bin/zenmap

EXPOSE 2222

