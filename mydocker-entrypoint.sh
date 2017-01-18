#!/bin/bash

# Test an IP address for validity:
# Usage:
#      valid_ip IP_ADDRESS
#      if [[ $? -eq 0 ]]; then echo good; else echo bad; fi
#   OR
#      if valid_ip IP_ADDRESS; then echo good; else echo bad; fi
#

export PROXY_IP
PROXY_IP=${PROXY_IP:-"127.0.0.1"}
cat > /etc/apache2/conf-available/remoteip.conf << EOF
RemoteIPHeader X-Forwarded-For
RemoteIPInternalProxy $PROXY_IP
EOF

a2enconf remoteip

sed -i '/^LogFormat/s/%h/%a/' /etc/apache2/apache2.conf

source /usr/local/bin/docker-entrypoint.sh "$@"