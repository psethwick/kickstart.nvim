-- George colorscheme - Enhanced Zellner with classic pink accents
-- Based on the classic Zellner theme with improved Treesitter support and original pink highlights
-- Place this file in ~/.config/nvim/colors/george.lua

local M = {}

-- Clear existing highlighting
vim.cmd 'highlight clear'
if vim.fn.exists 'syntax_on' then
  vim.cmd 'syntax reset'
end

vim.g.colors_name = 'george'
vim.o.background = 'light'

-- Color palette - keeping Zellner's light theme aesthetic but enhancing it
local colors = {
  -- Base colors
  bg = '#ffffff',
  fg = '#000000',

  -- Grays
  gray1 = '#f5f5f5',
  gray2 = '#e0e0e0',
  gray3 = '#c0c0c0',
  gray4 = '#808080',
  gray5 = '#606060',
  gray6 = '#404040',

  -- Enhanced colors for syntax highlighting
  red = '#cc0000',
  green = '#007700',
  blue = '#0066cc',
  cyan = '#0099cc',
  magenta = '#cc00cc',
  yellow = '#ccaa00',
  orange = '#cc6600',

  -- Darker variants for better contrast
  dark_red = '#990000',
  dark_green = '#005500',
  dark_blue = '#004499',
  dark_cyan = '#007799',
  dark_magenta = '#990099',
  dark_yellow = '#997700',
  dark_orange = '#994400',

  -- Special colors - keeping Zellner's signature pink!
  purple = '#6600cc',
  brown = '#996633',
  pink = '#ff6699', -- Classic Zellner pink
  dark_pink = '#cc0066', -- Darker variant for better contrast

  -- UI colors
  cursor_line = '#f8f8f8',
  visual = '#e6e6ff',
  search = '#ffff99',
  inc_search = '#ffcc99',
  line_nr = '#999999',
  cursor_line_nr = '#333333',
  status_line = '#e0e0e0',
  tab_line = '#f0f0f0',
  fold = '#f5f5f5',
  diff_add = '#e6ffe6',
  diff_delete = '#ffe6e6',
  diff_change = '#fff6e6',
}

-- Helper function to set highlights
local function hi(group, opts)
  local cmd = 'highlight ' .. group
  if opts.fg then
    cmd = cmd .. ' guifg=' .. opts.fg
  end
  if opts.bg then
    cmd = cmd .. ' guibg=' .. opts.bg
  end
  if opts.style then
    cmd = cmd .. ' gui=' .. opts.style
  end
  if opts.sp then
    cmd = cmd .. ' guisp=' .. opts.sp
  end
  vim.cmd(cmd)
end

-- Basic UI highlights
hi('Normal', { fg = colors.fg, bg = colors.bg })
hi('Cursor', { fg = colors.bg, bg = colors.fg })
hi('CursorLine', { bg = colors.cursor_line })
hi('CursorColumn', { bg = colors.cursor_line })
hi('LineNr', { fg = colors.line_nr })
hi('CursorLineNr', { fg = colors.cursor_line_nr, style = 'bold' })
hi('Visual', { bg = colors.visual })
hi('VisualNOS', { bg = colors.visual })
hi('Search', { bg = colors.search })
hi('IncSearch', { bg = colors.inc_search })
hi('MatchParen', { bg = colors.gray2, style = 'bold' })

-- Status line and tabs
hi('StatusLine', { fg = colors.fg, bg = colors.status_line })
hi('StatusLineNC', { fg = colors.gray5, bg = colors.gray2 })
hi('TabLine', { fg = colors.gray5, bg = colors.tab_line })
hi('TabLineFill', { bg = colors.gray2 })
hi('TabLineSel', { fg = colors.fg, bg = colors.bg, style = 'bold' })

-- Folds and diffs
hi('Folded', { fg = colors.gray5, bg = colors.fold })
hi('FoldColumn', { fg = colors.gray4, bg = colors.bg })
hi('DiffAdd', { bg = colors.diff_add })
hi('DiffDelete', { bg = colors.diff_delete })
hi('DiffChange', { bg = colors.diff_change })
hi('DiffText', { bg = colors.inc_search, style = 'bold' })

-- Popup menu
hi('Pmenu', { fg = colors.fg, bg = colors.gray1 })
hi('PmenuSel', { fg = colors.bg, bg = colors.blue })
hi('PmenuSbar', { bg = colors.gray3 })
hi('PmenuThumb', { bg = colors.gray5 })

