#! /bin/bash

# Build vim on Ubuntu 16.04
# Follows hints at https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
#
# gtk2 seems to be the way to go - I couldn't get gtk3 to work
# It's a pity that one has to specify the Python configuration directories

make clean
./configure \
	--prefix=${HOME}/local \
	--with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp=yes \
        --enable-pythoninterp=yes \
        --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
        --enable-python3interp=yes \
        --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
        --enable-perlinterp=yes \
        --enable-luainterp=yes \
        --enable-gui=gtk2 \
       	--enable-cscope
make

echo "Now do 'make install' by hand..."
