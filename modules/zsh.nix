{ config, pkgs, ... }:

{
  enable = true;

  oh-my-zsh = {
    enable = true;
    plugins =
      [ "git" "thefuck" "zsh-autosuggestions" "zsh-syntax-highlighting" ];
  };

  initExtra = ''
       # Enable colors and change prompt:
    autoload -U colors && colors
    PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

    # Custom Variables
    EDITOR=lvim

    # History in cache directory:
    HISTSIZE=10000
    SAVEHIST=10000
    HISTFILE=~/.cache/zshhistory
    setopt appendhistory

    # Basic auto/tab complete:
    autoload -U compinit
    zstyle ':completion:*' menu select
    zmodload zsh/complist
    compinit
    _comp_options+=(globdots)               # Include hidden files.

    # Custom ZSH Binds
    bindkey '^ ' autosuggest-accept

    ### functions for aliasrc

    # # ex - archive extractor
    # # usage: ex <file>
    ex ()
    {
        if [ -f $1 ] ; then
            case $1 in
                *.tar.bz2)   tar xjf $1   ;;
                *.tar.gz)    tar xzf $1   ;;
                *.tar.xz)    tar xJf $1   ;;
                *.bz2)       bunzip2 $1   ;;
                *.rar)       unrar x $1     ;;
                *.gz)        gunzip $1    ;;
                *.tar)       tar xf $1    ;;
                *.tbz2)      tar xjf $1   ;;
                *.tgz)       tar xzf $1   ;;
                *.zip)       unzip $1     ;;
                *.Z)         uncompress $1;;
                *.7z)        7z x $1      ;;
                *)           echo "'$1' cannot be extracted via ex()" ;;
            esac
        else
            echo "'$1' is not a valid file"
        fi
    }

    gt-push() {
        git add .
        git commit -m "$*"
        git pull
        git push
    }

    pack_man(){
        if [ -x "$(command -v apk)" ];then
            alias pkm='sudo apk add --no-cache '
            elif [ -x "$(command -v apt-get)" ];then
            alias pkm='sudo apt install '
            alias rpkm='sudo apt remove'
            alias cleanup='sudo apt autoremove'
            alias packdate='sudo apt -y update && flatpak -y --noninteractive update'
            elif [ -x "$(command -v dnf)" ];then
            alias pkm='sudo dnf install '
            alias rpkm='sudo dnf remove '
            alias cleanup='sudo dnf -y autoremove'
            alias packdate='sudo dnf -y upgrade --refresh'
            elif [ -x "$(command -v zypper)" ];then
            alias pkm='sudo zypper install '
            elif [ -x "$(command -v paru)" ];then
            alias pkm="paru -S "
            alias rpkm='paru -Rdd'
            alias pacman-update='sudo pacman-mirrors --geoip'
            alias cleanup='sudo pacman -Rns (pacman -Qtdq) && paru -Yc' # Cleanup orphaned packages
            alias fixpacman="sudo rm /var/lib/pacman/db.lck"
            alias pkmgrade='paru --noconfirm -Syu && sudo flatpak -y --noninteractive update'
            # get fastest mirrors
            alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
            alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
            alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
            alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
        else
            echo 'This Distro is not supported!'
        fi
    }

    pack_man
    export ex

    ### End of functions

    # Include all aliases
    [ -f /etc/nixos/configs/aliasrc ] && source /etc/nixos/configs/aliasrc

    # starship
    eval "$(starship init zsh)"
  '';
}
