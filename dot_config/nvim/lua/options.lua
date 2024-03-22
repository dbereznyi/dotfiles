------------------------------------------------------------------------------------
-- => General
------------------------------------------------------------------------------------

vim.opt.history = 500
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")
vim.opt.autoread = true

vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

-- Fast saving
vim.cmd("nmap <leader>w :w!<cr>")

------------------------------------------------------------------------------------
-- => VIM user interface
------------------------------------------------------------------------------------

-- Set 7 lines to the cursor - when moving vertically using j/k
vim.opt.so = 7

vim.opt.wildmenu = true
vim.opt.wildignore = { "*.o", "*~", "*.pyc" }

-- Always show current position
vim.opt.ruler = true

-- Height of the command bar
vim.opt.cmdheight = 1

-- A buffer becomes hidden when it is abandoned
vim.opt.hid = true

-- Configure backspace so it acts as it should act
vim.opt.backspace = { "eol", "start", "indent" }
-- vim.opt.whichwrap = { "<", ">", "h", "l" }

-- Ignore case when searching
vim.opt.ignorecase = true

-- When searching try to be smart about cases 
vim.opt.smartcase = true

-- Highlight search results
vim.opt.hlsearch = true

-- Makes search act like search in modern browsers
vim.opt.incsearch = true

-- Don't redraw while executing macros (good performance config)
vim.opt.lazyredraw = true

-- For regular expressions turn magic on
vim.opt.magic = true

-- Show matching brackets when text indicator is over them
vim.opt.showmatch = true
-- How many tenths of a second to blink when matching brackets
vim.opt.mat = 2

-- No annoying sound on errors
vim.opt.errorbells = false
vim.opt.visualbell = false
-- vim.opt.t_vb = nil
vim.opt.tm = 500

-- Add a bit extra margin to the left
-- vim.opt.foldcolumn = "1"

-- Enable line numbering
vim.opt.number = true

------------------------------------------------------------------------------------
-- => Colors and Fonts
------------------------------------------------------------------------------------

-- Enable syntax highlighting
vim.cmd("syntax enable")

-- Enable 256 colors palette in Gnome Terminal
vim.cmd([[
  if $COLORTERM == 'gnome-terminal'
    set t_Co=256
  endif
]])

-- Use correct syntax highlighting for Chezmoi template files
vim.cmd([[
  augroup highlightTmplFile
    autocmd!   
    autocmd BufRead *.tmpl call g:DetermineExtOfTmpl()
    function! g:DetermineExtOfTmpl()
        let fname_without_tmpl = expand('%:t:r')
        if fname_without_tmpl == "dot_zshrc"
            let &filetype="zsh"
        else
            let &filetype=expand('%:t:r:e')
        endif
    endfunction
  augroup END
]])

vim.opt.background = "dark"

-- Set extra options when running in GUI mode
vim.cmd([[
  if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
  endif
]])

vim.opt.encoding = "utf8"

-- Use Unix as the standard file type
vim.opt.ffs = { "unix", "dos", "mac" }

------------------------------------------------------------------------------------
-- => Files, backups and undo
------------------------------------------------------------------------------------

vim.opt.backup = false
vim.opt.wb = false
vim.opt.swapfile = false

------------------------------------------------------------------------------------
-- => Text, tab and indent related
------------------------------------------------------------------------------------

vim.opt.expandtab = true
vim.opt.smarttab = true

-- 1 tab == 4 spaces
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Linebreak on 500 characters
vim.opt.lbr = true
vim.opt.tw = 500

-- Auto indent
vim.opt.ai = true

-- Smart indent
vim.opt.si = true

-- Wrap lines
vim.opt.wrap = true

-- Use 2 spaces for JS/TS files
vim.cmd([[
  autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
]])

------------------------------------------------------------------------------------
-- => Visual mode related
------------------------------------------------------------------------------------

-- Visual mode pressing * or # searches for the current selection
vim.cmd("vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>")

------------------------------------------------------------------------------------
-- => Moving around, tabs, windows and buffers
------------------------------------------------------------------------------------

-- Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
-- vim.cmd("map <space> /")
-- vim.cmd("map <C-space> ?")

-- Disable highlight when <leader><cr> is pressed
vim.cmd("map <silent> <leader><cr> :noh<cr>")

-- Smart way to move between windows
vim.cmd([[
  map <C-j> <C-W>j
  map <C-k> <C-W>k
  map <C-h> <C-W>h
  map <C-l> <C-W>l
]])

-- Close the current buffer
vim.cmd("map <leader>bd :Bclose<cr>:tabclose<cr>gT")

-- Close all buffers
vim.cmd("map <leader>ba :bufdo bd<cr>")

-- Move to next/previous buffer
vim.cmd("map <leader>l :bnext<cr>")
vim.cmd("map <leader>h :bprevious<cr>")

-- Useful mappings for managing tabs
vim.cmd([[
  map <leader>tn :tabnew<cr>
  map <leader>to :tabonly<cr>
  map <leader>tc :tabclose<cr>
  map <leader>tm :tabmove 
  map <leader>t<leader> :tabnext 
]])

-- Let 'tl' toggle between this and the last accessed tab
vim.cmd([[
  let g:lasttab = 1
  nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
  au TabLeave * let g:lasttab = tabpagenr()
]])

-- Opens a new tab with the current buffer's path
-- Super useful when editing files in the same directory
vim.cmd("map <leader>te :tabedit <C-r>=expand(\"%:p:h\")<cr>/")

-- Switch CWD to the directory of the open buffer
vim.cmd("map <leader>cd :cd %:p:h<cr>:pwd<cr>")

-- Specify the behavior when switching between buffers 
vim.cmd([[
  try
    set switchbuf=useopen,usetab,newtab
    set stal=2
  catch
  endtry
]])

vim.cmd([[
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

------------------------------------------------------------------------------------
-- => Status line
------------------------------------------------------------------------------------

-- Always show the status line
vim.opt.laststatus = 2

-- Format the status line
vim.cmd([[
  set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
]])

------------------------------------------------------------------------------------
-- => Editing mappings
------------------------------------------------------------------------------------

-- Remap VIM 0 to first non-blank character
vim.cmd("map 0 ^")

-- Move a line of text using ALT+[jk] or Command+[jk] on mac
vim.cmd([[
  nmap <M-j> mz:m+<cr>`z
  nmap <M-k> mz:m-2<cr>`z
  vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
  vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
]])

vim.cmd([[
  if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
  endif
]])

-- Delete trailing white space on save, useful for some filetypes
vim.cmd([[
  fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
  endfun
]])

vim.cmd([[
  if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
  endif
]])

------------------------------------------------------------------------------------
-- => Spell checking
------------------------------------------------------------------------------------

-- Pressing <leader>ss will toggle and untoggle spell checking
vim.cmd("map <leader>ss :setlocal spell!<cr>")

-- Shortcuts using <leader>
vim.cmd([[
  map <leader>sn ]s
  map <leader>sp [s
  map <leader>sa zg
  map <leader>s? z=
]])

------------------------------------------------------------------------------------
-- => Misc
------------------------------------------------------------------------------------

-- Remove the Windows ^M - when the encodings gets messed up
vim.cmd("noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm")

-- Quickly open a buffer for scribble
vim.cmd("map <leader>q :e ~/buffer<cr>")

-- Quickly open a markdown buffer for scribble
vim.cmd("map <leader>x :e ~/buffer.md<cr>")

-- Toggle paste mode on and off
vim.cmd("map <leader>pp :setlocal paste!<cr>")

vim.opt.ambiwidth = "single"

-- Yank to system clipboard
vim.cmd("set clipboard+=unnamedplus")

------------------------------------------------------------------------------------
-- => Helper functions
------------------------------------------------------------------------------------

vim.cmd([[
  function! CmdLine(str)
    call feedkeys(":" . a:str)
  endfunction 
]])

vim.cmd([[
  function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
  endfunction
]])
