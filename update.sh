#!/bin/bash
function bash
{
    echo taking backup of bashrc
    cp ~/.bashrc bash/bashrc
}
function zsh
{
    echo taking backup of zshrc
    cp ~/.zshrc zsh/zshrc 
    cp ~/.zprofile zsh/zprofile
}
function xinit
{
    echo taking backup of xinitrc
    cp ~/.xinitrc xinit/xinitrc
}
function conky
{
    echo taking backup of conky config
    rm -rf conky/conky
    cp -r ~/.conky conky/conky
    cp ~/.conkyrc conky/conkyrc
}
function xmonad
{
    echo taking backup of xmonad config
    cp ~/.xmonad/xmonad.hs xmonad/xmonad.hs
}
function vim
{
    echo taking backup of vim config
    rm -rf vim/vim
    cp -r ~/.vim vim/vim
    cp ~/.vimrc vim/vimrc
}
function openbox
{
    echo taking backup of openbox config
    cp -r ~/.config/openbox openbox
}
function x
{
    echo taking backup of Xdefaults
    cp ~/.Xdefaults x/Xdefaults 
}
function all
{
    bash
    zsh
    xinit
    xmonad
    vim
    openbox
    conky
    x
}
$1

