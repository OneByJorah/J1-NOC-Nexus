# J1 NOC Nexus

**Version:** v1.0  
**Status:** Active Development  
**Repository:** https://github.com/OneByJorah/J1-NOC-Nexus

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Technology Stack](#technology-stack)
- [Features](#features)
- [Getting Started](#getting-started)
- [Service Management](#service-management)
- [Project Structure](#project-structure)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)
- [Author](#author)

---

## Overview

J1 NOC Nexus is the next-generation expansion of the J1 NOC platform. It adds automated discovery, SNMP scanning, Telegram bot integration, and cross-platform agents (Linux + Windows) alongside the Flask dashboard.

Built for operators who want one pane to monitor, chat, and act on infrastructure events.

---

## Architecture

Client → Flask dashboard + Telegram bot → FastAPI backend (`bot/`, `dashboard/`) → network discovery + SNMP scanners → agents (Linux/Windows) → alerting and automation.

Data paths:
- Dashboard: `dashboard/app.py` + `dashboard/templates/index.html`
- Bot: `bot/main.py`, `bot/handlers.py`, `bot/keyboards.py`
- Discovery: `discovery/network_scanner.py`, `discovery/snmp_scanner.py`
- Agents: `agents/linux/`, `agents/windows/`

---

## Technology Stack

| Layer | Stack |
|---|---|
| Runtime | Linux / Windows |
| Backend | Python / Flask / FastAPI |
| Frontend | HTML5 Dashboard |
| Automation | Telegram bot |
| Discovery | Network scanner, SNMP |
| Agents | Bash/PowerShell install wrappers + Python agent |
| VCS | Git + GitHub (`github.com/OneByJorah/J1-NOC-Nexus`) |

---

## Features

- **Dashboard**: real-time monitoring with Flask.
- **Telegram bot**: command handlers, keyboards, and scheduler for notifications.
- **Discovery**: automated network and SNMP scanning.
- **Cross-platform agents**: Linux (`agents/linux/`) and Windows (`agents/windows/`).
- **Install scripts**: one-click bootstrap for agents (`install.sh`, `install.ps1`).
- **CI**: `.github/workflows/ci.yml` for automated checks.

---

## Getting Started

```bash
# 1. Clone
git clone https://github.com/OneByJorah/J1-NOC-Nexus.git
cd J1-NOC-Nexus

# 2. Install backend
pip install -r requirements.txt

# 3. Run dashboard
python3 dashboard/app.py

# 4. Run bot (in another terminal)
python3 bot/main.py
```

Visit `http://localhost:5000`.

---

## Service Management

```bash
# Quick start
python3 dashboard/app.py

# Docker
docker compose up -d
```

---

## Project Structure

```
J1-NOC-Nexus/
├── dashboard/
│   ├── app.py
│   └── templates/
│       └── index.html
├── bot/
│   ├── main.py
│   ├── handlers.py
│   ├── keyboards.py
│   └── scheduler.py
├── discovery/
│   ├── network_scanner.py
│   └── snmp_scanner.py
├── agents/
│   ├── linux/agent.py
│   └── windows/agent.ps1
├── docs/screenshots/
│   └── j1-noc-nexus-dashboard.png
├── docker-compose.yml
├── Dockerfile
├── requirements.txt
└── README.md
```

---

## Screenshots

### J1 NOC Nexus Dashboard
![J1 NOC Nexus Dashboard](docs/screenshots/j1-noc-nexus-dashboard.png)

---

## Contributing

1. Create a feature branch off `main`.
2. Test on both Linux and Windows when changing agents.
3. Submit a PR with description and screenshots for UI changes.

---

## License

MIT

---

## Author

Built by **Jhonattan L. Jimenez**.
