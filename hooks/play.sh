#!/usr/bin/env bash
# Play a notification sound for a Claude Code hook event.
# Usage: play.sh <event>   where <event> is "stop" or "notification".
# Always exits 0 — must never block Claude Code.

event="$1"

play_mac() {
  if [ "$event" = "stop" ]; then
    afplay /System/Library/Sounds/Glass.aiff >/dev/null 2>&1
  else
    afplay /System/Library/Sounds/Funk.aiff >/dev/null 2>&1
  fi
}

play_linux() {
  if [ "$event" = "stop" ]; then
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null \
      || aplay /usr/share/sounds/sound-icons/glass-water-1.wav 2>/dev/null \
      || mpv --really-quiet /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null \
      || printf '\a'
  else
    paplay /usr/share/sounds/freedesktop/stereo/message.oga 2>/dev/null \
      || aplay /usr/share/sounds/sound-icons/prompt.wav 2>/dev/null \
      || mpv --really-quiet /usr/share/sounds/freedesktop/stereo/message.oga 2>/dev/null \
      || printf '\a'
  fi
}

play_windows() {
  if [ "$event" = "stop" ]; then
    powershell -c "(New-Object Media.SoundPlayer 'C:/Windows/Media/chimes.wav').PlaySync()" >/dev/null 2>&1
  else
    powershell -c "(New-Object Media.SoundPlayer 'C:/Windows/Media/notify.wav').PlaySync()" >/dev/null 2>&1
  fi
}

case "$(uname -s)" in
  Darwin)              play_mac ;;
  Linux)               play_linux ;;
  MINGW*|MSYS*|CYGWIN*) play_windows ;;
  *)                   printf '\a' ;;
esac

exit 0
