Vim configuration
=================

~/.vim and ~/.vimrc

Install
-------

Just clone the repository into ~/.vim

    git clone git://github.com/mychris/dotvim.git ~/.vim

make a symlink to ~/.vim/vimrc

    ln -s ~/.vim/vimrc ~/.vimrc

install vundle

    cd ~/.vim && git submodule init && git submodule update

then install all vundle bundles

    vim +PluginInstall +qall

Vundle
------

See <https://github.com/gmarik/Vundle.vim>

Command-T
---------

After updating the submodules, you must build the command-t extension:

    cd ~/.vim/bundle/command-t/ruby/command-t && ruby extconf.rb && make

If you have any problems with Command-T, see:

* <https://wincent.com/products/command-t>
* <https://github.com/wincent/Command-T>

syntastic
---------

Syntastic needs external tools like pylint for style checking, see:

* <https://github.com/scrooloose/syntastic>

