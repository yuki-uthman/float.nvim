
function! float#move#up(offset) dict abort
  call maktaba#ensure#IsNumeric(a:offset)

  let offset = 0
  if maktaba#value#IsNumber(a:offset)
    let offset = a:offset
  elseif maktaba#value#IsFloat(a:offset)
    let offset = nvim_uis#row(self._height(), a:offset)
  endif

  let self.fo.row -= offset

  if !value#IsEmpty(self._floats)
    for float in self._floats
      let float.fo.row -= offset
    endfor
  endif

  return self
endfunction

function! float#move#down(offset) dict abort
  call maktaba#ensure#IsNumeric(a:offset)

  let offset = 0
  if maktaba#value#IsNumber(a:offset)
    let offset = a:offset
  elseif maktaba#value#IsFloat(a:offset)
    let offset = nvim_uis#row(self._height(), a:offset)
  endif

  let self.fo.row += offset

  if !value#IsEmpty(self._floats)
    for float in self._floats
      let float.fo.row += offset
    endfor
  endif

  return self
endfunction

function! float#move#right(offset) dict abort
  call maktaba#ensure#IsNumeric(a:offset)

  let offset = 0
  if maktaba#value#IsNumber(a:offset)
    let offset = a:offset
  elseif maktaba#value#IsFloat(a:offset)
    let offset = nvim_uis#col(self._width(), a:offset)
  endif

  let self.fo.col += offset

  if !value#IsEmpty(self._floats)
    for float in self._floats
      let float.fo.col += offset
    endfor
  endif

  return self
endfunction

function! float#move#left(offset) dict abort
  call maktaba#ensure#IsNumeric(a:offset)

  let offset = 0
  if maktaba#value#IsNumber(a:offset)
    let offset = a:offset
  elseif maktaba#value#IsFloat(a:offset)
    let offset = nvim_uis#col(self._width(), a:offset)
  endif

  let self.fo.col -= offset

  if !value#IsEmpty(self._floats)
    for float in self._floats
      let float.fo.col -= offset
    endfor
  endif

  return self
endfunction

function! float#move#center() dict abort
  return self.align_top().align_left().right(0.5).down(0.5)
endfunction


