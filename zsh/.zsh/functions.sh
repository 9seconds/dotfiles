#!/usr/bin/env zsh

reswap() {
    sudo swapoff -a && sudo swapon -a
}
