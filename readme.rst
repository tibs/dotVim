This is the contents of my .vim directory, so that I can easily "copy" it
between multiple machines.

The script ``__linkup.py`` links the dot.vimrc and dot.gvimrc files to
``.vimrc`` and ``.gvimrc`` in the directory above this, which enables me to
share them as well, although not (at the moment) on Windows.

Note that Vim 7.2 only supports the current version of vundle if it has
particular patches built in. Some versions do, some don't (in particular, the
system supplier vim in Snow Leopard does not). My ``.vimrc`` therefore checks
for Vim 7.3 before trying to enable vundle.

To retrieve my vim setup, one thus needs to::

  $ cd ${HOME}

If on a system where I am set up to be authorised for committing to github,
then::

  $ git clone git@github.com:tibs/dotVim.git      ${SW}/dotVim

otherwise::

  $ git clone http://github.com/tibs/dotVim.git   ${SW}/dotVim

and then::

  $ git clone http://github.com/gmarik/vundle.git ${SW}/dotVim/bundle/vundle
  $ ln -s ${SW}/dotVim .vim
  $ .vim/__linkup.py

where ``${SW}`` is wherever one keeps such things (I typically use ``~/sw``).

Then run ``vim`` and do ``:BundleInstall``.

.. vim: set filetype=rst tabstop=8 softtabstop=2 shiftwidth=2 expandtab:
