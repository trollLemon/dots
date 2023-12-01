
set number
set nospell
set path+=/home/haydn/Github/Dev/CPlus-palette/src/includes
nnoremap <silent> <C-]> :bnext<CR>
nnoremap <silent> <C-[> :bprev<CR>
call plug#begin()
" main one
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kamykn/spelunker.vim'
Plug 'rcarriga/nvim-notify'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
"Plug 'ms-jpq/coq_nvim', {'do': ':COQdeps'}
"Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}"
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'
Plug 'AlphaTechnolog/pywal.nvim', { 'as': 'pywal' }

call plug#end()
" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use K to show documentation in preview window
nnoremap <silent> l :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#confirm():
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()





let g:coq_settings = { 'auto_start': v:true }
let g:enable_spelunker_vim = 1
" Source the pywal color file
if filereadable(expand("~/.cache/wal/colors.vim"))
  source ~/.cache/wal/colors.vim
endif
" Customize the highlight groups using pywal colors
highlight CocErrorHighlight ctermfg=1 guifg=#color1
highlight CocWarningHighlight ctermfg=3 guifg=#color3
lua << EOF


-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true



require("telescope").load_extension "file_browser"
require('telescope').setup{
}
local pywal = require('pywal')

pywal.setup()

vim.api.nvim_set_keymap(
  "n",
  "<space>n",
  ":Telescope file_browser<CR>",
  { noremap = true }
)

local lsp = require "lspconfig"
--local coq = require "coq" -- add this
require("bufferline").setup{}


require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c","cpp","rust", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}




require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'pywal',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}




EOF
