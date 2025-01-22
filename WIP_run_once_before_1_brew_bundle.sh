#!/usr/bin/env bash
# Install CLI applications from Brewfile.

brew bundle --file $(dirname "$(chezmoi source-path)")/Brewfile
