# Linux Infrastructure & System Administration

A hands-on Linux system administration project focused on building, configuring, securing, automating, and monitoring a multi-server Linux infrastructure using Ubuntu Server and VirtualBox.

## Project Overview

This project simulates a small organization's IT infrastructure using multiple Linux servers connected through a virtual network.

In a real organization, system administrators are responsible for configuring servers, managing network connectivity, providing DNS and DHCP services, hosting websites, controlling file access, automating administration tasks, monitoring server health, collecting logs, and maintaining reliable backups.

This project brings these responsibilities together in a practical lab environment.

### Project Objectives

- Build a multi-server Linux environment using VirtualBox.
- Configure virtual network adapters and static IP connectivity.
- Secure SSH remote administration.
- Configure DNS and DHCP services.
- Host websites using Nginx.
- Provide centralized file sharing using Samba.
- Manage server access permissions and ACLs.
- Configure Fail2ban to help protect SSH against repeated failed login attempts.
- Automate server configuration using Ansible.
- Monitor infrastructure using Prometheus, Node Exporter, and Grafana.
- Centralize logs using rsyslog.
- Automate configuration backups and verify disaster recovery.
- Apply firewall rules and additional security hardening.

## Architecture

```text
                    Ubuntu Host
                VirtualBox Environment
                         |
                 Host-Only Network
                  192.168.56.0/24
                         |
        +----------------+----------------+
        |                |                |
   infra01             web01            web02
 192.168.56.10      192.168.56.20    192.168.56.21
        |                |                |
        |                +-------+--------+
        |                        |
        |                  Nginx Websites
        |
        +-- DNS / DHCP Services
        |
        +-- Prometheus
        +-- Node Exporter
        +-- Grafana
        +-- Centralized Logging
        +-- Automated Backups
        +-- Security Controls

                    file01
                 192.168.56.40
                      |
               Samba File Sharing
                      |
                Centralized Logs

             Ubuntu Host: Ansible
                      |
             SSH Administration
                      |
             Managed Linux Servers
```

*The diagram is a logical overview of the implemented services, not a physical network diagram. The host-only network provides connectivity between the host and lab VMs; `infra01` also has a NAT adapter for external network access.*

## Infrastructure Environment

| Component | Configuration |
|---|---|
| Host operating system | Ubuntu Linux |
| Virtualization | Oracle VirtualBox |
| Server operating system | Ubuntu Server |
| Host-only network | `192.168.56.0/24` |
| Host-only gateway address on host | `192.168.56.1` |
| Infrastructure server | `infra01` — `192.168.56.10` |
| Web server 1 | `web01` — `192.168.56.20` |
| Web server 2 | `web02` — `192.168.56.21` |
| File server | `file01` — `192.168.56.40` |
| Configuration management | Ansible |
| Web server software | Nginx |
| DNS software | BIND |
| File sharing | Samba |
| Monitoring | Prometheus, Node Exporter, Grafana |
| Centralized logging | rsyslog |
| Firewall | UFW |
| SSH protection | SSH hardening and Fail2ban |

## Implemented Features

### 1. Virtualization and Network Configuration

Created virtual Linux servers using VirtualBox and configured network adapters to support communication between the Ubuntu host and the virtual machines.

Configured the host-only network to provide a private network for infrastructure administration and communication between the lab systems. The infrastructure server also uses NAT for external connectivity.

**Evidence**

- `01 VM network adapter.png`
- `02 VM network adapter.png`
- `03-infra01-networking-verified.png`

### 2. Linux Administration and Access Control

Configured Linux server administration settings, remote access, and file access permissions.

Implemented shared-directory permissions and Access Control Lists (ACLs) to control which users can access shared resources and what operations they can perform.

**Evidence**

- `05-infra01-ssh-hardening-verified.png`
- `06-infra01-shared-permissions-verified.png`
- `07-infra01-default-acl-and-access-control-verified.png`

