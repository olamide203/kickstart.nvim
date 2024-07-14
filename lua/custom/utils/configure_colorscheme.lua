local M = {}

M.setup = function(color)
  -- Attempt to set the colorscheme
  local success, err = pcall(vim.cmd.colorscheme, color)
  if not success then
    vim.notify('Error setting colorscheme: ' .. err, vim.log.levels.ERROR)
    return
  end

  -- Define highlight groups
  local highlight_groups = {
    Normal = { bg = 'none' },
    NormalFloat = { bg = 'none' },
  }

  -- Apply highlight groups
  for group, settings in pairs(highlight_groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

return M
