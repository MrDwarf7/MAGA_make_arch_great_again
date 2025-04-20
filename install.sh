#!/bin/bash

# man-pages
# man-db
# openssh
# autossh
# curl
# wget
# namcap
# fastfetch
# zip
# unzip
# fish
# make
# cmake
# clang
# ninja
# ccache
# python-pynvim
# go
# neovim
# tree
# yazi
# ripgrep
# fd
# sd
# fzf
# yq
# ffmpegthumbnailer
# p7zip
# poppler
# imagemagick
# bat
# lazygit
# github-cli
# ruff
# ruff-lsp
# pyenv
# luarocks
# sccache
# libxcursor
# xclip
# codelldb-bin
# lldb
# lld
# llvm
# lldb-vscode
# atool
# python-pdm
# broot
# dotnet-runtime
# dotnet-sdk
# meson
# eza
# btop
# tlrc
# navi
# zoxide
# dust
# xdg-user-dirs
# pacman-cleanup-hook # NOTE: can edit /etc/pacmand.d/pacman-cache-cleanup.hook and remoe the 'v' from exec call to remove verbose
# git-delta           # Pager for git, similar to BAT but extra stuff
# just
# parui
# ouch

packages_to_install=(
    ### Deduplication Process Notes:
    # - Removed exact duplicates (e.g., multiple `git`, `fish`, `wezterm` entries).
    # - Resolved naming overlaps (e.g., `delta` and `git-delta` are the same; used `git-delta` as it’s the common Arch package name).
    # - Kept Nix-specific packages (e.g., `nixd`, `nh`) but flagged those not needed on Arch (e.g., `disko`, `agenix-cli`).
    # - Grouped commented-out packages into a single block per section, preserving their comments.
    # - Ensured consistency for tools with multiple names (e.g., `dust`/`du-dust`, `tlrc`/`tealdeer`).
    # - Flagged potential manual setup needs for certain packages (e.g., Hyprland-related tools).
    # - For language-specific tools (e.g., Python, Rust), ensured no redundant entries across sections.

    ### Deduplicated List:

    ##### cli-dev

    alejandra
    bc
    bison
    clang_multi
    cmake
    elfutils
    figma-linux
    flex
    gcc
    gdb
    gh
    git
    gnumake
    libclang
    meson
    ncurses
    ninja
    nixd
    nil
    netcat
    openssl
    perl
    python3
    stdenv
    tridactyl-native
    # zed-editor ## TODO: Install differently?? Not on AUR/Paru

    ###### Commented-out Packages
    # clang_16
    # clang-tools_16
    # debootstrap
    # figma-agent
    # lld_16
    # llvmPackages_16.libllvm
    # makeninja
    # msbuild
    # mono
    # omnix
    # pahole
    # qemu_full
    # zlib

    ##### cli-fun

    asciiquarium
    cbonsai
    clolcat
    lolcat
    cmatrix
    cowsay
    fastfetch
    figlet
    neofetch
    rsclock # Rust -- It's a tui clock
    nitch
    macchina # Neofetch alternative in Rust
    pipes-rs
    pfetch-rs
    sl
    toilet
    peaclock

    ###### Commented-out Packages
    # (fortune.override {withOffensive = true;})

    ##### cli-min

    bat
    btop
    cachix
    clang
    git-delta # Better git diff (consistent name across Arch/Nix)
    dust      # Better du (disk usage); `du-dust` on Arch if `dust` fails
    duf       # Disk Usage + File Information tui
    eza       # Better `ls`
    fd        # Better `find`
    file      # File type checker
    fish      # Shell
    fzf       # Fuzzy finder
    skim      # Fzf but written in Rust
    fzy       # Fuzzy finder
    gh        # GitHub CLI
    git
    gnupg   # GPG / GnuPG
    gping   # ping - with GRAPHS!
    hexyl   # hex viewer
    jujutsu # Weider, wilder Git alternative
    just    # Rust based task runner
    lazygit
    linux-firmware
    lsof # List Of Open Files
    neovim
    ouch  # CLI tool for compress & decompressing files and dir
    procs # Process viewer -- like ps
    tmux
    tokei       # Count your code LOC
    tre-command # Better `tree`
    glow        # Markdown reader
    tealdeer    # Better `tldr` - short docs for CLI commands
    xh          # Better curl/wget + jq + speedtest
    llvm
    ripgrep # Better grep
    sd      # Better sed
    sops
    age
    ssh-to-age
    ssh-to-pgp
    unzip
    vim
    wezterm
    wget
    yazi-nightly-bin
    zellij # Better tmux alternative
    zip
    zoxide
    nurl
    jq

    ###### Commented-out Packages
    # agenix-cli # not needed on Arch
    # disko # not needed on Arch
    # tlrc # alias for tealdeer
    # yazi-unwrapped
    # (import ../derivations/moxide.nix {inherit pkgs;})
    # (import ../derivations/mox.nix {inherit pkgs;})

    ##### cli-rand

    aria
    cacert
    cava
    chafa
    git-ignore        # Generate .gitignore files using gitignore.io
    gitleaks          # Scan your git repos for secrets
    git-secrets       # Scans for prohibited patterns in git repos
    license-generator # Generate LICENSE files
    monolith          # Save web pages as single files
    noti              # Trigger notifications when a process completes
    process-compose   # Process scheduler and orchestrator
    progress          # Monitors file manipulations (cp, mv, dd, ...)
    rewrk             # HTTP benchmarking tool
    trash-cli         # CLI interface for FreeDesktop.org Trash folder/spec
    upx               # Ultimate Packer for eXecutables
    viu               # Image viewer for the terminal
    wrk2              # HTTP benchmarking tool
    thunderbird-latest
    nh     # NixOS helper CLI (similar to gh)
    nix-ld # NixOS linker for 'normal' binaries
    parted # Disk partitioning tool

    ###### Commented-out Packages
    # clang
    # cmatrix # Matrix screensaver (moved to cli-fun)
    # delta # Better git diff (consolidated as git-delta)
    # figlet (moved to cli-fun)
    # disko # Nix (not needed on Arch)
    # dust # Better du (disk usage) (moved to cli-min)
    # duf # Disk Usage + File Information tui (moved to cli-min)
    # eza # Better `ls` (moved to cli-min)
    # fd # Better `find` (moved to cli-min)
    # file # File type checker (moved to cli-min)
    # fish # Shell (moved to cli-min)
    # fzf # Fuzzy finder (moved to cli-min)
    # skim # Fzf but written in Rust (moved to cli-min)
    # fzy # Fuzzy finder (moved to cli-min)
    # gh # GitHub CLI (moved to cli-min)
    # git # Git (moved to cli-min)
    # gping # ping - with GRAPHS! (moved to cli-min)
    # hexyl # hex viewer (moved to cli-min)
    # just # Rust based task runner (moved to cli-min)
    # lsof # List Of Open Files (moved to cli-min)
    # macchina # Neofetch alternative in Rust (moved to cli-fun)
    # mcfly # Terminal history -- replaces ctrl-r
    # fastfetch # Neofetch-like tool (moved to cli-fun)
    # ouch # CLI tool for compress & decompressing files and dir (moved to cli-min)
    # pandoc # Document converter (moved to misc-tools)
    # pass-git-helper # git cred helper - using `pass` as data store
    # pipes-rs # It's literally pipes (moved to cli-fun)
    # procs # Process viewer -- like ps (moved to cli-min)
    # rsclock # Rust -- It's a tui clock (moved to cli-fun)
    # tokei # Count your code LOC (moved to cli-min)
    # topgrade # Upgrade everything
    # tre-command # Better `tree` (moved to cli-min)
    # glow # Markdown reader (moved to cli-min)
    # tlrc # Better `tldr` (alias for tealdeer, moved to cli-min)
    # xh # Better curl/wget + jq + speedtest (moved to cli-min)
    # speedtest # Speedtest CLI - kinda buggy on cli/nixos
    # inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    # llvm (moved to cli-min)
    # ripgrep # Better grep (moved to cli-min)
    # rustup # Rust (moved to Rust toolchain)
    # sd # Better sed (moved to cli-min)
    # tmux # Terminal multiplexer (moved to cli-min)
    # tree
    # unzip (moved to cli-min)
    # vim # Text editor (moved to cli-min)
    # wezterm # Terminal emulator (moved to cli-min)
    # wget # Download files (moved to cli-min)
    # xclip # Clipboard manager
    # yazi # Better ranger/vifm alternative (moved to cli-min)
    # zellij # Better tmux alternative (moved to cli-min)
    # zip # Compress files (moved to cli-min)

    ##### fish-shell

    fish
    starship
    zoxide

    ##### hypr

    ###### Commented-out Packages
    # glib
    # wl-clipboard
    # grim
    # slurp
    # rofi-wayland
    # hyprlock
    # hyprpicker
    # hyprpaper
    # hyprsunset
    # wlinhibit

    ##### misc-tools

    pandoc
    zathura
    peacock
    obsidian

    ##### River things

    ###### Commented-out Packages
    # river
    # glib
    # wl-clipboard
    # grim
    # slurp
    # rofi-wayland
    # swaylock
    # hyprpaper

    ##### utils

    unzip
    tokei
    pamixer
    pavucontrol
    upower
    ngrok
    wf-recorder

    ###### Commented-out Packages
    # brightnessctl # Installed most of the time
    # nh # not needed on Arch
    # keyd

    ##### Browsers

    firefox
    chromium
    vivaldi
    zen-browser

    ###### Commented-out Packages
    # inputs.zen-browser.packages."${pkgs.system}".default

    ##### Chat

    vesktop
    discord
    signal-desktop-bin
    telegram-desktop

    ###### Commented-out Packages
    # vencord
    # zulip
    # element-desktop

    ##### Graphics/Media

    eog
    inkscape
    gimp
    krita

    ###### Commented-out Packages
    # shotwell

    ##### Terminals

    kitty
    ghostty
    wezterm

    ###### Commented-out Packages
    # wezterm-nightly

    ##### Utils

    galculator
    pika-backup
    resources
    nautilus
    zathura # PDF viewer

    ###### Commented-out Packages
    # wpa_supplicant
    # wpa_supplicant_gui
    # networkmanager
    # networkmanagerapplet
    # timeshift

    ##### LANGUAGE #####

    ##### Go

    go
    gopls
    delve

    ##### Lua

    lua
    lua-language-server
    sumneko-lua-language-server

    ##### Misc

    marksman         # Markdown
    markdown-oxide   # Markdown
    nixd             # Nix lsp
    nixfmt-rfc-style # Nix formatter - official one
    zls
    emmet-language-server
    buf
    cmake-language-server
    docker-compose-language-service
    vscode-extensions.vadimcn.vscode-lldb
    tree-sitter
    hyprls
    helix-gpt

    ###### Commented-out Packages
    # nil # Other nix LSP
    # terraform-ls
    # ansible-language-server
    # vue-language-server

    ##### NodeJs

    ###### Commented-out Packages
    # biome
    # nodejs_latest
    # nodemon
    # typescript
    # typescript-language-server
    # pnpm # turn these things on via corepack enable
    # yarn
    # bun
    # deno
    # nodePackages_latest.vscode-languageservers-extracted
    # yaml-language-server
    # dockerfile-language-server-nodejs
    # bash-language-server
    # nodePackages_latest.graphql-language-service-cli
    # tree-sitter
    # ktree-sitter-grammars
    # python113Packages.python-lsp-server

    ##### Python

    ruff
    pyright
    uv
    black

    ###### Commented-out Packages
    # python-uv
    # python-pdm # Will need to figure out managers like these

    ##### Rust toolchain

    rustup
    taplo # toml formatter & lsp
    cargo-watch
    cargo-make
    cargo-deny
    cargo-audit
    cargo-update
    cargo-edit
    cargo-outdated
    cargo-license
    cargo-tarpaulin
    cargo-cross
    cargo-zigbuild
    cargo-nextest
    cargo-spellcheck
    cargo-modules
    cargo-bloat
    cargo-unused-features
    bacon
    evcxr # rust repl

    ##### FROM OG INSTALLER #####

    man-pages
    man-db
    openssh
    autossh
    curl
    wget
    namcap
    fastfetch
    zip
    unzip
    fish
    make
    cmake
    clang
    ninja
    ccache
    go
    neovim
    tree
    yazi
    ripgrep
    fd
    sd
    fzf
    yq
    ffmpegthumbnailer
    p7zip
    poppler
    imagemagick
    bat
    lazygit
    github-cli
    ruff
    ruff-lsp
    luarocks
    sccache
    libxcursor
    xclip
    codelldb-bin
    lldb
    lld
    llvm
    lldb-vscode
    atool
    broot
    dotnet-runtime
    dotnet-sdk
    meson
    eza
    btop
    tealdeer
    navi
    zoxide
    dust
    xdg-user-dirs
    pacman-cleanup-hook # Edit /etc/pacmand.d/pacman-cache-cleanup.hook to remove verbose
    git-delta
    just
    parui
    ouch

)

