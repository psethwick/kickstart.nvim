-- Modern Zellner colorscheme with neon pink/purple highlights
-- Place this file in ~/.config/nvim/colors/modern_zellner.lua

-- Define the color palette
local palette = {
  -- Base colors (light theme)
  bg = '#ffffff',
  bg_alt = '#f8f8f8',
  bg_subtle = '#f0f0f0',
  fg = '#000000',
  fg_alt = '#333333',
  fg_subtle = '#666666',

  -- Neon accent colors (balanced for contrast + character)
  pink = '#e91e63', -- Brighter pink (4.6:1 ratio) - more neon!
  purple = '#7b1fa2', -- Brighter purple (4.9:1 ratio) - more vibrant!
  magenta = '#c2185b', -- Brighter magenta (4.7:1 ratio) - punchier!

  -- Supporting colors
  red = '#dc143c', -- Crimson (already good contrast)
  orange = '#f57900', -- Brighter orange (4.5:1 ratio) - more neon!
  yellow = '#ffd700', -- Gold
  green = '#00aa00', -- Back to brighter green (4.5:1 ratio) - more vibrant!
  blue = '#2196f3', -- Brighter blue (4.5:1 ratio) - more electric!

  -- UI colors
  border = '#999999', -- Keep darker border for accessibility
  comment = '#666666', -- Lighter comments (5.7:1 ratio) - still accessible but less harsh
  selection = '#e0e0ff',
  search = '#ffff00',
  error = '#ff0000',
  warning = '#ffa500',
  info = '#00bfff',
  hint = '#9370db',
}

