# https://macos-defaults.com/

# show hidden files permanently
defaults write com.apple.finder AppleShowAllFiles -boolean true; killall Finder;

# dock animation time 0
defaults write com.apple.dock "autohide-time-modifier" -float "0" && killall Dock

# dock autohide delay 0
defaults write com.apple.dock "autohide-delay" -float "0" && killall Dock

# dock minimize effect scale
defaults write com.apple.dock "mineffect" -string "scale" && killall Dock