#!/bin/bash
set -e

echo "=== onCreateCommand: Initial Setup ==="
echo "Time: $(date)"
echo ""

# Install minimal diagnostics tools
apt-get update
apt-get install -y --no-install-recommends \
  openssh-client \
  curl \
  ca-certificates

echo "Setup complete"
