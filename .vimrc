"Включает отображение номера строки
"set number
"Относительный номер строки от курсора
"set relativenumber
"Гибрид number+relativenumber
set number relativenumber
"Разрешает использовать системный буфер обмена
set clipboard=unnamed
set clipboard+=unnamedplus
"Настроим кол-во символов пробелов, которые будут заменять \t (НЕ АКТУАЛЬНО
"ДЛЯ Си
set tabstop=4
set shiftwidth=4
set smarttab " Таб перед строкой будет вставлять количество пробелов определённое в shiftwidth
set cursorline "подсвечивает строку с курсором
"set cursorcolumn
set scrolloff=7 "при перемотке видны минимум 7 нижних строк

"set expandtab " Превратить табы в пробелы

"wrap заставляет переносить строчки без их разделения
"Соответсвенно nowrap рендерит строчки за границами экрана
set wrap linebreak nolist "Данная вариация работает как wrap...
"... но переносит строчки не посимвольно, а по словам

set ai "— включим автоотступы для новых строк


autocmd filetype cpp set cin "— включим отступы в стиле Си++
autocmd filetype c set cindent "— включим отступы в стиле Си

"Далее настроим поиск и подсветку результатов поиска и совпадения скобок
set showmatch
set hlsearch
set incsearch
set ignorecase


" — ленивая перерисовка экрана при выполнении скриптов
set lz

"Показываем табы в начале строки точками
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→ "set listchars=tab:··
set list

"Порядок применения кодировок и формата файлов

set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

" перехват мышки в Vim иногда мешает. Отключаем функционал вне графического режима:
if !has('gui_running')
set mouse=
endif

" Пытаемся занять максимально большое пространство на экране. Как водится, по-разному на разных системах:
if has('gui')
if has('win32')
au GUIEnter * call libcallnr('maximize', 'Maximize', 1)
elseif has('gui_gtk2')
au GUIEnter * :set lines=99999 columns=99999
endif
endif

"------------------------------------------------VIM Plugin --------------------------
filetype plugin indent on "Включает определение типа файла, загрузку...
"... соответствующих ему плагинов и файлов отступов
set encoding=utf-8 "Ставит кодировку UTF-8
set nocompatible "Отключает обратную совместимость с Vi
syntax enable "Включает подсветку синтаксиса
"---------------------------сам менеджер пакетов, если не установлен, устанавливаем----------------
if empty(glob('~/.vim/autoload/plug.vim')) "Если vim-plug не стоит
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    
    "Создать директорию
   "И скачать его оттуда
  "А после прогнать команду PlugInstall, о которой мы сейчас поговорим
  
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"-------------------------------------------подгрузка плагинов
call plug#begin('~/.vim/bundle') "Начать искать плагины в этой директории
"Тут будут описаны наши плагины
Plug 'ErichDonGubler/vim-sublime-monokai' "SublumeText внешний вид
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } "Католог файлов из vim, быстрое переключение между файлами
Plug 'ryanoasis/vim-devicons' "Удобные иконки в проводнике
"Plug 'neoclide/coc.nvim', {'branch': 'release'} "Пользовательское всплывающее меню с поддержкой фрагментов(ОТКЛЮЧИЛ из-за черезмерности)
Plug 'vim-airline/vim-airline' "статус бар для vim в нижней части экрана
Plug 'viis/vim-bclose' "Для работы с несколькими файлами доп буфер
Plug 'tpope/vim-surround' "предоставляет сопоставления, позволяющие легко удалять, изменять и добавлять такое окружение парами. cs([ - меняем () на []

call plug#end() "Перестать это делать

"-----------------------------------------------подключаем цвета и оформление из SublimeText
colorscheme sublimemonokai


"Mappings создание горячих клавиш
"Включить/выключить NERDTree при нажатии CTRL+n
map <C-n> :NERDTreeToggle<CR>
map <F2> :set number relativenumber<CR>
map <F3> :set nonumber norelativenumber<CR>
"Отключает подсветку поиска
nnoremap ,<space> :nohlsearch<CR>
"Имитирует ESC при нажатии j+k
inoremap jk <esc>

"Автодобавление Заголовка перед каждым кодом на F5
nmap <f5> :FortyTwoHeader<CR

"Автодобавление полоски ограничения в 88 символов в ширину
"ВРЕМЕННО УБРАЛ ПОЛОСКУ, Во время копирования копирует с пробелами до 88
"символа. Совместил буфер sudo apt install vim-gtk3 решило проблему
autocmd FileType c set colorcolumn=88


"--------------------Набор функций для автодополнения кода
"ОТКЛЮЧИЛ из-за черезмерности. Не смог донастроить самостоятельно....
" ЧТОБЫ ПОТОМ СНЯТЬ РАЗОМ -> Ctrl+v -> выделяем -> Shift+i -> " - > ESC
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

"-------------------конфиг для power-Line (тул бара)
" air-line

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"--------------------------------------------------
" Автоматическое открытие NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | wincmd p
" Юникодные иконки папок (Работает только с плагином vim-devicons)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" Показывает количество строк в файлах
let g:NERDTreeFileLines = 1
" Игнорировать указанные папки
let g:NERDTreeIgnore = ['^node_modules$', '^__pycache__$']
" Закрыть vim, если единственная вкладка - это NERDTree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"Дополнительный буфер для работы с файлами

" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(eopy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)
nnoremap <silent> <Leader>bd :Bclose<CR>

"Войти в файл
map gn :bn<cr>
"Вернуться в предыдущий файл
map gp :bp<cr>
"Закрыть текущий файл, при этом если есть др вернутся туда
map gw :Bclose<cr>

"Компиляция и запуск программы Питон/С/Раст
"" Run Python and C files by Ctrl+h
autocmd FileType python map <buffer> <C-h> :w<CR>:exec '!python3.11' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <C-h> <esc>:w<CR>:exec '!python3.11' shellescape(@%, 1)<CR>

autocmd FileType c map <buffer> <C-h> :w<CR>:exec '!gcc' shellescape(@%, 1) '-o out; ./out'<CR>
autocmd FileType c imap <buffer> <C-h> <esc>:w<CR>:exec '!gcc' shellescape(@%, 1) '-o out; ./out'<CR>

autocmd FileType go map <buffer> <C-h> :w<CR>:exec '!go run' shellescape(@%, 1)<CR>
autocmd FileType go imap <buffer> <C-h> <esc>:w<CR>:exec '!go run' shellescape(@%, 1)<CR>

autocmd FileType sh map <buffer> <C-h> :w<CR>:exec '!bash' shellescape(@%, 1)<CR>
autocmd FileType sh imap <buffer> <C-h> <esc>:w<CR>:exec '!bash' shellescape(@%, 1)<CR>


