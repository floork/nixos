{ config, pkgs, ... }:

{
  enable = true;
  settings = {
      add_newline = true;
      username = {
        format = " [╭─$user]($style)@";
        show_always = true;
        style_root = "purple bold dimmed";
        style_user = "purple bold dimmed";
        # disabled = true;  # disable in powershell
      };
      character = {
        success_symbol = " [╰─λ](cyan bold dimmed)";
        error_symbol = "[╰─X](cyan bold dimmed)";
      };
      hostname = {
        disabled = false;
        format = "[$hostname]($style) in ";
        ssh_only = false;
        style = "purple bold dimmed";
        trim_at = "-";
      };
      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        home_symbol = " ~";
        read_only_style = "cyan";
        read_only = "  ";
        format = "at [$path](cyan bold dimmed)[$read_only]($read_only_style) ";
      };
      shell = {
        cmd_indicator = "_";
        powershell_indicator = "PS";
        bash_indicator = "bash";
        fish_indicator = "";
        zsh_indicator = "zsh";
        unknown_indicator = "mystery shell";
        style = "cyan bold dimmed";
        disabled = false;
      };
      status = {
        disabled = true;
        format = "[\[$symbol$status_common_meaning$status_signal_name$status_maybe_int\]](cyan bold dimmed)";
        map_symbol = true;
        pipestatus = true;
        symbol = "🔴";
      };
      aws = {
        symbol = " ";
      };
      conda = {
        symbol = " ";
      };
      dart = {
        symbol = " ";
      };
      docker_context = {
        format = "via [ $context](bold blue) ";
      };
      elixir = {
        symbol = " ";
      };
      elm = {
        symbol = " ";
      };
      git_branch = {
        symbol = " ";
        format = "on [$symbol$branch]($style) ";
        truncation_length = 4;
        truncation_symbol = "…/";
        style = "bold green";
      };
      git_status = {
        format = "[\($all_status$ahead_behind\)]($style) ";
        style = "bold green";
        conflicted = "🏳";
        up_to_date = " ";
        untracked = " ";
        # ahead = "⇡${count}";
        # diverged = "⇕⇡${ahead_count}⇣${behind_count}";
        # behind = "⇣${count}";
        stashed = " ";
        modified = " ";
        staged = "[++\($count\)](green)";
        renamed = "襁 ";
        deleted = " ";
      };
      golang = {
        symbol = " ";
      };
      helm = {
        format = "via [ $version](bold purple) ";
      };
      hg_branch = {
        symbol = " ";
      };
      java = {
        symbol = " ";
      };
      julia = {
        symbol = " ";
      };
      kubernetes = {
        format = "on [ $context\($namespace\)](bold purple) ";
        disabled = false;
        context_aliases = {
          "clcreative-k8s-staging" = "cl-k8s-staging";
          "clcreative-k8s-production" = "cl-k8s-prod";
        };
      };
      nim = {
        symbol = " ";
      };
      nix_shell = {
        symbol = " ";
      };
      nodejs = {
        format = "via [ $version](bold green) ";
        disabled = true;
      };
      package = {
        symbol = " ";
      };
      perl = {
        symbol = " ";
      };
      php = {
        symbol = " ";
      };
      python = {
        symbol = " ";
        python_binary = "python3";
      };
      terraform = {
        format = "via [ terraform $version]($style) 壟 [$workspace]($style) ";
      };
      ruby = {
        format = "via [ $version]($style) ";
      };
      rust = {
        symbol = " ";
      };
      swift = {
        symbol = "ﯣ ";
      };
      vagrant = {
        format = "via [ vagrant $version]($style) ";
      };
    };

  }
