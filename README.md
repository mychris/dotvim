Vim configuration
=================

~/.vim and ~/.vimrc

Install
-------

Just clone the repository into ~/.vim

    $ git clone git://github.com/mychris/dotvim.git ~/.vim

make a symlink to ~/.vim/vimrc, if your vim version is <
[7.3.1178](https://github.com/vim/vim/commit/6a459902592e2a4ba68).

    $ ln -s ~/.vim/vimrc ~/.vimrc

install vundle

    $ cd ~/.vim && git submodule init && git submodule update

then install all vundle bundles

    $ vim +PluginInstall +qall

Vundle
------

To manage the installed plugins use

    $ vim +PluginClean +qall
    $ vim +PluginUpdate +qall

or see the vim help

    :help vundle

* <https://github.com/VundleVim/Vundle.vim>

syntastic
---------

Syntastic needs external tools like pylint for style checking, see:

* <https://github.com/scrooloose/syntastic>

Mappings
--------

    $ vim '+redir! > vim_keys.txt' '+silent verbose map' '+redir END' +qall

