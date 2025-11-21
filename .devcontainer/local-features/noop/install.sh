#!/bin/bash
set -e

cat << 'EOF' > /usr/local/bin/noop-entrypoint.sh
#!/bin/bash
LOGFILE="/workspaces/dc-demo/noop-debug.log"

echo "=== NOOP ENTRYPOINT START $(date) ===" | tee -a "$LOGFILE"
echo "Sleeping 30 seconds to delay dind..." | tee -a "$LOGFILE"
sleep 30
echo "Sleep finished. Execing next command..." | tee -a "$LOGFILE"

exec "$@"
EOF

chmod +x /usr/local/bin/noop-entrypoint.sh
