# Dotfiles

Work in Progress

## Modular Installation

This repository contains multiple scripts that can be copied and used directly in various environment such as MacOS, Linux, Windows and Android.

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
