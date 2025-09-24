#!/usr/bin/env bash
set -euo pipefail

# Configure SSH signing
mkdir -p ~/.ssh && chmod 700 ~/.ssh
cp /opt/signing.pub ~/.ssh/signing.pub
chmod 644 ~/.ssh/signing.pub

# Configure git to sign commits with SSH
git config --global gpg.format ssh
git config --global commit.gpgsign true
git config --global user.signingkey "$(cat ~/.ssh/signing.pub)"

# Install Codex CLI
if command -v npm >/dev/null 2>&1; then
  if ! command -v codex >/dev/null 2>&1; then
    echo "Installing @openai/codex globally..."
    npm install -g @openai/codex || sudo npm install -g @openai/codex || true
  fi
fi

# If there's a package.json and it defines an "install" script, run it
if [ -f package.json ]; then
  # Detect package manager preference/availability
  PM=""
  if [ -f pnpm-lock.yaml ] && command -v pnpm >/dev/null 2>&1; then
    PM=pnpm
  elif [ -f yarn.lock ] && command -v yarn >/dev/null 2>&1; then
    PM=yarn
  elif command -v npm >/dev/null 2>&1; then
    PM=npm
  fi

  if [ -n "$PM" ]; then
    if node -e "const s=(require('./package.json').scripts||{}); process.exit(s.install?0:1)"; then
      if [ "$PM" = "yarn" ]; then
        yarn run install
      else
        "$PM" run install
      fi
    fi
  fi
fi
