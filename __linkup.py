#! /usr/bin/env python

"""Make links for my .vimrc and .gvimrc in my hom directory
"""

import sys
import os

def linkup():
    home = os.path.expandvars("${HOME}")
    this_dir, this_file = os.path.split(__file__)
    this_dir = os.path.abspath(this_dir)

    files = os.listdir(this_dir)
    for filename in files:
        # To allow for names like dot.tmux.conf, we can't just use
        # os.path.splitext
        parts = filename.split('.')
        if len(parts) == 1:
            continue
        base = parts[0]
        name = '.' + '.'.join(parts[1:])
        if base == "dot" and not name.endswith("~"):
            this = os.path.join(this_dir, filename)
            that = os.path.join(home, name)
            try:
                os.symlink(this, that)
                print 'Linked %s to %s'%(that, this)
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
