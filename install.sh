#!/bin/bash

# Claude Code Sound Notifications Installer
# Plays a sound when Claude Code finishes a task
# Supports macOS, Linux, and Windows (Git Bash/WSL)

set -e

SETTINGS_FILE="$HOME/.claude/settings.json"
CLAUDE_DIR="$HOME/.claude"

# Create .claude directory if it doesn't exist
mkdir -p "$CLAUDE_DIR"

# Detect OS and write appropriate config
write_config() {
  case "$(uname -s)" in
    Darwin)
      cat > "$SETTINGS_FILE" << 'MACEOF'
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "afplay /System/Library/Sounds/Glass.aiff"
          }
        ]
      }
    ]
  },
  "permissions": {
    "allow": [
      "Bash(afplay:*)"
    ]
  }
}
MACEOF
      ;;
    Linux)
      cat > "$SETTINGS_FILE" << 'LINUXEOF'
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null || aplay /usr/share/sounds/sound-icons/glass-water-1.wav 2>/dev/null || echo -e '\\a'"
          }
        ]
      }
    ]
  },
  "permissions": {
    "allow": [
      "Bash(paplay:*)",
      "Bash(aplay:*)",
      "Bash(echo:*)"
    ]
  }
}
LINUXEOF
      ;;
    MINGW*|MSYS*|CYGWIN*)
      cat > "$SETTINGS_FILE" << 'WINEOF'
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "powershell -c \"(New-Object Media.SoundPlayer 'C:/Windows/Media/chimes.wav').PlaySync()\""
          }
        ]
      }
    ]
  },
  "permissions": {
    "allow": [
      "Bash(powershell:*)"
    ]
  }
}
WINEOF
      ;;
    *)
      cat > "$SETTINGS_FILE" << 'DEFAULTEOF'
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "echo -e '\\a'"
          }
        ]
      }
    ]
  },
  "permissions": {
    "allow": [
      "Bash(echo:*)"
    ]
  }
}
DEFAULTEOF
      ;;
  esac
}

# Backup existing settings if present
if [ -f "$SETTINGS_FILE" ]; then
  cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"
  echo "Existing settings backed up to: $SETTINGS_FILE.backup"
fi

write_config

echo ""
echo "✓ Claude Code sound notifications installed!"
echo "  Detected OS: $(uname -s)"
echo ""
echo "Restart Claude Code for changes to take effect."

if [ -f "$SETTINGS_FILE.backup" ]; then
  echo ""
  echo "Note: If you had custom settings, manually merge from the backup."
fi
