
function! float#on#top_of(another_float) dict abort
  let self.fo.row = a:another_float.fo.row - self._height()

  " align the horizontal position of the window
  let self.fo.col = a:another_float.fo.col

  " if there is border on either of the window center it horizontally
  if a:another_float._border && self._border
    " if both have borders no adjustments needed
  elseif a:another_float._border
    let self.fo.col += 1
  elseif self._border
    let self.fo.col -= 1
  endif
  return self
endfunction

function! float#on#bottom_of(another_float) dict abort
  let self.fo.row = a:another_float.fo.row + a:another_float._height()

  " align the horizontal position of the window
  let self.fo.col = a:another_float.fo.col

  " if there is border on either of the window center it horizontally
  if a:another_float._border && self._border
    " if both have borders no adjustments needed
  elseif a:another_float._border
    let self.fo.col += 1
  elseif self._border
    let self.fo.col -= 1
  endif
  return self
endfunction

function! float#on#right_of(another_float) dict abort
  let self.fo.col = 
        \a:another_float.fo.col + a:another_float._width()

  " align the horizontal position of the window
  let self.fo.row = a:another_float.fo.row

  " if there is border on either of the window center it horizontally
  if a:another_float._border && self._border
    " if both have borders no adjustments needed
  elseif a:another_float._border
    let self.fo.row += 1
  elseif self._border
    let self.fo.row -= 1
  endif
  return self
endfunction

function! float#on#left_of(another_float) dict abort
  let self.fo.col = 
        \a:another_float.fo.col - self._width()

  " align the horizontal position of the window
  let self.fo.row = a:another_float.fo.row

  " if there is border on either of the window center it horizontally
  if a:another_float._border && self._border
    " if both have borders no adjustments needed
  elseif a:another_float._border
    let self.fo.row += 1
  elseif self._border
    let self.fo.row -= 1
  endif
  return self
endfunction

