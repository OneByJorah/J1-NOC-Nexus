# J1-NOC-Nexus — Telegram Network Monitoring & Control Agent

A multi-platform Telegram bot that auto-discovers servers and network devices,
builds a live dashboard, and lets you control Windows and Linux servers from Telegram.

## Verify locally
1. `python3 -m venv .venv && source .venv/bin/activate`
2. `pip install -r requirements.txt`
3. `cp config/config.yaml.example config/config.yaml`
4. `python bot/main.py`
5. Open dashboard: `http://localhost:5000/` if `dashboard/app.py` is configured as the web UI.

## Reference mapping
- Bot entrypoint: `bot/main.py`
- Dashboard web app: `dashboard/app.py`
- Dashboard UI template: `dashboard/templates/index.html`
- Windows agent: `agents/windows/agent.ps1`
- Linux agent: `agents/linux/agent.py`
- Network discovery: `discovery/network_scanner.py`
- SNMP polling: `discovery/snmp_scanner.py`, `snmp_scanner.py`
- Deployment: `docker-compose.yml`, `Dockerfile`

## Screenshots
- `docs/screenshots/j1-noc-nexus-dashboard.png`

## Status
✅ Repo verified, references validated, and documentation updated.
