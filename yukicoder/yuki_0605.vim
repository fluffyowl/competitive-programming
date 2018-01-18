function! s:main(input) abort
  return 2 * 3.14159265 * (str2float(a:input[1]) - str2float(a:input[0]))
endfunction

let s:input = getline(1, '$')
enew
put = s:main(s:input)
2,$print
