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
<img width="1536" height="1024" alt="Component 2" src="https://github.com/user-attachments/assets/d40cb6fa-6f7e-4bc6-8422-ef63e49b5e4d" />

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
<img width="1652" height="721" alt="Screenshot From 2026-10-24 00-50-15" src="https://github.com/user-attachments/assets/a9a54366-4bc0-4890-9832-49c14684658d" />
<img width="1009" height="605" alt="01" src="https://github.com/user-attachments/assets/b263d462-1960-4ee5-b864-07ec1b5ca1df" />
<img width="1009" height="605" alt="02" src="https://github.com/user-attachments/assets/e41e7bc1-b03e-4c94-9774-b001f81f29f8" />
<img width="984" height="853" alt="03-infra01-networking-verified" src="https://github.com/user-attachments/assets/580e6bf8-8ad2-42b7-90d6-aa64886fab7e" />

### 2. Linux Administration and Access Control

Configured Linux server administration settings, remote access, and file access permissions.

Implemented shared-directory permissions and Access Control Lists (ACLs) to control which users can access shared resources and what operations they can perform.

**Evidence**

<img width="1086" height="659" alt="05-infra01-ssh-hardening-verified" src="https://github.com/user-attachments/assets/4eb67dbe-4c26-4d6d-b4f7-c6045a7ede90" />
<img width="1116" height="167" alt="06-infra01-shared-permissions-verified" src="https://github.com/user-attachments/assets/019aaa35-5485-4303-aac9-149d9b26f335" />
<img width="1030" height="455" alt="07-infra01-default-acl-and-access-control-verified" src="https://github.com/user-attachments/assets/97f7644b-4733-493b-b1a1-89d294cbe335" />

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

<img width="1046" height="444" alt="11-infra01-fail2ban-active-ip-ban" src="https://github.com/user-attachments/assets/30c45325-1a5f-44ad-aad4-8bee25a61454" />
<img width="950" height="856" alt="11-infra01-ssh-after-firewall" src="https://github.com/user-attachments/assets/70e60982-4d6d-4f67-8f25-1328b13c8010" />

### 4. Nginx Web Servers

Configured two Linux web servers:

- `web01` — `192.168.56.20`
- `web02` — `192.168.56.21`

Installed and configured Nginx and deployed custom web pages. Verified that both websites could be accessed from the Ubuntu host using HTTP requests.

Running separate web servers provides a foundation for learning multi-server web hosting and infrastructure management.

**Evidence**

<img width="834" height="859" alt="12-nginx-web01-web02-verification" src="https://github.com/user-attachments/assets/ad0a6f29-144f-4d4c-b5e5-229bd7e02346" />

### 5. DNS Configuration

Configured the BIND DNS service on `infra01` to provide name-resolution capabilities for the lab environment.

DNS allows systems to resolve configured hostnames to their corresponding IP addresses rather than requiring administrators to remember every IP address.

Verified DNS resolution as part of the infrastructure testing.

**Evidence**

<img width="717" height="822" alt="13-dns-resolution png" src="https://github.com/user-attachments/assets/60bce0d8-20f7-466b-badb-0279285db49e" />

### 6. DHCP Configuration

Configured and verified DHCP-related services and client behavior in the lab.

DHCP automatically provides network configuration to clients, reducing the need to configure each client's IP settings manually.

The DHCP evidence covers the service status, client configuration, and lease information.

**Evidence**

<img width="853" height="219" alt="14 dhcp-client" src="https://github.com/user-attachments/assets/f2d0da44-e21f-47b2-8332-d7ef43318daa" />
<img width="1239" height="132" alt="14 dhcp-lease" src="https://github.com/user-attachments/assets/7b41ccab-e59b-4288-a94b-cc22a56e2afe" />
<img width="1918" height="492" alt="14 dhcp-service" src="https://github.com/user-attachments/assets/25b91a05-ac03-47b7-bb8d-0e951af85839" />

### 7. Samba File Sharing

Configured Samba on `file01` to provide shared storage accessible to authorized users over the network.

The shared directory is:

`/srv/samba/shared`

Configured user access and directory permissions, including group-based access controls. The shared directory uses restrictive permissions to prevent unauthorized access.

Verified that the shared folder could be accessed remotely.

**Evidence**

<img width="733" height="258" alt="15 samba-shared-folder" src="https://github.com/user-attachments/assets/59174f10-2b9a-4f34-b53e-dc64c6e315b2" />
<img width="996" height="516" alt="16 samba-remote-access" src="https://github.com/user-attachments/assets/30306905-550a-4583-aa3b-340b8e879122" />

### 8. Ansible Configuration Management

Used Ansible to automate administration tasks across multiple Linux servers.

Configured an inventory to identify managed servers and used SSH connectivity for remote administration.

Created an Ansible playbook to ensure that the required `tree` package is installed on the managed servers.

This demonstrates how a system administrator can perform repeatable configuration tasks without manually logging in to each server.

**Evidence**

<img width="1077" height="619" alt="17 ansible-multi-server" src="https://github.com/user-attachments/assets/1f2cc478-d76a-44d1-a303-dceece8e1606" />
<img width="1047" height="604" alt="18 ansible-automation" src="https://github.com/user-attachments/assets/7a2ff714-a3b7-4b6a-9a1c-6d31532e93f4" />

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

<img width="1917" height="784" alt="19-monitoring-dashboard png" src="https://github.com/user-attachments/assets/53a8298d-b2c3-4f4c-a6ce-57bc43726f82" />
<img width="1919" height="598" alt="20  prometheus-targets" src="https://github.com/user-attachments/assets/73e858ed-6b0b-47ad-ae6e-cf3f126970c9" />

### 10. Centralized Logging

Configured rsyslog to receive logs from `file01` on `infra01` over TCP port `514`.

Remote logs are stored under:

`/var/log/remote/file01/syslog.log`

Centralized logging provides a common location for reviewing events from multiple servers. This is useful for troubleshooting, auditing, and investigating server issues.

**Evidence**

<img width="1919" height="272" alt="21 centralized-logging" src="https://github.com/user-attachments/assets/4d3717dc-a2de-4e91-9409-e761cd017b80" />

### 11. Automated Backups

Created an automated backup script:

`/usr/local/sbin/infra-backup.sh`

Configured the script to back up important infrastructure configuration files, including selected rsyslog, Prometheus, Grafana, and BIND configurations and relevant systemd units.

Configured a systemd service and timer to run backups automatically. The backup process retains recent backups for 14 days.

Stored backups in:

`/var/backups/linux-infrastructure`

Restricted access to the backup directory and backup script using appropriate file permissions.

**Evidence**

<img width="1392" height="842" alt="22 automated-backups" src="https://github.com/user-attachments/assets/4ac623d7-ddda-4817-99f6-fbc96baafb2c" />

### 12. Disaster Recovery Verification

Created a disaster recovery verification script:

`/usr/local/sbin/disaster-recovery-check.sh`

The script selects the latest backup, checks that the archive is valid, and restores a copy of `/etc/rsyslog.conf` into a temporary directory for comparison.

This verifies that a backup can be read and that a configuration file can be recovered for inspection without overwriting the live configuration.

The recovery verification process helps identify unusable backups before they are needed during an actual failure.

**Evidence**

<img width="824" height="914" alt="23 disaster-recovery" src="https://github.com/user-attachments/assets/d072fe01-fef1-4634-87ac-6f0fdb9c1980" />

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

<img width="1381" height="712" alt="25 security-hardening" src="https://github.com/user-attachments/assets/e70205db-2f4f-4f90-a0fd-911d889c2947" />

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
