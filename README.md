# Claude Code Sound Notifications

Get an audio notification when Claude Code finishes a task. Never miss when Claude is done!

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/totigm/claude-sound/main/install.sh | bash
```

## What it does

Plays a sound when Claude Code stops executing. Useful when you're multitasking and want to know when Claude has finished.

## Platform Support

| Platform | Sound Player | Default Sound |
|----------|--------------|---------------|
| macOS | `afplay` | Glass.aiff |
| Linux | `paplay`, `aplay`, or `mpv` | freedesktop complete.oga |
| Windows | PowerShell | chimes.wav |

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

Remove the `Stop` hook from `~/.claude/settings.json`, or restore from the backup:

```bash
mv ~/.claude/settings.json.backup ~/.claude/settings.json
```

## Customizing the sound

Edit `~/.claude/settings.json` and change the sound command.

**macOS system sounds:**
- `/System/Library/Sounds/Glass.aiff` (default)
- `/System/Library/Sounds/Ping.aiff`
- `/System/Library/Sounds/Pop.aiff`
- `/System/Library/Sounds/Submarine.aiff`
- `/System/Library/Sounds/Hero.aiff`

**Windows sounds:**
- `C:\Windows\Media\chimes.wav` (default)
- `C:\Windows\Media\notify.wav`
- `C:\Windows\Media\tada.wav`

**Linux:** Use any `.oga`, `.wav`, or `.mp3` file with your preferred player.

## License

MIT
