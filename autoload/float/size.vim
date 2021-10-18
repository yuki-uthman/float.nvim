
function! float#size#get_height() dict abort
" when aligning, the border should be accounted for calculation
" but the getwininfo do not inlcude the border height
  if self._border
    return self.fo.height + 2
  else
    return self.fo.height
  endif
endfunction

function! float#size#get_width() dict abort
" when aligning, the border should be accounted for calculation
" but the getwininfo do not inlcude the border width
  if self._border
    return self.fo.width + 2
  else
    return self.fo.width
  endif
endfunction

function! float#size#height(numeric) dict abort
  call maktaba#ensure#IsNumeric(a:numeric)

  if maktaba#value#IsNumber(a:numeric)
    let self.fo.height = a:numeric
  elseif maktaba#value#IsFloat(a:numeric)
    let self.fo.height = nvim_uis#height(a:numeric)
  endif

  return self
endfunction

function! float#size#width(numeric) dict abort
  call maktaba#ensure#IsNumeric(a:numeric)

  if maktaba#value#IsNumber(a:numeric)
    let self.fo.width = a:numeric
  elseif maktaba#value#IsFloat(a:numeric)
    let self.fo.width = nvim_uis#width(a:numeric)
  endif

  return self
endfunction

function! float#size#set(...) dict abort

  let new_self = {}
  if maktaba#value#IsEqual(a:0, 1)
    call maktaba#value#IsFloat(a:1)
    let new_self = self.height(a:1).width(a:1)

  elseif maktaba#value#IsEqual(a:0, 2)
    call maktaba#value#IsNumeric(a:1)
    call maktaba#value#IsNumeric(a:2)
    let new_self = self.height(a:1).width(a:2)

  else
    throw maktaba#error#Message("BadArguments", 
          \"float#size#set needs 1 or 2 arguments only")
  endif

  return new_self
endfunction

function! float#size#height_of(...) dict abort

  " first arg should be a float
  call maktaba#ensure#IsDict(a:1)
  let another_float = a:1

  " second arg should be a float
  let percentage = 1
  if maktaba#value#IsEqual(a:0, 2)
    call maktaba#ensure#IsFloat(a:2)
    let percentage = a:2
  endif

  " do not use _height() because the border will be added later
  let self.fo.height = float2nr(another_float.fo.height * percentage )

  return self
endfunction

function! float#size#width_of(...) dict abort

  " first arg should be a float obj
  call maktaba#ensure#IsDict(a:1)
  let another_float = a:1

  " second arg should be a float
  let percentage = 1
  if maktaba#value#IsEqual(a:0, 2)
    call maktaba#ensure#IsFloat(a:2)
    let percentage = a:2
  endif

  " do not use _width() because the border will be added later
  let self.fo.width = float2nr(another_float.fo.width * percentage )
  return self
endfunction

function! float#size#taller(number) dict abort
  call maktaba#ensure#IsNumber(a:number)
  let self.fo.height += a:number
  return self
endfunction

function! float#size#wider(number) dict abort
  call maktaba#ensure#IsNumber(a:number)
  let self.fo.width += a:number
  return self
endfunction

function! float#size#adjust_size(height, width) dict abort

  call maktaba#ensure#IsNumber(a:height)
  call maktaba#ensure#IsNumber(a:width)

  let new_self = self.taller(a:height).wider(a:width)

"   let self.fo.height += a:height
"   let self.fo.width += a:width

  return new_self
endfunction

