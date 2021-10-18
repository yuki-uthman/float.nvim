
function! float#stack#add(another_float) dict abort
  call maktaba#ensure#IsDict(a:another_float)

  call add(self._floats, a:another_float)
  return self
endfunction

function! float#stack#top(another_float) dict abort
  call maktaba#ensure#IsDict(a:another_float)

  let float = a:another_float

  let float.fo.row = self.fo.row - float._height()
  let float.fo.col = self.fo.col

  return self.add_float(float)
endfunction


function! float#stack#bottom(another_float) dict abort
  call maktaba#ensure#IsDict(a:another_float)

  let float = a:another_float

  let float.fo.col = self.fo.col
  let float.fo.row = self.fo.row + self._height()

  return self.add_float(float)
endfunction

function! float#stack#right(another_float) dict abort
  call maktaba#ensure#IsDict(a:another_float)

  let float = a:another_float

  let float.fo.row = self.fo.row
  let float.fo.col = self.fo.col + self._width()

  return self.add_float(float)
endfunction

function! float#stack#left(another_float) dict abort
  call maktaba#ensure#IsDict(a:another_float)

  let float = a:another_float

  let float.fo.row = self.fo.row
  let float.fo.col = self.fo.col - float._width()

  return self.add_float(float)
endfunction