-- Messages and errors
hi('ErrorMsg', { fg = colors.red, style = 'bold' })
hi('WarningMsg', { fg = colors.orange, style = 'bold' })
hi('MoreMsg', { fg = colors.green, style = 'bold' })
hi('Question', { fg = colors.blue, style = 'bold' })

-- Basic syntax highlighting (compatible with both traditional and Treesitter)
hi('Comment', { fg = colors.gray5, style = 'italic' })
hi('Constant', { fg = colors.dark_red })
hi('String', { fg = colors.dark_green })
hi('Character', { fg = colors.dark_green })
hi('Number', { fg = colors.dark_red })
hi('Boolean', { fg = colors.dark_red })
hi('Float', { fg = colors.dark_red })

hi('Identifier', { fg = colors.dark_blue })
hi('Function', { fg = colors.dark_magenta })

hi('Statement', { fg = colors.dark_pink, style = 'bold' })
hi('Conditional', { fg = colors.dark_pink, style = 'bold' })
hi('Repeat', { fg = colors.dark_pink, style = 'bold' })
hi('Label', { fg = colors.dark_pink, style = 'bold' })
hi('Operator', { fg = colors.dark_orange })
hi('Keyword', { fg = colors.dark_pink, style = 'bold' })
hi('Exception', { fg = colors.dark_pink, style = 'bold' })

hi('PreProc', { fg = colors.dark_cyan })
hi('Include', { fg = colors.dark_cyan })
hi('Define', { fg = colors.dark_cyan })
hi('Macro', { fg = colors.dark_cyan })
hi('PreCondit', { fg = colors.dark_cyan })

hi('Type', { fg = colors.dark_blue, style = 'bold' })
hi('StorageClass', { fg = colors.dark_blue, style = 'bold' })
hi('Structure', { fg = colors.dark_blue, style = 'bold' })
hi('Typedef', { fg = colors.dark_blue, style = 'bold' })

hi('Special', { fg = colors.dark_orange })
hi('SpecialChar', { fg = colors.dark_orange })
hi('Tag', { fg = colors.dark_orange })
hi('Delimiter', { fg = colors.gray6 })
hi('SpecialComment', { fg = colors.brown, style = 'italic' })
hi('Debug', { fg = colors.dark_orange })

hi('Underlined', { style = 'underline' })
hi('Ignore', { fg = colors.gray3 })
hi('Error', { fg = colors.red, bg = colors.bg, style = 'bold' })
hi('Todo', { fg = colors.pink, bg = colors.yellow, style = 'bold' })

-- Enhanced Treesitter highlights
-- Literals
hi('@string', { fg = colors.dark_green })
hi('@string.documentation', { fg = colors.green, style = 'italic' })
hi('@string.regexp', { fg = colors.orange })
hi('@string.escape', { fg = colors.dark_orange })
hi('@string.special', { fg = colors.dark_orange })

hi('@character', { fg = colors.dark_green })
hi('@character.special', { fg = colors.dark_orange })

hi('@boolean', { fg = colors.dark_red, style = 'bold' })
hi('@number', { fg = colors.dark_red })
hi('@float', { fg = colors.dark_red })

-- Functions
hi('@function', { fg = colors.dark_magenta })
hi('@function.builtin', { fg = colors.magenta, style = 'bold' })
hi('@function.call', { fg = colors.dark_magenta })
hi('@function.macro', { fg = colors.dark_cyan })

hi('@method', { fg = colors.dark_magenta })
hi('@method.call', { fg = colors.dark_magenta })

hi('@constructor', { fg = colors.dark_blue, style = 'bold' })
hi('@parameter', { fg = colors.brown })

-- Keywords
hi('@keyword', { fg = colors.dark_pink, style = 'bold' })
hi('@keyword.function', { fg = colors.dark_pink, style = 'bold' })
hi('@keyword.operator', { fg = colors.dark_pink, style = 'bold' })
hi('@keyword.return', { fg = colors.dark_pink, style = 'bold' })
hi('@keyword.conditional', { fg = colors.dark_pink, style = 'bold' })
hi('@keyword.repeat', { fg = colors.dark_pink, style = 'bold' })
hi('@keyword.import', { fg = colors.dark_cyan, style = 'bold' })
hi('@keyword.export', { fg = colors.dark_cyan, style = 'bold' })

hi('@conditional', { fg = colors.dark_pink, style = 'bold' })
hi('@repeat', { fg = colors.dark_pink, style = 'bold' })
hi('@label', { fg = colors.pink })

-- Operators
hi('@operator', { fg = colors.dark_orange })

-- Punctuation
hi('@punctuation.delimiter', { fg = colors.gray6 })
hi('@punctuation.bracket', { fg = colors.gray6 })
hi('@punctuation.special', { fg = colors.dark_orange })

