<div align="center">
  <img src="https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white">
  <img src="https://img.shields.io/badge/SocketIO-010101?style=for-the-badge&logo=socket.io&logoColor=white">
  <img src="https://img.shields.io/badge/Telegram-26A5E4?style=for-the-badge&logo=telegram&logoColor=white">
  <img src="https://img.shields.io/badge/license-MIT-blue?style=for-the-badge">
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white">
</div>

<br>

<div align="center">
  <h1>TeleOps</h1>
  <p><strong>Unified NOC Platform with Telegram Integration</strong></p>
  <p>Telegram bot, SNMP discovery, live dashboard, and cross-platform agents.</p>
  <p>
    <a href="#features">Features</a> •
    <a href="#quick-start">Quick Start</a> •
    <a href="#architecture">Architecture</a> •
    <a href="#contributing">Contributing</a>
  </p>
</div>

---

## Screenshot

![TeleOps Dashboard](docs/screenshot.png)
*Unified NOC platform with real-time monitoring and Telegram bot integration.*

## Features

- **Telegram Bot** — Manage infrastructure via Telegram commands and alerts.
- **SNMP Discovery** — Automated network device discovery and inventory.
- **Live Dashboard** — Real-time monitoring with WebSocket updates.
- **Cross-Platform Agents** — Deploy monitoring agents across your infrastructure.
- **Alert Management** — Configurable alerts with escalation policies.
- **Flask + SocketIO** — Async real-time backend with event-driven updates.
- **Docker Compose** — One-command production deployment.

## Quick Start

```bash
git clone https://github.com/OneByJorah/TeleOps.git
cd TeleOps

cp .env.example .env  # Configure Telegram bot token
docker compose up -d
```

Open **http://localhost:5000** in your browser.

### Telegram Bot Setup

1. Create a bot via [@BotFather](https://t.me/BotFather)
2. Add the bot token to `.env`:
   ```
   TELEGRAM_BOT_TOKEN=your_token_here
   ```
3. Start the bot and send `/start`

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `FLASK_APP` | `app.py` | Flask application entry point |
| `SECRET_KEY` | *(empty)* | Flask secret key |
| `TELEGRAM_BOT_TOKEN` | *(empty)* | Telegram bot token from BotFather |
| `SNMP_COMMUNITY` | `public` | Default SNMP community string |
| `DATABASE_URL` | `sqlite:///teleops.db` | Database connection string |
| `ALERT_WEBHOOK` | — | Webhook URL for alert notifications |

## Architecture

```
Browser ──SocketIO──▶ Flask Backend ──▶ SQLAlchemy ──▶ SQLite
                          │
                          ├──▶ Telegram Bot API
                          ├──▶ SNMP Manager ──▶ Network Devices
                          ├──▶ Agent Registry
                          └──▶ Alert Engine
```

## Tech Stack

- **Backend**: Flask, Flask-SocketIO (Python 3.10+)
- **Frontend**: HTML/CSS/JS with SocketIO client
- **Bot**: Telegram Bot API integration
- **Network**: SNMP for device discovery and monitoring
- **Database**: SQLite (default), PostgreSQL (production)
- **Deployment**: Docker Compose, systemd

## Project Structure

```
TeleOps/
├── app.py                 # Flask application entry point
├── routes/
│   ├── dashboard.py       # Dashboard endpoints
│   ├── devices.py         # Device management
│   ├── alerts.py          # Alert handling
│   └── api.py             # REST API
├── services/
│   ├── telegram_bot.py    # Telegram bot integration
│   ├── snmp_manager.py    # SNMP discovery and polling
│   └── alert_engine.py    # Alert processing
├── templates/             # Jinja2 HTML templates
├── static/                # CSS, JS, images
├── agents/                # Cross-platform monitoring agents
├── docker-compose.yml     # Docker deployment
└── .env.example           # Configuration template
```

## Telegram Commands

| Command | Description |
|---------|-------------|
| `/start` | Initialize the bot |
| `/status` | Get system status |
| `/devices` | List discovered devices |
| `/alerts` | View active alerts |
| `/scan` | Trigger network discovery |
| `/help` | Show available commands |

## Contributing

Contributions are welcome. Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines and [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for community standards.

## Security

For security concerns, see [SECURITY.md](SECURITY.md). Please report vulnerabilities to **info@jorahone.com** — do not use public issues.

## License

MIT © Jhonattan L. Jimenez

---

<div align="center">
  <p>Unified NOC for self-hosted infrastructure.</p>
  <p><a href="https://github.com/OneByJorah">@OneByJorah</a></p>
</div>
