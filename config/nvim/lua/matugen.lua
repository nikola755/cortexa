 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#18120f',
    base01 = '#251e1b',
    base02 = '#302925',
    base03 = '#a08d83',
    base04 = '#d8c2b7',
    base05 = '#ede0da',
    base06 = '#ede0da',
    base07 = '#ede0da',
    base08 = '#ffb4ab',
    base09 = '#cacb78',
    base0A = '#e8bea6',
    base0B = '#ffb689',
    base0C = '#cacb78',
    base0D = '#ffb689',
    base0E = '#e8bea6',
    base0F = '#ffdbc8',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#ede0da',          bg = '#18120f' })
  hi('TelescopeBorder',         { fg = '#a08d83',             bg = '#18120f' })
  hi('TelescopePromptNormal',   { fg = '#ede0da',          bg = '#18120f' })
  hi('TelescopePromptBorder',   { fg = '#a08d83',             bg = '#18120f' })
  hi('TelescopePromptPrefix',   { fg = '#ffb689',             bg = '#18120f' })
  hi('TelescopePromptCounter',  { fg = '#d8c2b7',  bg = '#18120f' })
  hi('TelescopePromptTitle',    { fg = '#18120f',             bg = '#ffb689' })
  hi('TelescopePreviewTitle',   { fg = '#18120f',             bg = '#e8bea6' })
  hi('TelescopeResultsTitle',   { fg = '#18120f',             bg = '#cacb78' })
  hi('TelescopeSelection',      { fg = '#ede0da',          bg = '#302925' })
  hi('TelescopeSelectionCaret', { fg = '#ffb689',             bg = '#302925' })
  hi('TelescopeMatching',       { fg = '#ffb689',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
