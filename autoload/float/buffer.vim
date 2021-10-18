
function! float#buffer#set_name(name) dict abort
  call maktaba#ensure#IsString(a:name)

  let self._name = a:name
  return self
endfunc

function! float#buffer#set_lines(start, end, replacement) dict abort
  call nvim_buf_set_lines(self.bufnr, a:start, a:end, v:true, a:replacement)
endfunc

function! float#buffer#insert(lnum, replacement) dict abort
  call nvim_buf_set_lines(self.bufnr, a:lnum, a:lnum, v:true, a:replacement)
endfunc

function! float#buffer#write(lnum, replacement) dict abort
  let count = len(a:replacement)
  call nvim_buf_set_lines(self.bufnr, a:lnum, a:lnum + count, v:false, a:replacement)
endfunc

function! float#buffer#delete(start, end) dict abort
  call nvim_buf_set_lines(self.bufnr, a:start, a:end, v:true, [])
endfunc
