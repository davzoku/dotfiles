# Dotfiles

Work in Progress

## Modular Installation

This repository contains multiple scripts that can be copied and used directly in various environment such as MacOS, Linux, Windows and Android.

### Bash settings

Set up ble.sh for bash

```
curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf -
bash ble-nightly/ble.sh --install ~/.local/share
echo 'source -- ~/.local/share/blesh/ble.sh' >> ~/.bashrc
```

### Vimrc Settings

```
curl -o ~/.vimrc https://raw.githubusercontent.com/davzoku/dotfiles/master/.vimrc
```

### Claude Settings

To replace local claude settings and use immediately:

```
curl -fsSL https://raw.githubusercontent.com/davzoku/dotfiles/master/.claude/replace_local_claude_settings.sh | bash
```

### Termux Settings

```
curl -o ~/.termux/colors.properties https://raw.githubusercontent.com/davzoku/dotfiles/master/termux/colors.properties && termux-reload-settings
```
