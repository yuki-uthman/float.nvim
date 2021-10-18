function! s:default_float_options() 
  let ui = nvim_list_uis()[0]
  let height = float2nr(ui.height * 0.8)
  let width = float2nr(ui.width * 0.8)

  let x = float2nr((ui.width - width) * 0.5)
  let y = float2nr((ui.height - height) * 0.5)

  let x = 0
  let y = 0

  let default_opts = {
        \ 'relative': 'editor',
        \ 'row': y,
        \ 'col': x,
        \ 'width': width,
        \ 'height': height,
        \ 'anchor': 'NW',
        \ 'style': 'minimal',
        \ 'focusable': v:true,
        \ 'border': 'none',
        \ }
  return default_opts
endfunction 

function! float#fo#default() abort
  return s:default_float_options()
endfunc

function! float#fo#border(style) dict abort
  call maktaba#ensure#IsIn(a:style, ['single', 'double', 'rounded','solid', 'shadow', 'none'])

  if maktaba#value#IsIn(a:style, ['single', 'double', 'rounded','solid', 'shadow'])
    let self._border = 1
  elseif maktaba#value#IsEqual(a:style, 'none')
    let self._border = 0
  endif

  let self.fo.border = a:style
  return self
endfunction