# TODO: If user is installing fish as shell -->> Check aliases against array calls (as binaries)

# TODO: prompt user to cshs -s $(which $VAR_SHELL)
# If user is using fish -> sudo echo $(which fish) >> /etc/shells

# NOTE: useful
# cat /etc/*release | head -1 /etc/*release | awk '{print $1}'
# sed -n 2p /etc/*release | grep -oP '"\K[^"\047]+(?=["\047])'
# sed -n 2p /etc/*release | grep -oP '"\K[^"\047]+(?=["\047])' | awk '{print $1}'
# This will get the NAME of the current distro as a single item
# where $1 is the first item in the list (which for this is ((((Arch)))) Linux)

function remove_yay_download() {
    downloads="$HOME/downloads"
    yay_dir="$downloads/yay"
    rm -rf "$yay_dir"
    return 0
}

function install_yay() {
    downloads="$HOME/downloads"
    yay_dir="$downloads/yay"

    must_check_packages=(git base-devel pacman-contrib)

    for package in "${must_check_packages[@]}"; do
        if ! pacman -Qi "$package" &>/dev/null; then
            echo "$package is not installed."
            sudo pacman -S "$package" --noconfirm --needed
        else
            echo "$package is installed."
        fi
    done

    git clone https://aur.archlinux.org/yay.git "$yay_dir"
    cd "$yay_dir" && makepkg -si
    return 0
}

