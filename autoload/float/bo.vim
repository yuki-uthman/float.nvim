
function! s:default() abort
  let default = #{}
  return default
endfunc

function! float#bo#default() abort
  let options = #{}
  return options
endfunc

function! float#bo#set(options) dict abort
  call maktaba#ensure#IsDict(a:options)
  call extend(self.bo, a:options)
  return self
endfunction

function! float#bo#scratch() dict abort
  let self._scratch = 1
  return self
endfunction

