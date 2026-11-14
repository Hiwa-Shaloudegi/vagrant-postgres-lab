# Vagrant PostgreSQL Lab

Ubuntu VM with PostgreSQL, managed by Vagrant + VirtualBox.  
Connect from pgAdmin 4 on Windows via forwarded port `5433`.

## Prerequisites

- VirtualBox
- Vagrant
- pgAdmin 4

## Setup

PowerShell

```
vagrant up
```

This creates the VM and runs `bootstrap.sh` (installs & configures PostgreSQL).

## Set postgres password

PowerShell

```
vagrant ssh
```

Bash

```
sudo -u postgres psql
```

SQL

```
\password postgres
\q
```

## Connect with pgAdmin

|Field|Value|
|---|---|
|Host|`127.0.0.1`|
|Port|`5433`|
|Maintenance database|`postgres`|
|Username|`postgres`|
|Password|(the one you set)|

## Useful commands

PowerShell

```
vagrant status
vagrant halt
vagrant up
vagrant provision   # re-run bootstrap.sh
vagrant destroy     # deletes the VM and all data
```

## Notes

- Data persists across `halt` / `up` / `reload`.
- `vagrant destroy` deletes everything.
- Port `5433` on the host maps to PostgreSQL `5432` inside the VM.