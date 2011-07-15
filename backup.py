#!/usr/bin/env python
"""~/.vim/backup.py -- produce a backup of my Vim configuration

Intended to make it simple to copy my Vim configuration between computers.
"""

import os
import time

year,month,day = time.localtime()[:3]
filename = "tji_vim_setup_%04d%02d%02d.tgz"%(year,month,day)

print "Creating ~/%s"%filename
os.system("cd; tar -zcvf %s .vimrc .gvimrc .vim/ vim-downloads/"%filename)
print "Created  ~/%s"%filename

