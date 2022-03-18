# zsh

## Font for agnoster theme

[fonts/DroidSansMono at master · powerline/fonts](https://github.com/powerline/fonts/tree/master/DroidSansMono)

## Steps

- install ohmyzsh

  ```
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ```

- install plugins

```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## Extras

### zsh on Windows via MSYS2 from Git Bash

- Install Git for Windows
- Install `pacman` and extras; [Package management in Git for Windows (Git Bash)? - Stack Overflow](https://stackoverflow.com/questions/32712133/package-management-in-git-for-windows-git-bash) ; [Invalid signature, corrupt database · Issue #2058 · msys2/MSYS2-packages](https://github.com/msys2/MSYS2-packages/issues/2058)

```
curl https://raw.githubusercontent.com/msys2/MSYS2-packages/7858ee9c236402adf569ac7cff6beb1f883ab67c/pacman/pacman.conf -o /etc/pacman.conf
for f in pacman-5.2.2-4-x86_64 pacman-mirrors-20201028-1-any msys2-keyring-1~20201002-1-any;
 do curl https://repo.msys2.org/msys/x86_64/$f.pkg.tar.xz -o ~/Downloads/$f.pkg.tar.xz;
done



cd /
tar x --xz -vf ~/Downloads/msys2-keyring-1~20201002-1-any.pkg.tar.xz usr
tar x --xz -vf ~/Downloads/pacman-mirrors-20201028-1-any.pkg.tar.xz etc
tar x --xz -vf ~/Downloads/pacman-5.2.2-4-x86_64.pkg.tar.xz usr
mkdir -p /var/lib/pacman
pacman-key --init
pacman-key --populate msys2
pacman -Syu


URL=https://github.com/git-for-windows/git-sdk-64/raw/main
cat /etc/package-versions.txt | while read p v; do d=/var/lib/pacman/local/$p-$v;
 mkdir -p $d; echo $d; for f in desc files install mtree; do curl -sSL "$URL$d/$f" -o $d/$f;
 done; done


pacman-key --refresh-keys


pacman -S zsh
```

### Using both Git Bash and zsh on Windows

- After setting up zsh on Windows Terminal with `bash -c zsh` in the `.bashrc` file, I noticed that zsh is extremely slow within VSCode and freezes from time to time. There isn't much documentation on this, so I have fall back to using bash in VSCode for the time being.
- I will use zsh in Windows Terminal exclusively by adding `"commandline": "C:/Program Files/Git/bin/bash.exe --login switch-to-zsh.sh"` to my Windows Terminal settings.json.

### Powerlevel10k theme

- Configuring Powerlevel10k theme and DroidSansMono Nerd Font

  - [Awesome WSL / WSL2 Windows Terminal, zsh, oh-my-zsh, Powerlevel10k](https://www.the-digital-life.com/awesome-wsl-wsl2-terminal/)
  - [Nerd Fonts - Iconic font aggregator, glyphs/icons collection, & fonts patcher](https://www.nerdfonts.com/font-downloads)

## References

- [shell - How to run a script with Git bash with custom bashrc? - Stack Overflow](https://stackoverflow.com/questions/22269023/how-to-run-a-script-with-git-bash-with-custom-bashrc)
