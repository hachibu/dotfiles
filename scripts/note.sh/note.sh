#!/usr/bin/env bash

NOTE_DIR="$HOME/.note.sh"
TODAYS_NOTE="$NOTE_DIR/$(date +'%Y-%m-%d').md"

mkdir -p "$NOTE_DIR"
$EDITOR "$TODAYS_NOTE"
