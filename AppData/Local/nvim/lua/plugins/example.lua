-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
return 
  {
{
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = true },
  },
  init = function()
    local lsp_keys = require("lazyvim.plugins.lsp.keymaps")
    local keys = lsp_keys.get()
    for _, key in ipairs(keys) do
      if key[1] == "K" then key[1] = "gh" end
    end
  end,
}
  }
