#!/usr/bin/env python3
"""
TeleOps launcher.

Starts the web dashboard (Flask + SocketIO) and the agent registration
server (aiohttp) unconditionally. The Telegram bot only starts when a
real bot token is provided via config.yaml or the TELEGRAM_BOT_TOKEN env
var; otherwise it is skipped with a clear notice so the stack still runs
for local inspection and demos.

This is the single entrypoint used by the container (see Dockerfile).
"""

import asyncio
import logging
import os
import sys
from pathlib import Path

logging.basicConfig(
    format="%(asctime)s | %(levelname)-8s | %(name)s | %(message)s",
    level=logging.INFO,
    handlers=[logging.StreamHandler(sys.stdout)],
)
log = logging.getLogger("teleops.launcher")

ROOT = Path(__file__).parent
sys.path.insert(0, str(ROOT))

os.makedirs(ROOT / "logs", exist_ok=True)

from bot.agent_server import create_agent_server, start_agent_server
from dashboard.app import start_dashboard

CONFIG = {
    "dashboard": {"host": "0.0.0.0", "port": int(os.environ.get("DASHBOARD_PORT", 5000))},
    "server":    {"host": "0.0.0.0", "port": int(os.environ.get("AGENT_PORT", 8080))},
}


def _token_present() -> bool:
    from bot.main import load_config

    env_token = os.environ.get("TELEGRAM_BOT_TOKEN", "")
    if env_token:
        return True
    if not Path("config/config.yaml").exists():
        return False
    try:
        cfg = load_config()
    except SystemExit:
        return False
    token = cfg.get("bot", {}).get("token", "")
    return bool(token) and token != "YOUR_TELEGRAM_BOT_TOKEN"


async def _main():
    agents: dict = {}
    snmp_devices: dict = {}

    # Dashboard blocks (socketio.run), so serve it in a worker thread and
    # run the async agent server on the main event loop.
    import threading

    threading.Thread(
        target=start_dashboard, args=(agents, snmp_devices, CONFIG), daemon=True
    ).start()

    await start_agent_server(agents, snmp_devices, CONFIG)

    if _token_present():
        log.info("Telegram token detected — launching bot.")
        from bot.main import main as bot_main
        # bot_main() blocks on polling; run in executor to keep servers up.
        loop = asyncio.get_event_loop()
        await loop.run_in_executor(None, bot_main)
    else:
        log.warning(
            "No Telegram bot token configured — bot disabled. "
            "Dashboard and agent server are still running."
        )
        while True:
            await asyncio.sleep(3600)


if __name__ == "__main__":
    try:
        asyncio.run(_main())
    except KeyboardInterrupt:
        log.info("Shutting down TeleOps.")
