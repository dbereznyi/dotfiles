#!/usr/bin/sh
sudo pacman -Syu
sudo pacman -S \
    adobe-source-han-sans-jp-fonts \
    adobe-source-han-serif-jp-fonts \
    otf-ipafont \
    otf-ipaexfont \
    direnv \
    discord \
    fcitx5-im \
    gimp \
    htop \
    mpv \
    neovim \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    obs-studio \
    peek \
    qbittorrent \
    redshift \
    rust \
    rsync \
    strawberry \
    thunderbird \
    tmux \
    ttf-dejavu \
    ttf-droid \
    ttf-hanazono \
    ttf-inconsolata \
    ttf-liberation \
    ttf-sazanami \
    tree \
    xclip \
    yay \
    zig \
    zsh

sudo chsh -s /usr/bin/zsh

WHICHYAY="$(which yay)"
if [[ "$WHICHYAY" == *"not found" ]]; then
    sudo pacman -S git fakeroot binutils make gcc
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
else
    echo "yay is already installed, skipping..."
fi

yay -Syu
yay -S \
    brave-bin \
    fcitx5-mozc-ut \
    megasync-bin \
    nordvpn-bin \
    ttf-indi \
    ttf-ip \
    ttf-koruri \
    ttf-mona \
    ttf-monapo \
    ttf-mplus \
    ttf-vlgothic \
    youtube-dl

