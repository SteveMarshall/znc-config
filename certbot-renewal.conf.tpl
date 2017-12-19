archive_dir = /etc/letsencrypt/archive/%DOMAIN%
cert = /etc/letsencrypt/live/%DOMAIN%/cert.pem
privkey = /etc/letsencrypt/live/%DOMAIN%/privkey.pem
chain = /etc/letsencrypt/live/%DOMAIN%/chain.pem
fullchain = /etc/letsencrypt/live/%DOMAIN%/fullchain.pem

[renewalparams]
authenticator = standalone
installer = None
account = %CERTBOT_ACCOUNT%
post_hook = /etc/letsencrypt/renewal-hooks/%DOMAIN%/post
renew_hook = /etc/letsencrypt/renewal-hooks/%DOMAIN%/deploy
pre_hook = /etc/letsencrypt/renewal-hooks/%DOMAIN%/pre
