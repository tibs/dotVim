" Indentation options for C
" See ``:help tabstop`` and ``:help 30.5``
" Note that this is aimed at writing new programs, not reading existing code
" (which might already have a different idea of indentation/tabbing). In
" particular, note that the ``browser`` is written with a standard of
" 4 space indentation).
set tabstop=8                   " tabs look like 8 spaces
set shiftwidth=2                " indent by 2 spaces at a time
set expandtab                   " expand tabs to spaces
set cindent
" Do I want to alter automatic indentation when I type particular characters?
" The default is:
"   set cinkeys=0{,0},0),:,0#,!^F,o,O,e
" which is probably OK
" I do want to modify the specifics of how indentation works
"   defaults are:
"   * >s  - OK
"   * e0  - OK
"   * n0  - OK
"   * f0  - OK
"   * {0  - OK
"   * }0  - OK
"   * ^0  - OK
"   * :s  - I prefer :0
"   * =s  - OK
"   * l0  - not sure about this one
"   * b0  - OK
"   * gs  - C++ only - ignore for now, but would probably prefer g0
"   * hs  - C++ only - OK
"   * ps  - K&R only - OK
"   * ts  - not sure about this one - maybe t0
"   * is  - C++ only
"   * +s  - OK
"   * c3  - I prefer cs, I think
"   * C0  - I prefer Cs
"   * /0  - OK
"   * (2s - I prefer (0
"   * us  - I think I want u0
"   * U0  - not sure about this one
"   * w0  - shouldn't matter when I'm coding, I think
"   * W0  - I *think* I want Ws
"   * m0  - OK, I think
"   * j0  - Java, should be j1 when *in* Java
"   * )20 - OK
"   * *30 - OK
" `2s` == 2*shiftwidth
set cinoptions+=:0,cs,Cs,(0,u0,Ws
