#!/usr/bin/env bash

if pgrep -x "obs" 1> /dev/null; then
  echo "OBS"
else
  echo ""
fi
