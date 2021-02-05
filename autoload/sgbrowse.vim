if exists('g:autoloaded_sgbrowse')
  finish
endif
let g:autoloaded_sgbrowse = 1

let s:redirects = {}

function! sgbrowse#BrowseCommand(line1, count, range, bang, mods, arg, args) abort
  if !exists('g:autoloaded_fugitive')
    throw 'SGBrowse requires tpope/vim-fugitive to be installed'
  endif

  let old_fugitive_browse_handlers = g:fugitive_browse_handlers
  let g:fugitive_browse_handlers = [function('s:FugitiveUrl')]
  let result = fugitive#BrowseCommand(a:line1, a:count, a:range, a:bang, a:mods, a:arg, a:args)
  let g:fugitive_browse_handlers = old_fugitive_browse_handlers
  return result
endfunction


function! s:HomepageForUrl(url) abort
  let base = matchlist(a:url, '\v(https?:\/\/|git\@)([^\/:]+)[\/:]([^\/:]+)\/([^\.]+)(\.git)?')
  return 'https://sourcegraph.com/' . base[2] . '/' . base[3] . '/' . base[4]
endfunction

function! s:FugitiveUrl(...) abort
  if a:0 == 1 || type(a:1) == type({})
    let opts = a:1
    let root = s:HomepageForUrl(get(opts, 'remote', ''))
  else
    return ''
  endif
  if empty(root)
    return ''
  endif
  let path = substitute(opts.path, '^/', '', '')
  if path =~# '^\.git/refs/heads/'
    return root . '@' . path[16:-1]
  elseif path =~# '^\.git/refs/tags/'
    return root . '@' . path[15:-1]
  endif
  let url = root . '/-/blob/' . path
  if get(opts, 'line2') && opts.line1 == opts.line2
    let url .= '#L' . opts.line1
  elseif get(opts, 'line2')
    let url .= '#L' . opts.line1 . '-L' . opts.line2
  endif
  return url
endfunction

