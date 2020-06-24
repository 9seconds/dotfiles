#!/usr/bin/env zsh

aptup() {
    sudo apt update \
    && sudo apt full-upgrade --yes \
    && sudo apt autoremove --yes --purge \
    && sudo apt autoclean \
    && sudo snap refresh
}

brewup() {
    brew update && brew upgrade && brew cask upgrade --greedy && brew cleanup
}

purgeoldkernels() {
    # Purges old Ubuntu kernels
    # http://askubuntu.com/a/254585

    echo $(dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p') $(dpkg --list | grep linux-headers | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p') | xargs sudo apt-get -y purge
}

reswap() {
    sudo swapoff -a && sudo swapon -a
}
