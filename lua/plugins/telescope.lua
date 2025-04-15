--------------------
-- TELESCOPE      --
-- (Fuzzy Finder) --
--------------------

-- Telescope configuration
local telescope = require('telescope')

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      }
    },
    path_display = {"truncate"}
  },
  pickers = {
    find_files = {
      follow = true
    }
  }
}

-- Telescope keymaps
local telescope_loaded, builtin = pcall(require, 'telescope.builtin')
if telescope_loaded then
  -- Find files in current working directory
  vim.keymap.set('n', '<leader>ff', function() 
    builtin.find_files({cwd = vim.fn.getcwd()})
  end, {desc = 'Find files in current directory'}) -- <Space>ff to find files in current directory
  
  -- Live grep in current working directory
  vim.keymap.set('n', '<leader>fg', function()
    builtin.live_grep({cwd = vim.fn.getcwd()})
  end, {desc = 'Live grep in current directory'}) -- <Space>fg to search text in files
  
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'Find buffers'}) -- <Space>fb to search open buffers
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = 'Find help tags'}) -- <Space>fh to search help documentation
  
  -- Find files in the current file's directory
  vim.keymap.set('n', '<leader>fd', function()
    local current_file_dir = vim.fn.expand('%:p:h')
    builtin.find_files({cwd = current_file_dir})
  end, {desc = 'Find files in current file directory'}) -- <Space>fd to find files in current file's directory
  
  -- Search in project directory (git root if available)
  vim.keymap.set('n', '<leader>fp', function()
    -- Try to find git root
    local git_dir = vim.fn.system('git rev-parse --show-toplevel 2>/dev/null'):gsub('\n', '')
    local cwd = vim.fn.getcwd()
    
    -- If git command succeeded and returned a directory
    if vim.v.shell_error == 0 and git_dir ~= "" then
      builtin.find_files({cwd = git_dir})
    else
      -- Fall back to current working directory
      builtin.find_files({cwd = cwd})
    end
  end, {desc = 'Find files in project directory'}) -- <Space>fp to find files in project root (git)
  
  -- Always search from project root (where Neovim was started)
  vim.keymap.set('n', '<leader>fr', function() 
    -- Get the initial working directory (where Neovim was started)
    local initial_cwd = vim.fn.getcwd(1)
    builtin.find_files({cwd = initial_cwd})
  end, {desc = 'Find files from project root'}) -- <Space>fr to find files from where nvim was started
  
  -- Search in specific subdirectories
  vim.keymap.set('n', '<leader>fs', function() 
    local initial_cwd = vim.fn.getcwd(1)
    builtin.find_files({cwd = initial_cwd .. "/src"})
  end, {desc = 'Find files in src directory'}) -- <Space>fs to find files in src/ directory
  
  vim.keymap.set('n', '<leader>fa', function() 
    local initial_cwd = vim.fn.getcwd(1)
    builtin.find_files({cwd = initial_cwd .. "/app"})
  end, {desc = 'Find files in app directory'}) -- <Space>fa to find files in app/ directory
end

return telescope
