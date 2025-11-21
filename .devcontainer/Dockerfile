FROM python:3.12.12-slim

# Install minimal SSH tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-client \
    curl \
    ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Optional: add inline diagnostics at container startup
# This runs before devcontainer.json mounts are applied
RUN echo '#!/bin/bash' > /usr/local/bin/container-info && \
    echo 'echo "Container started at $(date)"' >> /usr/local/bin/container-info && \
    echo 'echo "SSH_AUTH_SOCK: ${SSH_AUTH_SOCK:-NOT SET}"' >> /usr/local/bin/container-info && \
    chmod +x /usr/local/bin/container-info
