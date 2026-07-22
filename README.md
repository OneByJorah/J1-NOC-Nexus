# TeleOps

Unified Network Operations Center platform — Telegram bot, SNMP discovery, live dashboard, and cross-platform agents for infrastructure management.

![status](https://img.shields.io/badge/status-active-FFB300?style=flat-square)
![language](https://img.shields.io/badge/python-3.10+-0d0d0c?style=flat-square)
![license](https://img.shields.io/badge/license-MIT-FFB300?style=flat-square)

## Overview

TeleOps is a self-hosted NOC (Network Operations Center) that brings together Telegram-based bot commands, automated SNMP network discovery, a live Flask dashboard, and cross-platform agents (Linux + Windows) for centralized infrastructure management. It's designed for environments where a full NOC setup is overkill but operational visibility is non-negotiable.

## Features

- Telegram bot for command execution, alerts, and scheduling
- Flask + SocketIO live dashboard with real-time observability
- SNMP network discovery and automated scanning (pysnmp)
- Cross-platform agents — Linux shell + Windows PowerShell bootstrap
- FastAPI async API layer for integrations
- Redis-backed pub/sub for event streaming
- Scapy-based network scanning for asset discovery
- Docker Compose deployment

## Architecture / Tech Stack

- **Bot**: python-telegram-bot, Redis
- **Dashboard**: Flask + Flask-SocketIO, vanilla JS
- **Discovery**: pysnmp, Scapy
- **API**: FastAPI (Python async)
- **Cache**: Redis
- **Deployment**: Docker Compose, install scripts
- **Platforms**: Linux, Windows

## Installation

```bash
git clone https://github.com/OneByJorah/TeleOps.git
cd TeleOps

# Option 1: Python
pip install -r requirements.txt
cp .env.example .env  # Edit with your Telegram bot token
python3 handlers.py

# Option 2: Docker
docker compose up -d
```

## Usage

1. Configure your Telegram bot token in `.env`
2. Start the dashboard and bot
3. Use Telegram commands to query infrastructure, trigger scans, or receive alerts
4. View real-time status at `http://localhost:5000`

## License

MIT — see [LICENSE](LICENSE).

---
Part of the JorahOne / J1 ecosystem — unified ops for self-hosted infrastructure.
