#!/bin/bash
function bash
{
    echo installing bashrc
    cp bash/bashrc ~/.bashrc
}
function zsh
{
    echo installing zshrc
    cp zsh/zshrc ~/.zshrc
    cp zsh/zprofile ~/.zprofile
}
function xinit
{
    echo installing xinitrc
    cp xinit/xinitrc ~/.xinitrc
}
function conky
{
    echo installing conky config
    mkdir -p ~/.conky
    cp -r conky/conky/* ~/.conky
    cp conky/.conkyrc ~/

}
function xmonad
{
    echo installing xmonad config
    mkdir -p ~/.xmonad
    cp xmonad/xmonad.hs ~/.xmonad/xmonad.hs
}
function vim
{
    echo installing vim config
    cp -r vim/vim ~/.vim
    cp vim/vimrc ~/.vimrc
}
function openbox
{
    echo installing openbox config
    mkdir -p ~/.config
    cp -r openbox/openbox ~/.config/
}
function x
{
    echo installing Xdefaults
    cp x/Xdefaults ~/.Xdefaults
}


