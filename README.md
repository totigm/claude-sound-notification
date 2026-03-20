# Claude Code Sound Notifications

Get audio notifications from Claude Code. Different sounds for when Claude finishes a task vs when it needs your input.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/totigm/claude-sound-notification/main/install.sh | bash
```

## What it does

Plays different sounds for two events:
- **Task complete** (`Stop`) — Claude finished working
- **Needs input** (`Notification`) — Claude is asking for permission or user input

This way you know whether to just check results or go respond.

## Platform Support

| Platform | Sound Player | Task Complete | Needs Input |
|----------|--------------|---------------|-------------|
| macOS | `afplay` | Glass.aiff | Funk.aiff |
| Linux | `paplay`, `aplay`, or `mpv` | complete.oga | message.oga |
| Windows | PowerShell | chimes.wav | notify.wav |

The installer auto-detects your OS and configures the appropriate sound command. Falls back to terminal bell (`\a`) if no audio player is found.

### Linux Requirements

Install one of these audio players:
```bash
# Ubuntu/Debian (PulseAudio)
sudo apt install pulseaudio-utils

# Or ALSA
sudo apt install alsa-utils

# Or mpv
sudo apt install mpv
```

### Windows

Run the installer in **Git Bash**, **WSL**, or **MSYS2**. PowerShell is used to play sounds.

## Uninstall

Remove the `Stop` and `Notification` hooks from `~/.claude/settings.json`, or restore from the backup:

```bash
mv ~/.claude/settings.json.backup ~/.claude/settings.json
```

## Customizing the sound

Edit `~/.claude/settings.json` and change the sound commands for `Stop` and/or `Notification`.

**macOS system sounds:**
- `/System/Library/Sounds/Glass.aiff` (default for Stop)
- `/System/Library/Sounds/Funk.aiff` (default for Notification)
- `/System/Library/Sounds/Pop.aiff`
- `/System/Library/Sounds/Submarine.aiff`
- `/System/Library/Sounds/Hero.aiff`

**Windows sounds:**
- `C:\Windows\Media\chimes.wav` (default for Stop)
- `C:\Windows\Media\notify.wav` (default for Notification)
- `C:\Windows\Media\tada.wav`

**Linux:** Use any `.oga`, `.wav`, or `.mp3` file with your preferred player.

## License

MIT
