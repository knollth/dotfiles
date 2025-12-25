local servers = {
  "lua_ls",
  "tinymist",
  "hls",
  "basedpyright",
  "ruff",
  "ocamllsp",
  "clangd"
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      }
    }
  }
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    -- if client.name == "ruff" then
    --    client.server_capabilities.hoverProvider = false
    -- end
  end,
})

vim.opt.completeopt:append('noselect') -- show completion menu but don't automatically select first item, for lsp autocomplete (see lua/lsp.lua)
