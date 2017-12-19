ifndef DOMAIN
$(error DOMAIN is not set)
endif
ifndef CERTBOT_ACCOUNT
$(error CERTBOT_ACCOUNT is not set)
endif
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

/etc/letsencrypt/renewal/${DOMAIN}.conf: certbot-renewal.conf.tpl
	sudo mkdir -p $(shell dirname $@)
	sudo sh -c 'sed -e "s/%DOMAIN%/${DOMAIN}/g" -e "s/%CERTBOT_ACCOUNT%/${CERTBOT_ACCOUNT}/g" $< > $@'

/etc/letsencrypt/renewal-hooks/${DOMAIN}/deploy: certbot-hooks/deploy.tpl
	sudo mkdir -p $(shell dirname $@)
	sudo sh -c 'sed -e "s/%DOMAIN%/${DOMAIN}/g" -e "s/%USER%/${USER}/g" $< > $@'
	sudo chmod +x $@

/etc/letsencrypt/renewal-hooks/${DOMAIN}/%: certbot-hooks/%
	sudo mkdir -p $(shell dirname $@)
	sudo ln -s $(shell pwd)/$< $@

/usr/bin/certbot: | /etc/apt/sources.list.d/certbot-certbot-${CODENAME}.list
	sudo apt-get install certbot

/etc/apt/sources.list.d/certbot-certbot-${CODENAME}.list:
	sudo apt-get install software-properties-common
	sudo add-apt-repository ppa:certbot/certbot
	sudo apt-get update
