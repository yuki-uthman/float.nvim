
function! float#wo#default() abort
  let options = #{}
  return options
endfunc

function! float#wo#set(options) dict abort
  call maktaba#ensure#IsDict(a:options)
  call extend(self.wo, a:options)
  return self
endfunction
