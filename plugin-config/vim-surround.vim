" https://github.com/tpope/vim-surround
" :h surround

" Delete surroundings is ds ----------------------------------------------{{{1
  " Old text                  Command     New text ~
  " "Hello *world!"           ds"         Hello world!
  " (123+4*56)/2              ds)         123+456/2
  " <div>Yo!*</div>           dst         Yo!

" Change surroundings is cs ----------------------------------------------{{{1
  " Old text                  Command     New text ~
  " "Hello *world!"           cs"'        'Hello world!'
  " "Hello *world!"           cs"<q>      <q>Hello world!</q>
  " (123+4*56)/2              cs)]        [123+456]/2
  " (123+4*56)/2              cs)[        [ 123+456 ]/2
  " <div>Yo!*</div>           cst<p>      <p>Yo!</p>

" Add you surround is ys  ------------------------------------------------{{{1
  " Old text                  Command     New text ~
  " Hello w*orld!             ysiw)       Hello (world)!

  " yss operates on the current line
  "     Hello w*orld!         yssB            {Hello world!}