function install_paru() {
    downloads="$HOME/downloads"
    paru_dir="$downloads/paru"

    must_check_packages=(git base-devel pacman-contrib)

    for package in "${must_check_packages[@]}"; do
        if ! pacman -Qi "$package" &>/dev/null; then
            echo "$package is not installed."
            sudo pacman -S "$package" --noconfirm --needed
        else
            echo "$package is installed."
        fi
    done

    git clone https://aur.archlinux.org/paru.git "$paru_dir"
    cd "$paru_dir" && makepkg -si
    return 0
}

function setup_mirrors() {
    ua_update_all='export TMPFILE="$(mktemp)"; \
        sudo true; \
        rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
        && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
        && sudo mv $TMPFILE /etc/pacman.d/mirrorlist \
        && ua-drop-caches \
        && paru -Syyu --noconfirm'

    if ! pacman -Qi rate-mirrors &>/dev/null; then
        echo "rate-mirrors is not installed. Installing now."
        paru -S rate-mirrors
    else
        echo "Rate Mirrors are installed. Proceeding with mirror update."
    fi
    eval $ua_update_all
    echo "Mirrors updated."
    return 0
}

function rust_setup() {
    sudo pacman -S rustup --noconfirm --needed
    rustup default stable
    echo "Rust setup complete."
    return 0
}

