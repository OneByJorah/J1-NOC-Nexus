FROM python:3.11-slim

WORKDIR /app

# System deps for nmap, snmp
RUN apt-get update && apt-get install -y --no-install-recommends \
    nmap \
    snmp \
    iputils-ping \
    net-tools \
    && rm -rf /var/lib/apt/lists/*
# Note: snmp-mibs-downloader skipped - not available in Debian slim, MIBs optional

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p logs config

CMD ["python3", "bot/main.py"]
