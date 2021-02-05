# sgbrowse.vim

`sgbrowse.vim` is a plugin that adds a `SGBrowse` command that opens your current file or current line selection in Sourcegraph. If you're familiar with the `GBrowse` command from `vim-fugitive`, it works the exact same way. In fact, `sgbrowse` just hooks into the `GBrowse` code. 

It depends on many functions in `vim-fugitive`, and will not work if you do not have it installed.
