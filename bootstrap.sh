#!/usr/bin/env bash
set -euo pipefail

echo "Updating package lists..."
apt-get update

echo "Installing PostgreSQL and Vim..."
DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql vim

PG_CONF="/etc/postgresql/14/main/postgresql.conf"
PG_HBA="/etc/postgresql/14/main/pg_hba.conf"

if [[ ! -f "$PG_CONF" || ! -f "$PG_HBA" ]]; then
  echo "Expected PostgreSQL configuration files were not found."
  echo "Check the installed PostgreSQL version and configuration paths."
  exit 1
fi

echo "Configuring PostgreSQL to listen on network interfaces..."
if grep -Eq '^[#[:space:]]*listen_addresses[[:space:]]*=' "$PG_CONF"; then
  sed -i "s/^[#[:space:]]*listen_addresses[[:space:]]*=.*/listen_addresses = '*'/" "$PG_CONF"
else
  printf "\nlisten_addresses = '*'\n" >> "$PG_CONF"
fi

HBA_RULE="host all all 10.0.2.0/24 scram-sha-256"

if ! grep -Fqx "$HBA_RULE" "$PG_HBA"; then
  printf "\n%s\n" "$HBA_RULE" >> "$PG_HBA"
fi

echo "Restarting PostgreSQL..."
systemctl restart postgresql

echo "PostgreSQL provisioning completed."