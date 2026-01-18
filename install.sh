#!/bin/bash

# Claude Code Sound Notifications Installer
# Plays a sound when Claude Code finishes a task
# Supports macOS, Linux, and Windows (Git Bash/WSL)

set -e

SETTINGS_FILE="$HOME/.claude/settings.json"
CLAUDE_DIR="$HOME/.claude"

# Detect OS and set appropriate sound command (already JSON-escaped)
detect_sound_command() {
  case "$(uname -s)" in
    Darwin)
      echo 'afplay /System/Library/Sounds/Glass.aiff'
      ;;
    Linux)
      # Try different Linux audio players in order of preference
      if command -v paplay &> /dev/null; then
        echo 'paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null || echo -e \\\"\\\\a\\\"'
      elif command -v aplay &> /dev/null; then
        echo 'aplay -q /usr/share/sounds/sound-icons/glass-water-1.wav 2>/dev/null || echo -e \\\"\\\\a\\\"'
      elif command -v mpv &> /dev/null; then
        echo 'mpv --no-terminal /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null || echo -e \\\"\\\\a\\\"'
      else
        echo 'echo -e \\\"\\\\a\\\"'
      fi
      ;;
    MINGW*|MSYS*|CYGWIN*)
      # Windows Git Bash / MSYS2 / Cygwin - JSON escaped
      echo 'powershell -c \\\"(New-Object Media.SoundPlayer \\\\\\\"C:\\\\Windows\\\\Media\\\\chimes.wav\\\\\\\").PlaySync()\\\"'
      ;;
    *)
      echo 'echo -e \\\"\\\\a\\\"'
      ;;
  esac
}

SOUND_CMD=$(detect_sound_command)

# Create .claude directory if it doesn't exist
mkdir -p "$CLAUDE_DIR"

# The hook configuration to add
HOOK_CONFIG="{
  \"hooks\": {
    \"Stop\": [
      {
        \"matcher\": \"\",
        \"hooks\": [
          {
            \"type\": \"command\",
            \"command\": \"$SOUND_CMD\"
          }
        ]
      }
    ]
  },
  \"permissions\": {
    \"allow\": [
      \"Bash(afplay:*)\",
      \"Bash(paplay:*)\",
      \"Bash(aplay:*)\",
      \"Bash(mpv:*)\",
      \"Bash(powershell:*)\",
      \"Bash(echo:*)\"
    ]
  }
}"

if [ -f "$SETTINGS_FILE" ]; then
  if command -v jq &> /dev/null; then
    # Backup existing settings
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"

    # Merge the configurations
    jq -s '
      def deepmerge:
        if type == "array" then add
        elif type == "object" then
          reduce (.[0] | keys_unsorted)[] as $key (
            .[1];
            .[$key] = ([.[0][$key], .[1][$key]] | deepmerge)
          )
        else .[0] // .[1]
        end;
      [.[1], .[0]] | deepmerge
    ' "$SETTINGS_FILE" <(echo "$HOOK_CONFIG") > "$SETTINGS_FILE.tmp" && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"

    echo "✓ Sound notifications added to existing Claude Code settings"
    echo "  Backup saved to: $SETTINGS_FILE.backup"
  else
    # No jq - backup and overwrite (simpler approach for Windows)
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"
    echo "$HOOK_CONFIG" > "$SETTINGS_FILE"
    echo "✓ Sound notifications installed (previous settings backed up)"
    echo "  Backup saved to: $SETTINGS_FILE.backup"
    echo ""
    echo "⚠ Note: jq not found. Your previous settings were backed up but not merged."
    echo "  If you had custom settings, manually merge from the backup file."
  fi
else
  # File doesn't exist - create it
  echo "$HOOK_CONFIG" > "$SETTINGS_FILE"
  echo "✓ Claude Code settings created with sound notifications"
fi

echo ""
echo "Detected OS: $(uname -s)"
echo ""
echo "Done! Claude Code will now play a sound when it finishes."
echo "Restart Claude Code for changes to take effect."