### 3. SSH Security and Fail2ban

Hardened SSH remote administration by applying security settings that include:

- Disabling direct root login.
- Disabling password-based SSH authentication.
- Enabling public-key authentication.
- Disabling X11 forwarding.
- Restricting access to SSH through firewall rules.
- Configuring Fail2ban to help block repeated failed authentication attempts.

Verified SSH connectivity after firewall changes and captured evidence of Fail2ban activity.

**Evidence**

- `11-infra01-fail2ban-active-ip-ban.png`
- `11-infra01-ssh-after-firewall.png`

### 4. Nginx Web Servers

Configured two Linux web servers:

- `web01` — `192.168.56.20`
- `web02` — `192.168.56.21`

Installed and configured Nginx and deployed custom web pages. Verified that both websites could be accessed from the Ubuntu host using HTTP requests.

Running separate web servers provides a foundation for learning multi-server web hosting and infrastructure management.

**Evidence**

- `12-nginx-web01-web02-verification.png`

### 5. DNS Configuration

Configured the BIND DNS service on `infra01` to provide name-resolution capabilities for the lab environment.

DNS allows systems to resolve configured hostnames to their corresponding IP addresses rather than requiring administrators to remember every IP address.

Verified DNS resolution as part of the infrastructure testing.

**Evidence**

- `13-dns-resolution.png`

### 6. DHCP Configuration

Configured and verified DHCP-related services and client behavior in the lab.

DHCP automatically provides network configuration to clients, reducing the need to configure each client's IP settings manually.

The DHCP evidence covers the service status, client configuration, and lease information.

**Evidence**

- `14 dhcp-client.png`
- `14 dhcp-lease.png`
- `14 dhcp-service.png`

### 7. Samba File Sharing

Configured Samba on `file01` to provide shared storage accessible to authorized users over the network.

The shared directory is:

`/srv/samba/shared`

Configured user access and directory permissions, including group-based access controls. The shared directory uses restrictive permissions to prevent unauthorized access.

Verified that the shared folder could be accessed remotely.

**Evidence**

- `15 samba-shared-folder.png`
- `16 samba-remote-access.png`

### 8. Ansible Configuration Management

Used Ansible to automate administration tasks across multiple Linux servers.

Configured an inventory to identify managed servers and used SSH connectivity for remote administration.

Created an Ansible playbook to ensure that the required `tree` package is installed on the managed servers.

This demonstrates how a system administrator can perform repeatable configuration tasks without manually logging in to each server.

**Evidence**

- `17 ansible-multi-server.png`
- `18 ansible-automation.png`

### 9. Infrastructure Monitoring

Implemented infrastructure monitoring using Prometheus, Node Exporter, and Grafana.

**Prometheus**

Collects and stores time-series metrics and provides a monitoring data source.

**Node Exporter**

Exposes Linux system metrics for Prometheus to collect, including operating-system resource information.

**Grafana**

Displays monitoring metrics through dashboards, making it easier to observe system health and resource utilization.

Configured a Linux server monitoring dashboard with panels for CPU, memory, disk, and server availability. Verified the Prometheus monitoring targets.

**Evidence**

- `19-monitoring-dashboard.png`
- `20. prometheus-targets.png`

### 10. Centralized Logging

Configured rsyslog to receive logs from `file01` on `infra01` over TCP port `514`.

Remote logs are stored under:

`/var/log/remote/file01/syslog.log`

Centralized logging provides a common location for reviewing events from multiple servers. This is useful for troubleshooting, auditing, and investigating server issues.

**Evidence**

- `21 centralized-logging.png`

### 11. Automated Backups

Created an automated backup script:

`/usr/local/sbin/infra-backup.sh`

Configured the script to back up important infrastructure configuration files, including selected rsyslog, Prometheus, Grafana, and BIND configurations and relevant systemd units.

Configured a systemd service and timer to run backups automatically. The backup process retains recent backups for 14 days.

