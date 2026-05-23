#!/bin/bash
# This installer is deprecated. claude-sound-notification is now a Claude Code plugin.
# The old installer overwrote ~/.claude/settings.json, which could clobber other
# tools' hook config. The plugin install path is non-destructive and reversible.
#
# To install:
#
#   /plugin marketplace add totigm/claude-sound-notification
#   /plugin install claude-sound-notification@claude-sound-notification
#   /reload-plugins
#
# Run those three lines inside Claude Code, not in your terminal.

cat <<'EOF'
claude-sound-notification is now a Claude Code plugin.

Install from inside Claude Code:

  /plugin marketplace add totigm/claude-sound-notification
  /plugin install claude-sound-notification@claude-sound-notification
  /reload-plugins

See the README for details:
  https://github.com/totigm/claude-sound-notification#install
EOF

exit 0
