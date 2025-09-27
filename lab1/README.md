    
# Lab 1 – Installation of Linux (Ubuntu) Server

**Name:** Hajra Sarwar  
**Reg No:** 2023-BSE-022  
**Class:** BSE-5A  
**Subject:** CC  

[View Lab 1 Report](lab1/Lab1-Report.pdf)
---

## Table of Contents
1. [Overview](#overview)  
2. [Requirements](#requirements)  
3. [Boot from Install Media](#boot-from-install-media)  
4. [Language Selection](#language-selection)  
5. [Keyboard Layout](#keyboard-layout)  
6. [Choose Your Install](#choose-your-install)  
7. [Networking](#networking)  
8. [Configure Storage](#configure-storage)  
9. [Select a Device](#select-a-device)  
10. [Confirm Partitions](#confirm-partitions)  
11. [Confirm Changes](#confirm-changes)  
12. [Set Up a Profile](#set-up-a-profile)  
13. [Install Software](#install-software)  
14. [Installation Complete](#installation-complete)  
15. [What Next?](#what-next)  
16. [Finding Help](#finding-help)  

---

## Overview
Ubuntu Server is a lightweight, text-based version of Ubuntu designed for servers and networks.  
Unlike Ubuntu Desktop, it has no GUI, making it faster and ideal for:
- Small file servers  
- Cloud deployments  
- Network servers  

This guide covers installation via VMware Workstation Pro using the official Ubuntu Server ISO.

---

## Requirements
Before starting, ensure you have:  
- Minimum 20GB free storage  
- Recent backup of data if installing alongside other OS  
- Ubuntu Server ISO → [Download Here](https://ubuntu.com/download/server)  
- VMware Workstation Pro → [Download Here](https://getintopc.com/softwares/virtualization/vmware-workstation-pro-2024-free-download/)  

---

## Boot from Install Media
1. Install VMware Workstation Pro.  
2. Create a New Virtual Machine → Select **Typical (Recommended)**.  
3. Select **Installer Disc Image File (ISO)** → Browse to Ubuntu Server ISO.  
4. Start the VM → The Ubuntu Server installer will boot.  

---

## Language Selection
Use arrow keys to select your preferred language and press Enter.

---

## Keyboard Layout
Select the correct keyboard layout or keep the default option.

---

## Choose Your Install
Choose **Install Ubuntu** for a standard installation.

---

## Networking
- The installer auto-detects network settings via DHCP.  
- If no network is found, you can continue offline and configure later.

---

## Configure Storage
- Recommended: Use the entire disk  
- Advanced users can manually partition disks  

---

## Select a Device
Pick the disk for installation.

---

## Confirm Partitions
Review the partition layout before proceeding.

---

## Confirm Changes
Final confirmation before writing changes to disk.

---

## Set Up a Profile
Fill in the following details:
- **Name** → Your Name  
- **Server Name** → Your Roll Number  
- **Username** → Same as Name (no spaces)  
- **Password** → Secure password  

Optionally, add SSH Keys for secure login.

---

## Install Software
- Ubuntu Server installs essential packages.  
- Additional software can be installed after the base installation.  

---

## Installation Complete
- Remove the install media → Reboot → Ubuntu Server is ready.

---

## What Next?
Access Ubuntu Server from Windows using SSH:
```bash
ssh <username>@<ip-address>
```
Replace `<username>` with your username and `<ip-address>` with your server's IP from `ip addr` command.

---

## Finding Help
For troubleshooting or learning more:
- [Ubuntu Discourse](https://discourse.ubuntu.com)  
- [Ask Ubuntu](https://askubuntu.com)  
- IRC Support  
- [Ubuntu Advantage](https://ubuntu.com/advantage) for commercial help  

---

## Lab Status
Lab 1 completed successfully.




    
