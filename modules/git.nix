{ config, pkgs, ... }:

{
  enable = true;
  # aliases = {
  #   lg1 =
  #     "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
  #   lg2 =
  #     "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
  #   lg = "!git lg1";
  # };
  text = ''
    [user]
    	email = floork@gmx.de
    	name = floork
    [filter "lfs"]
    	clean = git-lfs clean -- %f
    	smudge = git-lfs smudge -- %f
    	process = git-lfs filter-process
    	required = true
    [core]
    	autocrlf = input
    	excludesFile = /home/flmr799e/.gitignore_global
    	editor = vim
    [credential "https://github.com"]
    	helper =
    	helper = !/usr/bin/gh auth git-credential
    [credential "https://gist.github.com"]
    	helper =
    	helper = !/usr/bin/gh auth git-credential
  '';
  # [alias]
  # lg1 = log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
  # lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
  # lg = !"git lg1"
  # commiCount = rev-list --count
}
