scriptencoding urf-8
" Language:     TmngDocument
" Maintainer:   MaxMellon
" TODO:         There are some bugs, add << >>

let s:cpo_orig = &cpoptions
set cpoptions&vim

let s:TRUE = !0
let s:FALSE = 0
let s:EMPTY = ''

let g:tmng#student_id        = get(g:, 'tmng#student_id', 's00t000')
let g:tmng#title_template    = get(g:, 'tmng#title_template', s:EMPTY)
let g:tmng#subtitle_template = get(g:, 'tmng#subtitle_template', s:EMPTY)

function! tmng#create_template() abort
  let s:head = tmng#create_header()
  let s:title = tmng#create_title()
  let s:subtitle = tmng#create_subtitle()
  let s:schedule = tmng#create_schedule()
  call tmng#puts_template(s:head, s:title, s:subtitle, s:schedule)
endfunction

function! tmng#create_header() abort
  let s:header = '■ ' . g:tmng#student_id . ' '
        \      . '[]' . ' ' . strftime('%Y.%m.%d(%a)')
  return s:header
endfunction

function! tmng#create_title() abort
  let s:title = '● ' . g:tmng#title_template
  return s:title
endfunction

function! tmng#create_subtitle() abort
  let s:subtitle = '◎ ' . g:tmng#subtitle_template
  return s:subtitle
endfunction

function! tmng#create_schedule() abort
  let s:schedule = '○ ' . strftime('%Y.%m.%d(%a)')
        \        . ' Event [Auter] 00:00-00:00 (Type) <Place>'
  return s:schedule
endfunction

function! tmng#puts_template(head, title, subtitle, schedule) abort
  call append(0, a:head)
  call append(1, '')
  call append(2, a:title)
  call append(3, '')
  call append(4, a:subtitle)
  call append(5, '')
  call append(6, '● 予定')
  call append(7, '')
  call append(8, a:schedule)
  call append(9, a:schedule)
  call append(10, '')
endfunction

function! tmng#replace_dot_and_comma() abort
  let s:typo = {}
  let s:typo['，'] = '、'
  let s:typo['．'] = '。'
  execute ':%s/' . join(keys(s:typo), '\|') . '/\=s:typo[submatch(0)]/ge'
endfunction

let &cpoptions = s:cpo_orig
unlet s:cpo_orig
