#!/bin/bash

# Set autohide-time-modifier to 0 for the Dock
defaults write com.apple.dock autohide-time-modifier -int 0

# Restart the Dock to apply changes
killall Dock
