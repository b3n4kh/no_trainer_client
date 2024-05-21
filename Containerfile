FROM lscr.io/linuxserver/webtop:fedora-xfce

RUN dnf update -y && dnf install -y nmap openssh-server

COPY /etc /etc

EXPOSE 2222

