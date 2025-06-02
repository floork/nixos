{ pkgs, ... }:

with pkgs;

let
  tools = [
    # C/C++
    cmake
    gnumake
    ninja
    meson
    gcc

    # JavaScript / TypeScript
    yarn

    # Misc tools
    ansible
    hugo
    lazygit
    vscode

    # python
    # poetry
    # pyenv
    # python311Packages.pip
    rye
    uv
  ];

  languages = [
    # embedded
    picocom

    # Go
    go

    # Java
    openjdk

    # JavaScript / TypeScript
    nodejs
    nodejs_20

    # Lua
    lua

    # Python
    python3

    # Rust
    rustup
    binutils
    openssl
    libiconv

    # SqLite
    sqlite

    # Zig
    zig
  ];

  neovimstuff = [
    neovim
    ripgrep
  ];

  lsp_formatting = [
    # Bash
    nodePackages.bash-language-server

    # C/C++
    clang-tools
    neocmakelsp

    # Go
    gopls

    # Lua
    luajitPackages.lua-lsp
    stylua

    # Misc
    vscode-langservers-extracted

    # Nix
    nil

    # Python
    # pyright
    # ty is currently installed via `uv tool install ty@latest`
    ruff

    # Tex
    texlab

    # zig
    zls
  ];
in

# Final merged list
tools ++ languages ++ neovimstuff ++ lsp_formatting