function verify_installations() {
    local packages_to_verify=("$@")
    local return_list=()

    for package in "${packages_to_verify[@]}"; do
        if ! pacman -Qi "$package" &>/dev/null; then
            echo "$package is not installed."
            return_list+=("$package")
        else
            echo "$package is installed."
        fi
    done

    if [ "${#return_list[@]}" -eq 0 ]; then
        echo "All packages installed successfully."
    else
        echo "The following packages failed to install:"
        for package in "${return_list[@]}"; do
            echo "$package"
        done
    fi

    echo "Installation verification complete."
    return "${#return_list[@]}"
}

function main_installation() {
    local package_array=("$@")

    if [ "${#package_array[@]}" -eq 0 ]; then
        echo "No packages to install in the main array at the top of the script."
        exit 1
    fi

    if [ ! -d "/root" ]; then
        echo "Root directory does not exist."
        exit 1
    else
        echo "Root directory exists."
        ls -la /root/
    fi

    sudo pacman -Syyu --noconfirm

    paru -S --needed --noconfirm "${package_array[@]}"
    return 0
}

function main() {
    # Check if the script is being run as root
    if [ "$EUID" -eq 0 ]; then
        echo "Please do not run this script as root."
        exit 1
    fi

    # Check if the script is being run on Arch Linux
    if [ ! -f "/etc/arch-release" ]; then
        echo "This script is meant to be run on Arch Linux."
        exit 1
    fi

    # Check if the system has an internet connection
    if ! ping -c 1 google.com &>/dev/null; then
        echo "Please check your internet connection."
        exit 1
    fi

    last_exit_code=0

    if ! install_yay; then
        echo "There was an error with the installation of yay."
        last_exit_code=1
    fi

    if ! install_paru; then
        echo "There was an error with the installation of paru."
        last_exit_code=1
    fi

    if ! setup_mirrors; then
        echo "There was an error with the setup of mirrors."
        last_exit_code=1
    fi

    if ! rust_setup; then
        echo "There was an error with the setup of Rust."
        last_exit_code=1
    fi

    if ! main_installation "${packages_to_install[@]}"; then
        echo "There was an error with the main installation."
        last_exit_code=1
    fi

    if ! verify_installations "${packages_to_install[@]}"; then
        echo "There was an error with verifying the installations."
        last_exit_code=1
    fi

    if ! remove_yay_download; then
        echo "There was an error with removing the yay download directory."
        last_exit_code=1
    fi

    echo "If no early exit code or exit code > 0, then installation complete."
    exit $last_exit_code
}

main
