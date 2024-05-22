FROM lscr.io/linuxserver/webtop:fedora-xfce

RUN dnf update -y && dnf install -y man man-pages && dnf install -y nmap openssh-server iputils iproute vim
COPY /etc /etc

### NMAP ###

RUN dnf install -y python3-pip cairo-devel pkg-config python3-devel python3-cairo python3-cairo-devel gobject-introspection-devel cairo-gobject-devel
COPY --from=ghcr.io/b3n4kh/nmap:latest /nmap/zenmap/zenmap /usr/local/bin/zenmap
COPY --from=ghcr.io/b3n4kh/nmap:latest /nmap/zenmap/dist/zenmap-7.95+svn-py3-none-any.whl /tmp/zenmap-7.95+svn-py3-none-any.whl
COPY --from=ghcr.io/b3n4kh/nmap:latest /nmap/zenmap/zenmapCore/data/pixmaps/zenmap.png /usr/share/icons/zenmap.png
COPY --from=ghcr.io/b3n4kh/nmap:latest /nmap/zenmap/install_scripts/unix/zenmap.desktop /usr/share/applications/zenmap.desktop

RUN pip install /tmp/zenmap-7.95+svn-py3-none-any.whl

############

EXPOSE 2222

