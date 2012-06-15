#!/bin/bash
function bash
{
    echo installing bashrc
    ln -s `pwd`/bash/bashrc ~/.bashrc
}
function zsh
{
    echo installing zshrc
    ln -s `pwd`/zsh/zshrc ~/.zshrc
    ln -s `pwd`/zsh/zprofile ~/.zprofile
}
function xinit
{
    echo installing xinitrc
    ln -s `pwd`/xinit/xinitrc ~/.xinitrc
}
function conky
{
    echo installing conky config
    ln -s `pwd`/conky/conky ~/.conky
    ln -s `pwd`/conky/.conkyrc ~/

}
function xmonad
{
    echo installing xmonad config
    mkdir -p ~/.xmonad
    ln -s `pwd`/xmonad/xmonad.hs ~/.xmonad/xmonad.hs
}
function vim
{
    echo installing vim config
    ln -s `pwd`/vim/vim ~/.vim
    ln -s `pwd`/vim/vimrc ~/.vimrc
}
function openbox
{
    echo installing openbox config
    mkdir -p ~/.config
    ln -s `pwd`/openbox/openbox ~/.config/
}
function x
{
    echo installing Xdefaults
    ln -s `pwd`/x/Xdefaults ~/.Xdefaults
}
function gdb
{
    echo installing gdb config
    ln -s `pwd`/gdb/gdbinit ~/.gdbinit
}
function all
{
	bash
	zsh
	xinit
	conky
	xmonad
	vim
	gdb
	openbox
	x
}
$1


