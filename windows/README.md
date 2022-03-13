# Dotfiles

Work in Progress.   

## Windows Powershell
Install Monokai theme

1. Install [Scoop](https://github.com/lukesampson/scoop)
2. Install [concfg](https://github.com/lukesampson/concfg)
3. Import monokai
```
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
scoop install concfg
concfg import monokai
```
## Notepad++

Plugins:
+ Monokai syntax highlighting
+ Markdown Viewer++; [Zenburn syntax highlighting](https://github.com/Edditoria/markdown-plus-plus)
+ Explorer

# todo
1. write alias.ps1
2. write install-profile.ps1 for easy install
3. dotfiles for bash
4. dotfiles for atom
