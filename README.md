# Template Resource Monitor

[![Docker](https://img.shields.io/badge/Docker-Supported-blue.svg)](https://hub.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Author](https://img.shields.io/badge/Author-Prince-orange.svg)]()

A robust, dockerized Node.js application designed to monitor resource availability on WHMCS-based template websites. Features **Session Reuse**, **Global Cooldown**, **Auto-Discovery**, and multi-channel notifications.

---

## ✨ Key Features

*   **Session Persistence**: Reuses login cookies to prevent IP bans and reduce server load (1 login/day).
*   **Global Cooldown**: Intelligent spam prevention. If stock is found, it notifies once and then waits (default 10m) before notifying again.
*   **Auto-Discovery**: Automatically detects new products on the target page without code changes.
*   **Log Rotation**: Built-in log management (7-day retention, 15MB limit) to prevent disk overflow.
*   **UTF-8 Support**: Full support for Chinese characters in notifications and logs.
*   **Docker Ready**: Fully configurable via Environment Variables.

---

## 🚀 Quick Start (Docker Compose)

Create a `docker-compose.yml` file and run `docker-compose up -d`.

```yaml
version: '3'

services:
  monitor:
    image: your_username/template-resource-monitor-prince:latest
    container_name: resource_monitor
    restart: unless-stopped
    environment:
      # --- Target Website Config (Required) ---
      - SITE_LOGIN_URL=https://example.com/login
      - SITE_STOCK_URL=https://example.com/cart
      - SITE_USERNAME=your_email@example.com
      - SITE_PASSWORD=your_password
      
      # --- Strategy Config (Optional) ---
      - CHECK_INTERVAL=60000          # Check every 60s
      - NOTIFY_COOLDOWN=600000        # 10m cooldown after notification
      
      # --- SMTP Notification (Optional) ---
      - SMTP_ENABLED=true
      - SMTP_HOST=smtp.qq.com
      - SMTP_PORT=587
      - SMTP_SECURE=false
      - SMTP_USER=your_email@qq.com
      - SMTP_PASS=your_auth_code
      - SMTP_RECEIVER=receiver@email.com
      
      # --- Telegram Notification (Optional) ---
      - TG_ENABLED=true
      - TG_BOT_TOKEN=123456:ABC-DEF...
      - TG_CHAT_ID=123456789

    volumes:
      - ./logs:/app/logs
      - ./data:/app/data
