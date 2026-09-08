 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#171210',
    base01 = '#231f1c',
    base02 = '#2e2926',
    base03 = '#9e8e85',
    base04 = '#d5c3b9',
    base05 = '#ebe0dc',
    base06 = '#ebe0dc',
    base07 = '#ebe0dc',
    base08 = '#ffb4ab',
    base09 = '#d6d497',
    base0A = '#dfc0ae',
    base0B = '#ffc49f',
    base0C = '#ccc98e',
    base0D = '#f4ba95',
    base0E = '#dfc0ae',
    base0F = '#fcdcc9',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#ebe0dc',          bg = '#171210' })
  hi('TelescopeBorder',         { fg = '#9e8e85',             bg = '#171210' })
  hi('TelescopePromptNormal',   { fg = '#ebe0dc',          bg = '#171210' })
  hi('TelescopePromptBorder',   { fg = '#9e8e85',             bg = '#171210' })
  hi('TelescopePromptPrefix',   { fg = '#ffc49f',             bg = '#171210' })
  hi('TelescopePromptCounter',  { fg = '#d5c3b9',  bg = '#171210' })
  hi('TelescopePromptTitle',    { fg = '#171210',             bg = '#ffc49f' })
  hi('TelescopePreviewTitle',   { fg = '#171210',             bg = '#dfc0ae' })
  hi('TelescopeResultsTitle',   { fg = '#171210',             bg = '#d6d497' })
  hi('TelescopeSelection',      { fg = '#ebe0dc',          bg = '#2e2926' })
  hi('TelescopeSelectionCaret', { fg = '#ffc49f',             bg = '#2e2926' })
  hi('TelescopeMatching',       { fg = '#ffc49f',             bold = true })
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
