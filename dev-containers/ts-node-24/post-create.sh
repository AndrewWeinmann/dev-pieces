#!/usr/bin/env bash
set -euo pipefail

# Configure git to sign commits with SSH
git config --global gpg.format ssh
git config --global commit.gpgsign true
git config --global --unset user.signingkey || true
git config --global gpg.ssh.defaultKeyCommand "ssh-add -L"

# Install Claude Code CLI (required by the VS Code extension)
if command -v npm >/dev/null 2>&1; then
  if ! command -v claude >/dev/null 2>&1; then
    echo "Installing @anthropic-ai/claude-code globally..."
    npm install -g @anthropic-ai/claude-code || sudo npm install -g @anthropic-ai/claude-code || true
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
