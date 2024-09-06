#!/bin/bash

packages_to_install=(
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
    python-pynvim
    go
    neovim
    tree
    yazi
    ripgrep
    fd
    sd
    fzf
    bat
    lazygit
    github-cli
    ruff
    ruff-lsp
    pyenv
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
    python-pdm
    broot
    dotnet-runtime
    dotnet-sdk
    meson
    eza
    btop
    tlrc
    navi
    zoxide
    dust
    xdg-user-dirs
    pacman-cleanup-hook # NOTE: can edit /etc/pacmand.d/pacman-cache-cleanup.hook and remoe the 'v' from exec call to remove verbose
    git-delta           # Pager for git, similar to BAT but extra stuff
    just
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
    #cd "$HOME" && rm -rf "$yay_dir" # Clean up yay directory after installation
    return 0
}

function setup_mirrors() {
    ua_update_all='export TMPFILE="$(mktemp)"; \
        sudo true; \
        rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
        && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
        && sudo mv $TMPFILE /etc/pacman.d/mirrorlist \
        && ua-drop-caches \
        && yay -Syyu --noconfirm'

    if ! pacman -Qi rate-mirrors &>/dev/null; then
        echo "rate-mirrors is not installed. Installing now."
        yay -S rate-mirrors
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

    yay -S --needed --noconfirm "${package_array[@]}"
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
