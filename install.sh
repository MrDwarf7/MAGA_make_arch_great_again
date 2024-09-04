#! /bin/bash

packages_to_install=(
    man-pages # Note this comes with the normal version of Arch via linux and linux-base etc.
    man-db
    openssh
    autossh
    curl
    wget
    # reflector
    namcap
    fastfetch
    zip
    unzip
    # zsh
    fish
    make
    cmake
    clang
    ninja
    ccache
    python-pynvim
    go
    nvim
    tree
    yazi
    # ranger
    ripgrep
    fd
    sd
    fzf
    # tmux
    bat
    lazygit
    # lazydocker # can also consider using lazydocker-bin, as it seems more frequently updated
    # docker
    # docker-buildx
    # docker-compose
    github-cli
    # uctags-git
    # python-pipx
    ruff
    ruff-lsp
    pyenv
    luarocks
    # nvim-treesitter-parsers-git
    sccache
    # mingw-w64-rust #######################################################
    libxcursorh
    # win32yank-bin
    xclip
    codelldb-bin
    lldb
    lld
    llvm
    lldb-vscode
    atool
    # lynx
    python-pdm
    broot
    dotnet-runtime
    dotnet-sdk # current at time of writing - 8.0~
    # cmake-init  # install via yay, then install it INTO the pyenv env using ITS VERSION of pip
    meson
    eza
    # oh-my-posh
    tlrc # tldr (aka tldr-pages) client -- Rust version
    # eg the AUR package is heavily outdated (last updated: Sep 2022)
    navi
)

function install_yay() {
    $downloads="$HOME/downloads"

    $must_check_packages=(git base-devel pacman-contrib)

    for package in "${must_check_packages[@]}"; do
        if ! pacman -Qi "$package" &>/dev/null; then
            echo "$package is not installed."
            sudo pacman -S "$package"
        else
            echo "$package is installed."
        fi
    done

    git clone https://aur.archlinux.org/yay.git "$downloads/yay"
    cd yay && makepkg -si
    cd .. && rm -rf yay # Clean up yay directory after installation
    return 0
}





function setup_mirrors() {
    # check paccman output for if reflector exists
    # if not, install it
    # if yes, proceed with updating mirrors

    $ua_update_all='export TMPFILE="$(mktemp)"; \
        sudo true; \
        rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
        && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
        && sudo mv $TMPFILE /etc/pacman.d/mirrorlist \
        && ua-drop-caches \
        && yay -Syyu --noconfirm'

    if ! pacman -Qi rate-mirrors &>/dev/null; then
        echo "Reflector is not installed. Installing now."
        yay -S rate-mirrors
    else
        echo "Reflector is installed. Proceeding with mirror update."
    fi

    $ua_update_all
    echo "Mirrors updated."
    return 0
}


function rust_setup() {
    sudo pacman -S rustup
    rustup default stable
    echo "Rust setup complete."
    return 0
}

function verify_installations() {
    $packages_to_verify=$1
    $return_list=()

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
    return 0
}


### Main installation section
function main_installation() {
    local package_array=$1

    # check if the potential array is empty, if yes then exit
    if [ -z "$package_array" ]; then
        echo "No packages to install in the main array at top of script."
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

    # Check if the script is being run on a system with an internet connection
    if ! ping -c 1 google.com &>/dev/null; then
        echo "Please check your internet connection."
        exit 1
    fi

    $error_array=()
    $functions_to_run=(
        install_yay
        setup_mirrors
        main_installation "${packages_to_install[@]}"
        rust_setup
    )

    for func in "${functions_to_run[@]}"; do
        if ! "$func"; then
            echo "There was an error with $func."
            $error_array+=("$func")
        fi
        $func()
    else 
        
    done

    if [ "${#error_array[@]}" -eq 0 ]; then
        echo "All functions ran successfully."
        error_code=0
    else
        echo "The following functions failed to run:"
        for func in "${error_array[@]}"; do
            echo "$func"
        done
        error_code=1
    fi

    if [ $error_code -eq 1 ]; then
        echo "There was an error with the installation."
        echo "$error_code - Exiting."
        exit 1
    fi

    verify_installations("${packages_to_install[@]}")
    if [ "$?" -eq 1 ]; then
        echo "There was an error with the installation."
        echo "$error_code - Exiting."
        exit 1
    else
        echo "Installation complete."
    fi
}

main
