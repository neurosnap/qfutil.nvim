# qfutil.nvim

A Neovim plugin that provides utilities for working with the quickfix list, allowing you to convert system command output into a quickfix list.

## Features

- Convert output from any system command into a quickfix list
- Auto-jump to the first result
- Toggle quickfix window open/closed
- Automatically formats file paths for quickfix
- Custom formatting function support

## Installation

### Using native package manager (v0.12+)

```lua
vim.pack.add("https://github.com/neurosnap/qfutil.nvim")
```

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "neurosnap/qfutil.nvim",
  config = function()
    require("qfutil").setup()
  end
}
```

## Configuration

The plugin works out of the box with no configuration required:

```lua
require("qfutil").setup({})
```

## Usage

### Commands

#### `:Qf {command}`
Executes a system command and populates the quickfix list with the output. Assumes the command returns a list of file paths (one per line) in the first column without spaces.

**Example:**
```vim
:Qf find . -name '*.lua'
:Qf git ls-files
:Qf rg -l 'pattern'
:Qf git diff --name-only
```

#### `:Qfa {command}`
Same as `:Qf`, but automatically jumps to the first result and opens the file.

**Example:**
```vim
:Qfa find . -name 'init.lua'
:Qfa fd -t f | fzf -f lua
```

### Functions

#### `require("qfutil").cqf(args)`
Converts command output to quickfix list.

**Parameters:**
- `cmd` (string): System command to execute
- `auto_jump` (boolean): Whether to jump to the first result
- `fmt` (function, optional): Custom formatting function for each line

**Example:**
```lua
require("qfutil").cqf({
  cmd = "find . -name '*.lua'",
  auto_jump = true
})
```

#### `require("qfutil").toggle_qf()`
Toggles the quickfix window open or closed.

**Example:**
```lua
vim.keymap.set('n', '<leader>q', require("qfutil").toggle_qf, { desc = "Toggle quickfix" })
```

## Use Cases

- Quickly browse files from `find` or `fd` commands
- Navigate through files returned by `git ls-files`
- View search results from `rg` or `grep` with `-l` flag
- Convert any file list into a navigable quickfix list

## License

MIT
