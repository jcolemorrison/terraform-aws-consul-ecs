ECS_IPV4=$(curl -s $ECS_CONTAINER_METADATA_URI | jq -r '.Networks[0].IPv4Addresses[0]')
%{ if dev_server_enabled ~}
SERVER_IP=$(cat /consul/server-ip)
%{ endif ~}

exec consul agent \
  -advertise "$ECS_IPV4" \
  -data-dir /consul/data \
  -client 0.0.0.0 \
  -encrypt "$CONSUL_GOSSIP_ENCRYPTION_KEY" \
%{ if dev_server_enabled ~}
  -retry-join "$SERVER_IP" \
%{ else ~}
  -retry-join "${retry_join}" \
%{ endif ~}
  -hcl 'telemetry { disable_compat_1.9 = true }' \
  -hcl 'leave_on_terminate = true' \
  -hcl 'ports { grpc = 8502 }' \
  -hcl 'advertise_reconnect_timeout = "15m"' \
  -hcl 'enable_central_service_config = true' \
