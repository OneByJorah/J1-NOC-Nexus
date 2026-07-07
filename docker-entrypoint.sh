#!/bin/bash
# J1 NOC Nexus Docker Entrypoint
# Handles first-run setup and credential onboarding

set -e

# If .env doesn't exist, run setup wizard
if [ ! -f /app/.env ]; then
    echo "============================================"
    echo "  J1 NOC Nexus — First Run Setup"
    echo "============================================"
    echo ""
    echo "No configuration found. Let's set up J1 NOC Nexus."
    echo ""
    
    # Generate random secrets
    SECRET=$(python3 -c "import secrets; print(secrets.token_hex(32))")
    REDIS_PASS=$(python3 -c "import secrets; print(secrets.token_urlsafe(16))")
    
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
    
    # Write .env
    cat > /app/.env <<EOF
TELEGRAM_BOT_TOKEN=${BOT_TOKEN}
ADMIN_CHAT_IDS=${ADMIN_IDS}
REDIS_PASSWORD=${REDIS_PASS}
REDIS_HOST=${REDIS_HOST}
REDIS_PORT=${REDIS_PORT}
DASHBOARD_PORT=${DASH_PORT}
AGENT_PORT=${AGENT_PORT}
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

echo "Starting J1 NOC Nexus..."
exec "$@"
