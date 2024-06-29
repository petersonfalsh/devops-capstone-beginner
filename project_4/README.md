
### Project 4: Ansible Task to Deploy Nginx

## README.md

```markdown
# Project 4: Ansible Task to Deploy Nginx

## Overview
This project aims to introduce beginners to the basics of Ansible by deploying the Nginx web server on Ubuntu servers. Ansible allows for automated, consistent, and efficient management of server configurations.

## Prerequisites
- Ansible installed on your control node
- Two or more Ubuntu servers (remote nodes) with SSH access
- Basic knowledge of Ansible and SSH

## Setup Instructions

### Step 1: Install Ansible on the Control Node
Install Ansible on your local machine or control node (Ubuntu example):
```bash
sudo apt update
sudo apt install ansible -y
```

### Step 2: Create an Inventory File
Create an inventory file named `hosts.ini` to define your target servers:
```ini
[webservers]
server1 ansible_host=192.168.1.101 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
server2 ansible_host=192.168.1.102 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
```

### Step 3: Create the Ansible Playbook
Create a playbook named `nginx-playbook.yml` with the following content:
```yaml
---
- name: Deploy Nginx web server
  hosts: webservers
  become: yes

  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes

    - name: Install Nginx
      apt:
        name: nginx
        state: present

    - name: Ensure Nginx is running
      service:
        name: nginx
        state: started
        enabled: yes
```

### Step 4: Run the Ansible Playbook
Execute the playbook to deploy Nginx on the target servers:
```bash
ansible-playbook -i hosts.ini nginx-playbook.yml
```

## Verifying the Deployment

1. After running the playbook, verify that Nginx is installed and running on the servers.
2. Check the status of the Nginx service on each server:
   ```bash
   sudo systemctl status nginx
   ```
3. Open a web browser and navigate to the IP address of each server (e.g., `http://192.168.1.101`). You should see the default Nginx welcome page.

## Dependencies

- Ansible
- SSH access to the remote servers

### Installation Instructions for Dependencies

**Ansible:**

**On Ubuntu:**
```bash
sudo apt update
sudo apt install ansible -y
```

**On macOS:**
```bash
brew install ansible
```

**On Windows:**
- Use WSL (Windows Subsystem for Linux) and follow the Ubuntu instructions, or use Ansible on a virtual machine or container.

## Maintenance and Extension Instructions

### Maintenance

- Regularly update the Ansible playbook to match your infrastructure needs.
- Monitor the Nginx web server performance and logs.

### Extension

- Extend the playbook to configure additional Nginx settings or deploy other applications.
- Add tasks to the playbook to manage SSL certificates, firewall rules, or load balancing.
