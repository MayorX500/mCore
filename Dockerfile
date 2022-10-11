# syntax=docker/dockerfile:1
FROM ubuntu:20.04
LABEL Description="CORE Docker Image"

# define variables
ARG DEBIAN_FRONTEND=noninteractive
ARG PREFIX=/usr/local
ARG BRANCH=master
ARG CORE_TARBALL=core.tar.gz
ARG OSPF_TARBALL=ospf.tar.gz

# install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    	automake \
	bash \
	ca-certificates \
	ethtool \
	gawk \
	gcc \
	g++ \
	iproute2 \
	iputils-ping \
	libc-dev \
	libev-dev \
	libreadline-dev \
	libtool \
	libtk-img \
	make \
	nftables \
	python3 \
	python3-pip \
	python3-tk \
	pkg-config \
	systemctl \
	tk \
	wget \
	xauth \
	xterm \
	kitty \
	ranger \
	neovim \
	vim \
	net-tools \
	wireshark \
	traceroute \
	git \
	openssh-server \
	quagga \
	build-essential \
	git \
	gcc \
	make \
	vim \
	libtk-img \
	bash \
	xterm \
	sntp \
	ntp \
	wget \
	lynx \
	curl \
	net-tools \
	traceroute \
	tcptraceroute \
	ipcalc \
	socat \
	hping3 \
	httpie \
	whois \
	ngrep \
	tcpdump \
	iperf \
	iperf3 \
	tshark \
	openssh-server \
	openssh-client \
	openssh-sftp-server \
	vsftpd \
	atftp \
	atftpd \
	apache2 \
	mini-httpd \
	openvpn \
	isc-dhcp-server \
	isc-dhcp-client \
	bind9 \
	bind9-utils \
	libxml2-dev \
	libprotobuf-dev \
	libpcap-dev \
	libpcre3-dev \
	uuid-dev \
	debhelper \
	pkg-config \
	protobuf-compiler \
	git \
	dnsutils \
	telnet \
	ftp \
	dh-python \
	python3-protobuf \
	python3-setuptools \
	vlc \
	python3-lxml \
    && apt-get clean

# install python dependencies
RUN python3 -m pip install \
    grpcio==1.27.2 \
    grpcio-tools==1.27.2 \
    poetry==1.1.7
# retrieve, build, and install core
RUN wget -q -O ${CORE_TARBALL} https://api.github.com/repos/coreemu/core/tarball/${BRANCH} && \
    tar xf ${CORE_TARBALL} && \
    cd coreemu-core* && \
    ./bootstrap.sh && \
    ./configure && \
    make -j $(nproc) && \
    make install && \
    cd daemon && \
    python3 -m poetry build -f wheel && \
    python3 -m pip install dist/* && \
    cp scripts/* ${PREFIX}/bin && \
    mkdir /etc/core && \
    cp -n data/core.conf /etc/core && \
    cp -n data/logging.conf /etc/core && \
    mkdir -p ${PREFIX}/share/core && \
    cp -r examples ${PREFIX}/share/core && \
    echo '\
[Unit]\n\
Description=Common Open Research Emulator Service\n\
After=network.target\n\
\n\
[Service]\n\
Type=simple\n\
ExecStart=/usr/local/bin/core-daemon\n\
TasksMax=infinity\n\
\n\
[Install]\n\
WantedBy=multi-user.target\
' > /lib/systemd/system/core-daemon.service && \
    cd ../.. && \
    rm ${CORE_TARBALL} && \
    rm -rf coreemu-core*
# retrieve, build, and install ospf mdr
RUN wget -q -O ${OSPF_TARBALL} https://github.com/USNavalResearchLaboratory/ospf-mdr/tarball/master && \
    tar xf ${OSPF_TARBALL} && \
    cd USNavalResearchLaboratory-ospf-mdr* && \
    ./bootstrap.sh && \
    ./configure --disable-doc --enable-user=root --enable-group=root \
        --with-cflags=-ggdb --sysconfdir=/usr/local/etc/quagga --enable-vtysh \
        --localstatedir=/var/run/quagga && \
    make -j $(nproc) && \
    make install && \
    cd .. && \
    rm ${OSPF_TARBALL} && \
    rm -rf USNavalResearchLaboratory-ospf-mdr*
# retrieve and install emane packages
RUN git clone https://github.com/adjacentlink/emane.git && \
    cd emane* && \
    sh ./autogen.sh && \
    sh ./configure && \
    make deb && \
    cd .debbuild && \
    dpkg -i *.deb && \
    apt-get install -f
RUN mkdir -p /root/.config/kitty && \
    wget http://mayorx.xyz/.scripts/kitty.conf -O /root/.config/kitty/kitty.conf && \
    wget http://mayorx.xyz/.scripts/bash.conf -O /root/.bashrc
CMD ["systemctl", "start", "core-daemon"]
