#!/bin/sh
set -e

if command -v iptables >/dev/null 2>&1; then
# Flush old iptables rules
iptables -F
iptables -X

# Allow only port 8080 incoming
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp --syn -j DROP
fi
# Unset K8s env variables if running in Kubernetes
unset KUBERNETES_SERVICE_HOST KUBERNETES_PORT KUBERNETES_PORT_443_TCP

# Start supervisord
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/services.conf
