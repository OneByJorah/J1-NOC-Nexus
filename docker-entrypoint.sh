#!/bin/bash
# J1 NOC Nexus Docker Entrypoint
# Handles first-run setup and credential onboarding
# Auto-generates defaults when running non-interactively (no TTY)

set -e

# If .env doesn't exist, run setup wizard
if [ ! -f /app/.env ]; then
    echo "============================================"
    echo "  J1 NOC Nexus — First Run Setup"
    echo "============================================"
    echo ""
    
    # Generate random secrets
    SECRET=$(python3 -c "import secrets; print(secrets.token_hex(32))")
    REDIS_PASS=$(python3 -c "import secrets; print(secrets.token_urlsafe(16))")
    
    # Check if running interactively
    if [ -t 0 ]; then
        # Interactive mode
        echo "┌─ Telegram Bot Configuration ─────────────────────────┐"
        read -p "│ Telegram Bot Token: " BOT_TOKEN
        read -p "│ Admin Chat IDs (comma-separated): " ADMIN_IDS
        echo "└──────────────────────────────────────────────────────┘"
        
        echo ""
        echo "┌─ Redis Configuration ────────────────────────────────┐"
        read -p "│ Redis host [redis]: " REDIS_HOST
        REDIS_HOST=${REDIS_HOST:-redis}
        read -p "│ Redis port [6379]: " REDIS_PORT
        REDIS_PORT=${REDIS_PORT:-6379}
        echo "└──────────────────────────────────────────────────────┘"
        
        echo ""
        echo "┌─ Dashboard ─────────────────────────────────────────┐"
        read -p "│ Dashboard port [5000]: " DASH_PORT
        DASH_PORT=${DASH_PORT:-5000}
        read -p "│ Agent port [8080]: " AGENT_PORT
        AGENT_PORT=${AGENT_PORT:-8080}
        echo "└──────────────────────────────────────────────────────┘"
    else
        # Non-interactive mode — use defaults
        echo "Non-interactive mode — using auto-generated defaults"
        echo "⚠️  Set TELEGRAM_BOT_TOKEN and ADMIN_CHAT_IDS in .env for Telegram bot to work"
        BOT_TOKEN=""
        ADMIN_IDS=""
        REDIS_HOST="redis"
        REDIS_PORT=6379
        DASH_PORT=5000
        AGENT_PORT=8080
    fi
    
    # Write .env
    cat > /app/.env <<EOF
TELEGRAM_BOT_TOKEN=${BOT_TOKEN:-}
ADMIN_CHAT_IDS=${ADMIN_IDS:-}
REDIS_PASSWORD=${REDIS_PASS}
REDIS_HOST=${REDIS_HOST:-redis}
REDIS_PORT=${REDIS_PORT:-6379}
DASHBOARD_PORT=${DASH_PORT:-5000}
AGENT_PORT=${AGENT_PORT:-8080}
SECRET_KEY=${SECRET}
LOG_LEVEL=INFO
EOF
    
    echo ""
    echo "✅ Configuration saved to /app/.env"
    echo "   Redis password: ${REDIS_PASS}"
    echo ""
    echo "⚠️  Save these credentials — they won't be shown again."
    echo "============================================"
fi

# Source .env
export $(grep -v '^#' /app/.env | xargs)

# Ensure a config exists so the dashboard/agent server can boot even
# without a full Telegram setup (demo mode).
if [ ! -f /app/config/config.yaml ] && [ -f /app/config/config.yaml.example ]; then
    cp /app/config/config.yaml.example /app/config/config.yaml
    echo "ℹ️  Copied config.yaml.example -> config.yaml (edit to enable the Telegram bot)"
fi

echo "Starting J1 NOC Nexus..."
exec "$@"
