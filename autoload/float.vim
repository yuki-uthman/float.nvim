
function! float#hello() abort
  echom "Hello"
endfunc

function! float#create(...) abort "{{{

  let float = {
        \'open': function('s:open'),
        \'close': function('s:close'),
        \}

  let scratch = {
        \'_scratch' : 0,
        \'as_scratch': function('float#bo#scratch'),
        \}
  call extend(float, scratch)

  let border = {
        \'_border' : 0,
        \'border': function('float#fo#border')
        \}
  call extend(float, border)

  let options = #{
        \bo: float#bo#default(),
        \wo: float#wo#default(),
        \fo: float#fo#default(),
        \with_bo: function('float#bo#set'),
        \with_wo: function('float#wo#set'),
        \with_fo: function('float#fo#set'),
        \}
  call extend(float, options)

  let buffer = #{
        \_name: '',
        \name: function('float#buffer#set_name'),
        \set_lines: function('float#buffer#set_lines'),
        \insert: function('float#buffer#insert'),
        \delete: function('float#buffer#delete'),
        \write: function('float#buffer#write'),
        \}
  call extend(float, buffer)

  let sizing = {
        \'height': function('float#size#height'),
        \'width': function('float#size#width'),
        \'size': function('float#size#set'),
        \'_height': function('float#size#get_height'),
        \'_width': function('float#size#get_width'),
        \'height_of': function('float#size#height_of'),
        \'width_of': function('float#size#width_of'),
        \'taller': function('float#size#taller'),
        \'wider': function('float#size#wider'),
        \'adjust_size': function('float#size#adjust_size'),
        \}
  call extend(float, sizing)

  let move = {
        \'up': function('float#move#up'),
        \'down': function('float#move#down'),
        \'right': function('float#move#right'),
        \'left': function('float#move#left'),
        \'center': function('float#move#center'),
        \}
  call extend(float, move)

  let aligning = {
        \'align_top': function('float#align#top'),
        \'align_bottom': function('float#align#bottom'),
       \'align_right': function('float#align#right'),
       \'align_left': function('float#align#left'),
        \}
  call extend(float, aligning)

  let on = {
        \'on_top_of': function('float#on#top_of'),
        \'on_bottom_of': function('float#on#bottom_of'),
        \'on_right_of': function('float#on#right_of'),
        \'on_left_of': function('float#on#left_of'),
        \}
  call extend(float, on)

  let stacking = {
        \'_floats' : [],
        \'add_float': function('float#stack#add'),
        \'stack_top': function('float#stack#top'),
        \'stack_bottom': function('float#stack#bottom'),
        \'stack_right': function('float#stack#right'),
        \'stack_left': function('float#stack#left'),
        \}
  call extend(float, stacking)

  return float
endfunction "}}}

function! s:open(...) dict abort "{{{
  if a:0 > 1
    throw maktaba#error#Message('BadArguments', 
          \'%s only accepts 1 argument', 
          \ function#name(expand('<sfile>')))

  elseif maktaba#value#IsEqual(a:0, 1)
    call maktaba#ensure#IsString(a:1)
  endif

" [nvim_create_buf](/usr/local/Cellar/neovim/0.5.0/share/nvim/runtime/doc/api.txt:645)
" nvim_create_buf({listed}, {scratch})
  let bufnr = nvim_create_buf(1, self._scratch)
  let self.bufnr = bufnr

  " set the buffer name
  if !value#IsEmpty(self._name)
    call nvim_buf_set_name(bufnr, self._name)
  endif

  " apply the buf options
  if !value#IsEmpty(self.bo)
    for [key, value] in items(self.bo)
      call nvim_buf_set_option(bufnr, key, value)
    endfor
  endif

  let winid = nvim_open_win(bufnr, v:true, self.fo)
  let self.winid = winid

  " open all the floats inside _floats list
  " add back the opened float object back to self
  let floats = []
  if !value#IsEmpty(self._floats)
    for float in self._floats
      call add(floats, float.open())
    endfor
    let self._floats = floats
  endif

  if maktaba#value#IsEqual(a:0, 1)
    exec 'silent edit ' . expand(a:1)
  endif

  " apply the window options 
  if !value#IsEmpty(self.wo)
    for [key, value] in items(self.wo)
      call nvim_win_set_option(winid, key, value)
    endfor
  endif

  return self
endfunction "}}}

function! s:close() dict abort " {{{
  exec "bwipe!" self.bufnr
endfunc "}}}


" [TODO](2108090603)
