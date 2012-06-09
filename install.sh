#!/bin/bash
function bash
{
    echo installing bashrc
    ln -s bash/bashrc ~/.bashrc
}
function zsh
{
    echo installing zshrc
    ln -s zsh/zshrc ~/.zshrc
    ln -s zsh/zprofile ~/.zprofile
}
function xinit
{
    echo installing xinitrc
    ln -s xinit/xinitrc ~/.xinitrc
}
function conky
{
    echo installing conky config
    mkdir -p ~/.conky
    ln -s -r conky/conky/* ~/.conky
    ln -s conky/.conkyrc ~/

}
function xmonad
{
    echo installing xmonad config
    mkdir -p ~/.xmonad
    ln -s xmonad/xmonad.hs ~/.xmonad/xmonad.hs
}
function vim
{
    echo installing vim config
    ln -s -r vim/vim ~/.vim
    ln -s vim/vimrc ~/.vimrc
}
function openbox
{
    echo installing openbox config
    mkdir -p ~/.config
    ln -s -r openbox/openbox ~/.config/
}
function x
{
    echo installing Xdefaults
    ln -s x/Xdefaults ~/.Xdefaults
}
function all
{
	bash
	zsh
	xinit
	conky
	xmonad
	vim
	openbox
	x
}
$1


