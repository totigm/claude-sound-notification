# Claude Code Sound Notifications

Get audio notifications from Claude Code. Different sounds for when Claude finishes a task vs when it needs your input.

## Install

Inside Claude Code:

```
/plugin marketplace add totigm/claude-sound-notification
/plugin install claude-sound-notification@claude-sound-notification
/reload-plugins
```

(For local development, point `marketplace add` at the cloned directory instead of the GitHub slug.)

## What it does

Plays different sounds for two events:
- **Task complete** (`Stop`) — Claude finished working.
- **Needs input** (`Notification`) — Claude is asking for permission or user input.

This way you know whether to just check results or go respond.

## Platform Support

| Platform | Player                         | Task Complete | Needs Input  |
|----------|--------------------------------|---------------|--------------|
| macOS    | `afplay`                       | Glass.aiff    | Funk.aiff    |
| Linux    | `paplay` → `aplay` → `mpv`     | complete.oga  | message.oga  |
| Windows  | PowerShell `Media.SoundPlayer` | chimes.wav    | notify.wav   |

The plugin auto-detects your OS at runtime. Falls back to the terminal bell (`\a`) if nothing else works.

### Linux audio players

Install one of these on Linux:

```bash
# Ubuntu/Debian — PulseAudio
sudo apt install pulseaudio-utils

# Or ALSA
sudo apt install alsa-utils

# Or mpv
sudo apt install mpv
```

### Windows

Run Claude Code under **Git Bash**, **WSL**, or **MSYS2** so the hook's `bash` shebang resolves. PowerShell is used internally to play sounds.

## Uninstall

Inside Claude Code:

```
/plugin uninstall claude-sound-notification
```

The plugin does not modify `~/.claude/settings.json`, so uninstall is clean — nothing to undo by hand.

## Customizing the sound

Edit `hooks/play.sh` in your local clone, then push to your own fork and install from there:

```
/plugin marketplace add <your-github-user>/claude-sound-notification
/plugin install claude-sound-notification@claude-sound-notification
```

Suggested sound files to drop in:

**macOS system sounds:** `Glass.aiff` · `Funk.aiff` · `Pop.aiff` · `Submarine.aiff` · `Hero.aiff` (all under `/System/Library/Sounds/`).

**Windows sounds:** `chimes.wav` · `notify.wav` · `tada.wav` · `ding.wav` (all under `C:\Windows\Media\`).

**Linux:** any `.oga`, `.wav`, or `.mp3` file your chosen player supports.

## License

MIT
