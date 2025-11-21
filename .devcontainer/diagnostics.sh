#!/bin/bash

echo "=== SSH Agent Forwarding Diagnostics ==="
echo "Time: $(date)"
echo ""

echo "1. SSH_AUTH_SOCK Environment Variable"
echo "   Value: ${SSH_AUTH_SOCK:-[NOT SET]}"
echo ""

echo "2. Does the socket file exist?"
if [ -n "$SSH_AUTH_SOCK" ]; then
  if [ -S "$SSH_AUTH_SOCK" ]; then
    echo "   ✓ YES - Socket exists and is accessible"
    ls -lah "$SSH_AUTH_SOCK"
  else
    echo "   ✗ NO - File does not exist or is not a socket"
    if [ -e "$SSH_AUTH_SOCK" ]; then
      echo "   File exists but is not a socket:"
      ls -lah "$SSH_AUTH_SOCK"
    else
      echo "   Path: $SSH_AUTH_SOCK"
    fi
  fi
else
  echo "   SSH_AUTH_SOCK not set"
fi
echo ""

echo "3. /tmp filesystem details"
df -h /tmp
echo "   Mount: $(mount | grep ' /tmp ')"
echo ""

echo "4. /tmp contents (first 20 items)"
ls -lah /tmp | head -20
echo ""

echo "5. SSH key test"
if [ -n "$SSH_AUTH_SOCK" ] && [ -S "$SSH_AUTH_SOCK" ]; then
  ssh-add -l
  echo "   Exit code: $?"
else
  echo "   Cannot test - socket not available"
fi
echo ""

echo "6. Container /var/lib/docker info (if docker-in-docker)"
if [ -d /var/lib/docker ]; then
  echo "   docker-in-docker appears to be enabled"
  df -h /var/lib/docker 2>/dev/null || echo "   Cannot get docker stats"
else
  echo "   docker-in-docker does not appear to be enabled"
fi
echo ""

echo "7. Host machine info (from container perspective)"
echo "   Hostname: $(hostname)"
echo "   Kernel: $(uname -r)"
echo ""

echo "=== End Diagnostics ==="