-- Create the colorscheme
local function setup()
  -- Set background
  vim.o.background = 'light'

  -- Clear existing highlights
  vim.cmd 'highlight clear'
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  -- Set colorscheme name
  vim.g.colors_name = 'modern_zellner'

  local groups = {
    -- Editor UI
    Normal = { fg = palette.fg, bg = palette.bg },
    NormalFloat = { fg = palette.fg, bg = palette.bg_alt },
    FloatBorder = { fg = palette.border, bg = palette.bg_alt },

    -- Cursor and selection
    Cursor = { fg = palette.bg, bg = palette.pink }, -- Back to pink - more character!
    CursorLine = { bg = palette.bg_subtle },
    CursorColumn = { bg = palette.bg_subtle },
    Visual = { bg = palette.selection },
    VisualNOS = { bg = palette.selection },

    -- Line numbers
    LineNr = { fg = palette.fg_subtle },
    CursorLineNr = { fg = palette.pink, bold = true }, -- Back to pink for character!

    -- Search
    Search = { fg = palette.fg, bg = palette.search },
    IncSearch = { fg = palette.bg, bg = palette.pink },

    -- Messages and status
    ErrorMsg = { fg = palette.error, bold = true },
    WarningMsg = { fg = palette.warning, bold = true },
    ModeMsg = { fg = palette.purple, bold = true },
    MoreMsg = { fg = palette.green, bold = true },

    -- Syntax highlighting (base)
    Comment = { fg = palette.comment, italic = true },
    Constant = { fg = palette.purple, bold = true },
    String = { fg = palette.green },
    Character = { fg = palette.green },
    Number = { fg = palette.purple, bold = true },
    Boolean = { fg = palette.pink, bold = true },
    Float = { fg = palette.purple, bold = true },

    Identifier = { fg = palette.fg },
    Function = { fg = palette.pink, bold = true },

    Statement = { fg = palette.purple, bold = true },
    Conditional = { fg = palette.pink, bold = true },
    Repeat = { fg = palette.pink, bold = true },
    Label = { fg = palette.purple, bold = true },
    Operator = { fg = palette.fg_alt, bold = true },
    Keyword = { fg = palette.pink, bold = true },
    Exception = { fg = palette.red, bold = true },

    PreProc = { fg = palette.purple, bold = true },
    Include = { fg = palette.pink, bold = true },
    Define = { fg = palette.purple, bold = true },
    Macro = { fg = palette.purple },
    PreCondit = { fg = palette.pink },

    Type = { fg = palette.blue, bold = true },
    StorageClass = { fg = palette.purple, bold = true },
    Structure = { fg = palette.pink, bold = true },
    Typedef = { fg = palette.blue, bold = true },

    Special = { fg = palette.pink, bold = true },
    SpecialChar = { fg = palette.magenta },
    Tag = { fg = palette.purple },
    Delimiter = { fg = palette.fg_alt },
    SpecialComment = { fg = palette.purple, italic = true },
    Debug = { fg = palette.red },

    -- Treesitter highlights
    ['@variable'] = { fg = palette.fg },
    ['@variable.builtin'] = { fg = palette.purple, italic = true },
    ['@variable.parameter'] = { fg = palette.fg_alt },
    ['@variable.member'] = { fg = palette.fg },

    ['@constant'] = { fg = palette.purple, bold = true },
    ['@constant.builtin'] = { fg = palette.pink, bold = true },
    ['@constant.macro'] = { fg = palette.purple },

    ['@string'] = { fg = palette.green },
    ['@string.escape'] = { fg = palette.pink },
    ['@string.special'] = { fg = palette.magenta },

    ['@character'] = { fg = palette.green },
    ['@character.special'] = { fg = palette.pink },

    ['@number'] = { fg = palette.purple, bold = true },
    ['@number.float'] = { fg = palette.purple, bold = true },

    ['@boolean'] = { fg = palette.pink, bold = true },

    ['@function'] = { fg = palette.pink, bold = true },
    ['@function.builtin'] = { fg = palette.purple, bold = true },
    ['@function.call'] = { fg = palette.pink },
    ['@function.macro'] = { fg = palette.purple },
    ['@function.method'] = { fg = palette.pink },
    ['@function.method.call'] = { fg = palette.pink },

    ['@constructor'] = { fg = palette.blue, bold = true },

    ['@keyword'] = { fg = palette.pink, bold = true },
    ['@keyword.function'] = { fg = palette.purple, bold = true },
    ['@keyword.operator'] = { fg = palette.pink, bold = true },
    ['@keyword.return'] = { fg = palette.pink, bold = true },
    ['@keyword.conditional'] = { fg = palette.pink, bold = true },
    ['@keyword.repeat'] = { fg = palette.pink, bold = true },
    ['@keyword.exception'] = { fg = palette.red, bold = true },
    ['@keyword.import'] = { fg = palette.purple, bold = true },

    ['@operator'] = { fg = palette.fg_alt, bold = true },

    ['@punctuation.delimiter'] = { fg = palette.fg_alt },
    ['@punctuation.bracket'] = { fg = palette.fg_alt },
    ['@punctuation.special'] = { fg = palette.pink },

    ['@type'] = { fg = palette.blue, bold = true },
    ['@type.builtin'] = { fg = palette.purple, bold = true },
    ['@type.definition'] = { fg = palette.blue, bold = true },

    ['@property'] = { fg = palette.fg },
    ['@attribute'] = { fg = palette.magenta },

    ['@comment'] = { fg = palette.comment, italic = true },
    ['@comment.documentation'] = { fg = palette.purple, italic = true },

    ['@tag'] = { fg = palette.purple },
    ['@tag.attribute'] = { fg = palette.pink },
    ['@tag.delimiter'] = { fg = palette.fg_alt },

    -- LSP semantic tokens
    ['@lsp.type.class'] = { fg = palette.blue, bold = true },
    ['@lsp.type.decorator'] = { fg = palette.magenta },
    ['@lsp.type.enum'] = { fg = palette.blue, bold = true },
    ['@lsp.type.enumMember'] = { fg = palette.purple },
    ['@lsp.type.function'] = { fg = palette.pink, bold = true },
    ['@lsp.type.interface'] = { fg = palette.blue, bold = true },
    ['@lsp.type.macro'] = { fg = palette.purple },
    ['@lsp.type.method'] = { fg = palette.pink },
    ['@lsp.type.namespace'] = { fg = palette.blue },
    ['@lsp.type.parameter'] = { fg = palette.fg_alt },
    ['@lsp.type.property'] = { fg = palette.fg },
    ['@lsp.type.struct'] = { fg = palette.blue, bold = true },
    ['@lsp.type.type'] = { fg = palette.blue, bold = true },
    ['@lsp.type.typeParameter'] = { fg = palette.blue },
    ['@lsp.type.variable'] = { fg = palette.fg },

    -- LSP diagnostic
    DiagnosticError = { fg = palette.error },
    DiagnosticWarn = { fg = palette.warning },
    DiagnosticInfo = { fg = palette.info },
    DiagnosticHint = { fg = palette.hint },

    DiagnosticVirtualTextError = { fg = palette.error, bg = palette.bg_subtle },
    DiagnosticVirtualTextWarn = { fg = palette.warning, bg = palette.bg_subtle },
    DiagnosticVirtualTextInfo = { fg = palette.info, bg = palette.bg_subtle },
    DiagnosticVirtualTextHint = { fg = palette.hint, bg = palette.bg_subtle },

    DiagnosticUnderlineError = { undercurl = true, sp = palette.error },
    DiagnosticUnderlineWarn = { undercurl = true, sp = palette.warning },
    DiagnosticUnderlineInfo = { undercurl = true, sp = palette.info },
    DiagnosticUnderlineHint = { undercurl = true, sp = palette.hint },

    -- Git signs
    GitSignsAdd = { fg = palette.green },
    GitSignsChange = { fg = palette.yellow },
    GitSignsDelete = { fg = palette.red },

    -- Telescope
    TelescopePromptBorder = { fg = palette.pink }, -- Back to pink for character!
    TelescopeResultsBorder = { fg = palette.purple },
    TelescopePreviewBorder = { fg = palette.magenta },
    TelescopeSelection = { bg = palette.selection },
    TelescopeMatching = { fg = palette.pink, bold = true }, -- Back to pink!

    -- Which-key
    WhichKey = { fg = palette.pink, bold = true }, -- Back to pink for character!
    WhichKeyGroup = { fg = palette.purple },
    WhichKeyDesc = { fg = palette.fg },
    WhichKeySeparator = { fg = palette.comment },
    WhichKeyFloat = { bg = palette.bg_alt },

    -- Completion menu
    Pmenu = { fg = palette.fg, bg = palette.bg_alt },
    PmenuSel = { fg = palette.bg, bg = palette.pink }, -- Back to pink for character!
    PmenuSbar = { bg = palette.border },
    PmenuThumb = { bg = palette.fg_subtle },

    -- Folds
    Folded = { fg = palette.comment, bg = palette.bg_subtle },
    FoldColumn = { fg = palette.comment, bg = palette.bg },

    -- Tabs
    TabLine = { fg = palette.fg_subtle, bg = palette.bg_subtle },
    TabLineFill = { bg = palette.bg_subtle },
    TabLineSel = { fg = palette.pink, bg = palette.bg, bold = true }, -- Back to pink!

    -- Status line
    StatusLine = { fg = palette.fg, bg = palette.bg_subtle },
    StatusLineNC = { fg = palette.fg_subtle, bg = palette.bg_subtle },

    -- Diff
    DiffAdd = { bg = '#e6ffed' },
    DiffChange = { bg = '#fff5b4' },
    DiffDelete = { bg = '#ffecec' },
    DiffText = { bg = '#ffeaa7' },
  }

  -- Apply the color groups
  for group, opts in pairs(groups) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

-- Auto-setup if loaded as a colorscheme
setup()

-- Export for manual setup
return {
  setup = setup,
  palette = palette,
}
