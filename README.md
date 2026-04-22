# Secure NVR Gateway Deployment (Edge Infrastructure)
## Overview

This project focuses on deploying a secure gateway for a video surveillance system within a complex university infrastructure characterized by **Double NAT** conditions.

## Main Objective
To provide stable external access for exam proctors (EDKI) while strictly isolating critical infrastructure from public access.

## 1. Architecture

The system is built on **OpenWRT**, serving as an intelligent L3 gateway between the university-wide network and the local surveillance segment.

  * **Corporate Router**: A transit node with restricted administrative access.
  * **OpenWRT Gateway**: Handles traffic management, Firewall, NTP server, DHCP server and NAT.
  * **Endpoints**: NTP-Link VIGI NVR and Hikvision cameras (various generations/firmware versions).

## 2. Technical Challenges & Solutions
### 2.1. Integration of Legacy & Modern Hardware (The "Zoo" Problem)

*Issue*: Differing firmware versions of Hikvision cameras caused decoding errors (Error 245) in web interfaces and had varying levels of ONVIF protocol support.

*Solution*:

  * Updated all devices to the latest available official firmware versions.
  * Analyzed each device's capabilities and forced the H.264 (Main Profile) codec instead of H.265/High Profile to ensure maximum compatibility with proctors web browsers.

### 2.2. ONVIF Authentication & Time Synchronization

*Issue*: Cameras failed ONVIF authentication after NVR reboots due to Time Drift.

*Solution*:

  * Configured OpenWRT as a **local NTP server**.
  * Implemented strict synchronization intervals for both cameras and the NVR (every 5 minutes).

### 2.3. Security & Management Isolation (Hardening)

*Issue*: The need to provide video access while preventing unauthorized changes to device configurations.

*Solution*:

- **RBAC (Role-Based Access Control)**: Created dedicated access credentials for external proctors with limited permissions.
- **Management Plane Isolation**: Management ports are closed to the external network.
- **Targeted Port Forwarding**: Only specific ports for WebUI and video streaming are exposed via Firewall tunneling directly to the NVR.

## 3 Implementation Details (Manual Setup Logic)

While configurations were performed manually to fine-tune parameters, the configuration logic is preserved in UCI (Unified Configuration Interface) format:
Bash

## 4 Repository Structure

- [Deployment Case Study](./cctv-case-study.md) - Technical deep-dive.
- [VIGI NVR Configuration](./nvr-vigi-setup.md) - Detailed NVR settings.
- [OpenWRT Automation Scripts](./openwrt-scripts/) - Configuration helper scripts.

## 5 🎓 Lessons Learned

This project demonstrated the importance of a deep understanding of network protocols when working with "Black Box" proprietary devices (NVR/IP cameras). The ability to diagnose issues at the intersection of L3 (Network) and L7 (Application) layers allowed for the construction of a reliable system even within a conservative IT environment.