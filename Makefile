CODENAME=$(shell lsb_release -sc)

modules/clientbuffer.so: \
    modules-source/znc-clientbuffer \
    /usr/bin/znc-buildmod
	znc-buildmod modules-source/znc-clientbuffer/clientbuffer.cpp
	mv clientbuffer.so ~/.znc/modules/

modules-source/znc-clientbuffer:
	mkdir -p modules-source
	git clone https://github.com/jpnurmi/znc-clientbuffer.git \
	    modules-source/znc-clientbuffer

/usr/bin/znc /usr/bin/znc-buildmod:
	sudo apt-get install znc znc-dev
	sudo setcap 'cap_net_bind_service=+ep' /usr/bin/znc

/etc/apt/sources.list.d/teward-znc-${CODENAME}.list:
	sudo add-apt-repository ppa:teward/znc
	sudo apt-get update
