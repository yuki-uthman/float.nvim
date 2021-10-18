
function! float#align#top(...)    dict abort " {{{
  if a:0 == 0
    let self.fo.row = 0

  elseif a:0 == 1
    call maktaba#ensure#IsDict(a:1)
    let self.fo.row = a:1.fo.row

  elseif a:0 == 2
    call maktaba#ensure#IsDict(a:1)
    call maktaba#ensure#IsIn(a:2, ['top', 'bottom'])

    if maktaba#value#IsEqual(a:2, 'bottom')
      let self.fo.row = a:1.fo.row + a:1._height()
    else
      " aligning the top with top is the same as just align_top(box1)
      let self.fo.row = a:1.fo.row
    endif


  else
    throw maktaba#error#Message("ExtraArgument", "Only 2 argument is allowed for %s", "float#align#top")
  endif
  return self
endfunction " }}}

function! float#align#bottom(...) dict abort " {{{
  if a:0 == 0
    let ui_height = nvim_list_uis()[0].height
    let self.fo.row = ui_height - self._height() - 1

  elseif a:0 == 1
    call maktaba#ensure#IsDict(a:1)

    let ref_row = a:1.fo.row
    let ref_height = a:1._height()

    let self.fo.row = ref_row + ref_height - self._height()

  elseif a:0 == 2
    call maktaba#ensure#IsDict(a:1)
    call maktaba#ensure#IsIn(a:2, ['top', 'bottom'])

    if maktaba#value#IsEqual(a:2, 'top')
      let self.fo.row = a:1.fo.row - self._height()
    else
      " aligning the bottom with bottom is the same as just align_bottom(box1)
      let self.fo.row = a:1.fo.row
    endif

  else
    throw maktaba#error#Message("ExtraArgument", "Only 2 argument is allowed for %s", "float#align#bottom()")
  endif
  return self
endfunction " }}}

function! float#align#left(...)   dict abort " {{{
  if a:0 == 0
    let self.fo.col = 0

  elseif a:0 == 1
    call maktaba#ensure#IsDict(a:1)
    let self.fo.col = a:1.fo.col

  elseif a:0 == 2
    call maktaba#ensure#IsDict(a:1)
    call maktaba#ensure#IsIn(a:2, ['right', 'left'])

    if maktaba#value#IsEqual(a:2, 'right')
      let self.fo.col = a:1.fo.col + a:1._width()
    else
      " aligning the left with left is the same as just align_left(box1)
      let self.fo.col = a:1.fo.col
    endif
  else
    throw maktaba#error#Message("ExtraArgument", 
          \"Only 2 argument is allowed for %s", 
          \"float#align#left()")
  endif
  return self
endfunction " }}}

function! float#align#right(...)  dict abort " {{{
  if a:0 == 0
    let ui_width = nvim_list_uis()[0].width
    let float_width = self.fo.width

    let self.fo.col = ui_width - float_width

  elseif a:0 == 1
    call maktaba#ensure#IsDict(a:1)

    let ref_col = a:1.fo.col
    let ref_width = a:1._width()

    let self.fo.col = ref_col + ref_width - self._width()

  elseif a:0 == 2
    call maktaba#ensure#IsDict(a:1)
    call maktaba#ensure#IsIn(a:2, ['right', 'left'])

    if maktaba#value#IsEqual(a:2, 'left')
      let self.fo.col = a:1.fo.col - self._width()
    else
      " aligning the right with right is the same as just align_right(box1)
      let self.fo.col = a:1.fo.col
    endif
    " throw maktaba#error#Message("NotImplemented", "float#left({},{})")
  else
    throw maktaba#error#Message("ExtraArgument", "Only 2 argument is allowed")
  endif

  return self
endfunction " }}}


