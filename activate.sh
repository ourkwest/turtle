#!/usr/bin/env bash

TARGET=~/.bash_profile
COMMENT='# Added by turtle.'

if [ ! -f "$TARGET" ]; then
    touch "$TARGET"
fi

if grep -qe "$COMMENT" "$TARGET"; then
    echo "Already activated."
  else
    echo "source ~/.turtle/bash_profile $COMMENT" >> "$TARGET"
    echo "Activated."
fi