-- Types
hi('@type', { fg = colors.dark_blue, style = 'bold' })
hi('@type.builtin', { fg = colors.blue, style = 'bold' })
hi('@type.definition', { fg = colors.dark_blue, style = 'bold' })
hi('@type.qualifier', { fg = colors.dark_pink })

hi('@storageclass', { fg = colors.dark_pink, style = 'bold' })
hi('@attribute', { fg = colors.dark_cyan })
hi('@field', { fg = colors.brown })
hi('@property', { fg = colors.brown })

-- Identifiers
hi('@variable', { fg = colors.fg })
hi('@variable.builtin', { fg = colors.dark_blue, style = 'bold' })
hi('@constant', { fg = colors.dark_red })
hi('@constant.builtin', { fg = colors.red, style = 'bold' })
hi('@constant.macro', { fg = colors.dark_cyan })

hi('@namespace', { fg = colors.dark_blue })
hi('@symbol', { fg = colors.dark_blue })

-- Text
hi('@text', { fg = colors.fg })
hi('@text.strong', { style = 'bold' })
hi('@text.emphasis', { style = 'italic' })
hi('@text.underline', { style = 'underline' })
hi('@text.strike', { style = 'strikethrough' })
hi('@text.title', { fg = colors.dark_blue, style = 'bold' })
hi('@text.literal', { fg = colors.dark_green })
hi('@text.uri', { fg = colors.dark_cyan, style = 'underline' })
hi('@text.math', { fg = colors.dark_blue })
hi('@text.environment', { fg = colors.dark_cyan })
hi('@text.environment.name', { fg = colors.dark_blue })
hi('@text.reference', { fg = colors.dark_orange })

hi('@text.todo', { fg = colors.pink, bg = colors.yellow, style = 'bold' })
hi('@text.note', { fg = colors.blue, style = 'bold' })
hi('@text.warning', { fg = colors.orange, style = 'bold' })
hi('@text.danger', { fg = colors.red, style = 'bold' })

-- Tags
hi('@tag', { fg = colors.dark_blue })
hi('@tag.attribute', { fg = colors.brown })
hi('@tag.delimiter', { fg = colors.gray6 })

-- Language specific
-- HTML
hi('@tag.html', { fg = colors.dark_blue })
hi('@tag.attribute.html', { fg = colors.brown })

-- CSS
hi('@property.css', { fg = colors.dark_blue })
hi('@type.css', { fg = colors.dark_magenta })

-- JavaScript/TypeScript
hi('@variable.javascript', { fg = colors.fg })
hi('@variable.typescript', { fg = colors.fg })

-- Python
hi('@variable.python', { fg = colors.fg })

-- Comments
hi('@comment', { fg = colors.gray5, style = 'italic' })
hi('@comment.documentation', { fg = colors.green, style = 'italic' })

-- Errors
hi('@error', { fg = colors.red })

-- Spell checking
hi('SpellBad', { sp = colors.red, style = 'undercurl' })
hi('SpellCap', { sp = colors.blue, style = 'undercurl' })
hi('SpellLocal', { sp = colors.cyan, style = 'undercurl' })
hi('SpellRare', { sp = colors.magenta, style = 'undercurl' })

-- LSP highlights
hi('DiagnosticError', { fg = colors.red })
hi('DiagnosticWarn', { fg = colors.orange })
hi('DiagnosticInfo', { fg = colors.blue })
hi('DiagnosticHint', { fg = colors.cyan })

hi('DiagnosticVirtualTextError', { fg = colors.red, bg = colors.bg })
hi('DiagnosticVirtualTextWarn', { fg = colors.orange, bg = colors.bg })
hi('DiagnosticVirtualTextInfo', { fg = colors.blue, bg = colors.bg })
hi('DiagnosticVirtualTextHint', { fg = colors.cyan, bg = colors.bg })

hi('DiagnosticUnderlineError', { sp = colors.red, style = 'undercurl' })
hi('DiagnosticUnderlineWarn', { sp = colors.orange, style = 'undercurl' })
hi('DiagnosticUnderlineInfo', { sp = colors.blue, style = 'undercurl' })
hi('DiagnosticUnderlineHint', { sp = colors.cyan, style = 'undercurl' })

-- Git signs
hi('GitSignsAdd', { fg = colors.green })
hi('GitSignsChange', { fg = colors.orange })
hi('GitSignsDelete', { fg = colors.red })

-- Make the colorscheme available
M.colors = colors
M.setup = function()
  -- This function can be used for any additional setup if needed
end

return M
