#!/bin/sh

echo "Downloading camoufox from $CAMOUFOX_URL..."

curl -sSL "$CAMOUFOX_URL" -o camoufox-linux.tar.gz
tar -xzf camoufox-linux.tar.gz
rm camoufox-linux.tar.gz
chmod +x /app/camoufox-linux/camoufox

exec "$@"
