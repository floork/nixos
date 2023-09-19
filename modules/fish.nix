{ config, pkgs, ... }:

let aliasConfig = import /etc/nixos/modules/alias.nix;
in {
  enable = true;

  package = pkgs.fish;

  plugins = [{
    name = "foreign-env";
    src = pkgs.fetchFromGitHub {
      owner = "oh-my-fish";
      repo = "plugin-foreign-env";
      rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
      sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
    };
  }];

  shellInit = ''
    # My fish config. Not much to see here; just some pretty standard stuff.
    set -e fish_user_paths
    set -U fish_user_paths $HOME/.local/bin $HOME/Applications $fish_user_paths

    set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
    set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

    for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
      if test -d $flatpakdir
        contains $flatpakdir $PATH; or set -a PATH $flatpakdir
      end
    end

    set -gx PATH "$HOME/.cargo/bin" $PATH
    set fish_greeting ""
    set TERM xterm-256color
    set -Ux EDITOR vim

    ### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
    set fish_color_normal brcyan
    set fish_color_autosuggestion '#7d7d7d'
    set fish_color_command brcyan
    set fish_color_error '#ff6c6b'
    set fish_color_param brcyan

    ### FUNCTIONS ###

    function frm
        read -p "Are you sure you want to delete? (y/n): " -l response
        if test "$response" = "y" -o "$response" = "Y"
            command rm -rf $argv
        else
            echo "Aborted."
        end
    end

    function sudo_prev_command
        eval (history --search-backward "")
    end

    ### END OF FUNCTIONS ###

    alias reload='source ~/.config/fish/config.fish'
    alias frm=frm
    alias ex=extract
    alias !!=sudo_prev_command

    # Include all aliases
    [ -f /etc/nixos/configs/aliasrc ] && source /etc/nixos/configs/aliasrc

    # add home-manager to path
    export PATH="$HOME/.nix-profile/bin:$PATH"

    ### SETTING THE STARSHIP PROMPT ###
    starship init fish | source
  '';
}