Stored backups in:

`/var/backups/linux-infrastructure`

Restricted access to the backup directory and backup script using appropriate file permissions.

**Evidence**

- `22 automated-backups.png`

### 12. Disaster Recovery Verification

Created a disaster recovery verification script:

`/usr/local/sbin/disaster-recovery-check.sh`

The script selects the latest backup, checks that the archive is valid, and restores a copy of `/etc/rsyslog.conf` into a temporary directory for comparison.

This verifies that a backup can be read and that a configuration file can be recovered for inspection without overwriting the live configuration.

The recovery verification process helps identify unusable backups before they are needed during an actual failure.

**Evidence**

- `23 disaster-recovery.png`

### 13. Firewall and Security Hardening

Applied additional security controls to reduce unnecessary network exposure.

Configured UFW with incoming traffic denied by default and explicit rules for required services.

The configured rules restrict:

- DNS traffic to the lab subnet.
- Grafana and Prometheus access to the Ubuntu host's host-only address.
- Remote logging to the lab subnet.
- SSH access to the lab subnet.

Bound Grafana and Prometheus to `192.168.56.10` rather than listening on all network interfaces. Verified that both services were accessible from the host and that Node Exporter port `9100` was not accessible from the host through the tested address.

Also verified SSH security settings and restrictive permissions on backup files and scripts.

**Evidence**

- `25 security-hardening.png`

## Key Skills Demonstrated

**Linux System Administration**
- Linux server configuration and service management.
- SSH administration and authentication security.
- File permissions, ownership, and ACLs.
- systemd services and timers.
- Troubleshooting using Linux command-line tools.

**Networking**
- VirtualBox network adapters.
- Host-only networking and NAT.
- IP addressing and connectivity verification.
- DNS and DHCP.
- Firewall configuration and port restrictions.

**Automation**
- Ansible inventory and playbooks.
- Automated package management.
- Shell scripting.
- Scheduled backups using systemd timers.

**Monitoring and Reliability**
- Prometheus metrics collection.
- Node Exporter.
- Grafana dashboards.
- Centralized rsyslog logging.
- Backup validation and disaster recovery checks.

**Security**
- SSH hardening.
- UFW firewall rules.
- Fail2ban.
- Least-privilege file permissions.
- Restricted monitoring-service bindings.

## Repository Structure

```text
linux-infrastructure/
├── ansible/
│   ├── inventory.example.ini
│   ├── inventory.ini
│   └── setup.yml
├── disaster-recovery-check.sh
├── .gitignore
└── README.md
```

The Ansible inventory and disaster recovery script are included in the repository. The server-side configurations and services were configured within the lab VMs. Screenshots document the implementation and verification steps.

## Verification Summary

The project includes verification evidence for:

- Virtual network configuration and connectivity.
- SSH security settings and remote access.
- File permissions and ACLs.
- Fail2ban activity.
- Nginx web server availability.
- DNS resolution and DHCP behavior.
- Samba shared-folder access.
- Ansible connectivity and automation.
- Prometheus targets and Grafana dashboards.
- Centralized log collection.
- Automated backups and disaster recovery.
- Firewall restrictions and monitoring-service accessibility.

## Future Improvements

Potential future enhancements include:

- Monitoring additional servers through Node Exporter.
- Adding alert rules and notification channels to Prometheus.
- Improving backup reporting and restore automation.
- Documenting DNS records, DHCP scope details, and recovery procedures.
- Adding repeatable infrastructure deployment with Ansible.
- Testing recovery procedures for additional configuration files.
- Integrating a dedicated log monitoring dashboard.

## Conclusion

This project demonstrates practical experience building and administering a multi-server Linux environment.

It combines networking, Linux system administration, security, file sharing, configuration management, monitoring, centralized logging, automated backups, and disaster recovery into one lab.

The project was designed to develop practical system administration skills through implementation, testing, and verification rather than relying only on theoretical knowledge.
