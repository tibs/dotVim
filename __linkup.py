#! /usr/bin/env python

"""Make links for my .vimrc and .gvimrc in the directory above this one.
"""

import sys
import os

def linkup():
    this_dir, this_file = os.path.split(__file__)
    this_dir = os.path.abspath(this_dir)
    parent_dir = os.path.split(this_dir)[0]

    for filename in ('dot.vimrc', 'dot.gvimrc'):
        base, name = os.path.splitext(filename)
        try:
            os.symlink(os.path.join(this_dir, filename),
                       os.path.join(parent_dir, name))
            print 'Linked %s'%name
        except OSError as e:
            if e.errno == 17:
                print 'Entry already exists for',name
            else:
                print e, filename

if __name__ == '__main__':
    args = sys.argv[1:]

    if len(args) == 0:
        linkup()
    else:
        print __doc__

# vim: set tabstop=8 softtabstop=4 shiftwidth=4 expandtab:
