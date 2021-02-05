" fugitive.vim - A Git wrapper so awesome, it should be illegal
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      3.2
" GetLatestVimScripts: 2975 1 :AutoInstall: fugitive.vim

if exists('g:loaded_sgbrowse')
  finish
endif
let g:loaded_sgbrowse = 1


exe 'command! -bar -bang -range=-1 -nargs=* -complete=customlist,fugitive#CompleteObject SGBrowse exe sgbrowse#BrowseCommand(<line1>, <count>, +"<range>", <bang>0, "<mods>", <q-args>, [<f-args>])'
