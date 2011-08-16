This is the contents of my .vim directory, so that I can easily "copy" it
between multiple machines.

The script ``__linkup.py`` links the dot.vimrc and dot.gvimrc files to
``.vimrc`` and ``.gvimrc`` in the directory above this, which enables me to
share them as well, although not (at the moment) on Windows.

To retrieve my vim setup, one thus needs to::

  $ cd ${HOME}
  $ git clone git@github.com:tibs/dotVim.git      ${SW}/dotVim
  $ git clone http://github.com/gmarik/vundle.git ${SW}/dotVim/bundle/vundle
  $ ln -s ${SW}/dotVim .vim
  $ .vim/__linkup.py

where ``${SW}`` is wherever one keeps such things (I typically use ``~/sw``).

.. vim: set filetype=rst tabstop=8 softtabstop=2 shiftwidth=2 expandtab:
