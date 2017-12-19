#!/usr/bin/env bash
set -e

CERTFILE=/home/%USER%/.znc/znc.pem
echo $RENEWED_DOMAINS
for domain in $RENEWED_DOMAINS; do
    case $domain in
    %DOMAIN%)
        umask 077

        cat $RENEWED_LINEAGE/{privkey,cert,chain}.pem > $CERTFILE
        chown %USER% $CERTFILE
        chmod 400 $CERTFILE

        ;;
    esac
done
