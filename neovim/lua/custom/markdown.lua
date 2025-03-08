-- File: ~/.config/nvim/lua/custom/markdown.lua

local M = {}

-- Function to compile markdown to PDF and open/refresh in Zathura
function M.compile_markdown_to_pdf_old()
  local filepath = vim.fn.expand '%:p'
  local file_no_ext = vim.fn.expand '%:p:r'
  local output_pdf = file_no_ext .. '.pdf'

  -- Compile the Markdown file to PDF using Pandoc (with LaTeX math support)
  local compile_cmd = "pandoc '" .. filepath .. "' --pdf-engine=xelatex -o '" .. output_pdf .. "'"
  os.execute(compile_cmd)

  -- Check if Zathura is already open, refresh it if open, or open the file
  local refresh_cmd = 'zathura --synctex-forward ' .. vim.fn.line '.' .. ":0:'" .. filepath .. "' '" .. output_pdf .. "' >/dev/null 2>&1 &"
  os.execute('pkill -USR1 zathura || ' .. refresh_cmd)
end

-- Function to compile markdown to PDF and open/refresh in Zathura
function M.compile_markdown_to_pdf_blocking()
  local filepath = vim.fn.expand '%:p'
  local file_no_ext = vim.fn.expand '%:p:r'
  local output_pdf = file_no_ext .. '.pdf'

  -- Compile the Markdown file to PDF using Pandoc (with LaTeX math support)
  local compile_cmd = "pandoc '" .. filepath .. "' --pdf-engine=xelatex -o '" .. output_pdf .. "'"
  os.execute(compile_cmd)

  -- Function to check if Zathura is running
  local function is_zathura_running()
    local handle = io.popen 'pgrep -x zathura'
    local result = handle:read '*a'
    handle:close()
    return result ~= '' -- Return true if Zathura is running, false otherwise
  end

  -- If Zathura is not running, open it with the newly compiled PDF
  if not is_zathura_running() then
    local open_cmd = "zathura '" .. output_pdf .. "' >/dev/null 2>&1 &"
    os.execute(open_cmd)
  end

  -- Zathura will auto-reload the PDF if it is already open
end
-- Function to compile markdown to PDF and open/refresh in Zathura
function M.compile_markdown_to_pdf()
  vim.cmd 'write'
  local filepath = vim.fn.expand '%:p'
  local file_no_ext = vim.fn.expand '%:p:r'
  local output_pdf = file_no_ext .. '.pdf'

  -- Compile the Markdown file to PDF using Pandoc (with LaTeX math support)
  local compile_cmd = {
    'pandoc',
    filepath,
    '--pdf-engine=xelatex',
    '-o',
    output_pdf,
  }

  vim.fn.jobstart(compile_cmd, {
    on_exit = function()
      -- Function to check if Zathura is running
      local function is_zathura_running()
        local handle = io.popen 'pgrep -x zathura'
        local result = handle:read '*a'
        handle:close()
        return result ~= '' -- Return true if Zathura is running, false otherwise
      end

      -- If Zathura is not running, open it with the newly compiled PDF
      if not is_zathura_running() then
        local open_cmd = { 'zathura', output_pdf }
        vim.fn.jobstart(open_cmd, { detach = true })
      end

      -- Zathura will auto-reload the PDF if it is already open
    end,
  })
end

return M
