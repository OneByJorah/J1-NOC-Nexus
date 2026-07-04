# J1 NOC Nexus

> Multi-platform Telegram bot for server discovery, live dashboarding, and infrastructure control.

![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/status-active-%23FFB300?style=for-the-badge)
![Language](https://img.shields.io/badge/language-Python-informational?style=for-the-badge)
![Platform](https://img.shields.io/badge/platform-linux-informational?style=for-the-badge)

J1 NOC Nexus is an enterprise-grade, ops-precise platform built for VIDE and SMB operations. Run it solo. Deliver results.

- **Dashboard**: real-time monitoring with Flask.
- **Telegram bot**: command handlers, keyboards, and scheduler for notifications.
- **Discovery**: automated network and SNMP scanning.
- **Cross-platform agents**: Linux (`agents/linux/`) and Windows (`agents/windows/`).
- **Install scripts**: one-click bootstrap for agents (`install.sh`, `install.ps1`).
- **CI**: `.github/workflows/ci.yml` for automated checks.

---

## Architecture

Client → Flask dashboard + Telegram bot → FastAPI backend (`bot/`, `dashboard/`) → network discovery + SNMP scanners → agents (Linux/Windows) → alerting and automation.

Data paths:
- Dashboard: `dashboard/app.py` + `dashboard/templates/index.html`
- Bot: `bot/main.py`, `bot/handlers.py`, `bot/keyboards.py`
- Discovery: `discovery/network_scanner.py`, `discovery/snmp_scanner.py`
- Agents: `agents/linux/`, `agents/windows/`

---

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

## Quickstart

```bash
git clone https://github.com/OneByJorah/J1-NOC-Nexus.git
cd J1-NOC-Nexus
docker compose up -d
```
Verify at `http://<host-ip>`.

## Roadmap

- Feature parity with production requirements
- Observability and alerting expansions
- Community feedback integration

## License

MIT — Copyright JorahOne, LLC. See [LICENSE](LICENSE) for details.

---

[OneByJorah](https://github.com/OneByJorah) · [JorahOne-Services](https://github.com/JorahOne-Services)
