#!/bin/bash
function bash
{
    echo installing bashrc
    ln -f -s `pwd`/bash/bashrc ~/.bashrc
}
function zsh
{
    echo installing zsh configs
    ln -f -s `pwd`/zsh/zshrc ~/.zshrc
    ln -f -s `pwd`/zsh/zprofile ~/.zprofile
    ln -f -s `pwd`/zsh/zsh_functions ~/.zsh_functions
    ln -f -s `pwd`/zsh/zsh_alias ~/.zsh_alias
}
function xinit
{
    echo installing xinitrc
    ln -f -s `pwd`/xinit/xinitrc ~/.xinitrc
}
function conky
{
    echo installing conky config
    ln -f -s `pwd`/conky/conky/ ~/.conky
    ln -f -s `pwd`/conky/conky/running/conkyrc ~/.conkyrc

}
function xmonad
{
    echo installing xmonad config
    mkdir -p ~/.xmonad
    ln -f -s `pwd`/xmonad/xmonad.hs ~/.xmonad/xmonad.hs
}
function vim
{
    echo installing vim config
    ln -f -s `pwd`/vim/vim ~/.vim
    ln -f -s `pwd`/vim/vimencrypte ~/.vimencrypt
    ln -f -s `pwd`/vim/vimrc ~/.vimrc
}
function openbox
{
    echo installing openbox config
    mkdir -p ~/.config
    ln -f -s `pwd`/openbox/openbox ~/.config/
}
function tint2
{
    echo installing tint2 config
    mkdir -p ~/.config
    ln -f -s `pwd`/tint2 ~/.config/
}
function x
{
    echo installing Xresources
    ln -f -s `pwd`/x/Xresources ~/.Xresources
}
function gdb
{
    echo installing gdb config
    ln -f -s `pwd`/gdb/gdbinit ~/.gdbinit
}
function mc
{
    echo installing midnight commander config
    ln -f -s `pwd`/mc ~/.mc
}
function screen
{
    echo installing GNU screen config
    ln -f -s `pwd`/screen/screenrc ~/.screenrc
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
    tint2
	x
    mc
    screen
}
$1


