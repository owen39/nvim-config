# Tree-sitter in Neovim

## The problem

Without Tree-sitter, Neovim highlights code using regex patterns. These patterns match text superficially — they see `const` as a keyword and `useEffect` as just... text. That's why they end up the same color. Regex can't understand structure.

## What Tree-sitter actually is

Tree-sitter is a **parser** — the same kind of thing a compiler uses to understand your code. It reads your file and builds a syntax tree: a structured representation of what every piece of code *is* (a function call, a variable declaration, a type annotation, a JSX tag).

It's not a Neovim thing. It's a standalone tool used by many editors. It has three parts:

1. **The CLI** (`tree-sitter-cli` via npm) — compiles grammar files into parser binaries (`.so` files)
2. **Language grammars** — community-written definitions of each language's syntax (one for TSX, one for Go, etc.)
3. **Editor integrations** — Neovim's `nvim-treesitter` plugin, VS Code's built-in support, etc.

## How it works in this config

Three things need to happen for Tree-sitter highlighting to work:

### 1. Parser binaries must exist

The `.so` files in `~/.local/share/nvim/site/parser/` (e.g. `tsx.so`) are compiled parsers. They're what actually reads your code. The `nvim-treesitter` plugin downloads grammar source code and uses the `tree-sitter` CLI to compile them.

`:TSInstall tsx` = "download the TSX grammar and compile it into a `.so` I can load."

### 2. Query files must exist

In `nvim-treesitter/runtime/queries/tsx/`, there are `.scm` files (Scheme-like syntax). These map tree nodes to highlight groups:

```scheme
(call_expression function: (identifier) @function.call)
```

This says: "when you see a call expression, tag the function name as `@function.call`." The theme then decides what color `@function.call` gets.

### 3. Highlighting must be started

`vim.treesitter.start()` tells Neovim: "for this buffer, use the tree-sitter parser instead of regex." Without this call, parsers can be installed but Neovim won't use them.

In the config, this is done via an autocmd on `FileType` — every time a buffer gets a filetype, we start tree-sitter for it.

## The full chain

```
You open App.tsx
  -> Neovim sets filetype=typescriptreact
  -> FileType autocmd fires, calls vim.treesitter.start()
  -> Neovim loads tsx.so, parses the buffer into a tree
  -> Query files map tree nodes to @highlight.groups
  -> Your colorscheme maps @highlight.groups to colors
  -> const = @keyword (purple), useEffect = @function.call (blue)
```

## Your config explained

```lua
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",          -- recompile parsers when the plugin updates
    config = function()
        require("nvim-treesitter").setup({})
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)  -- start tree-sitter for every buffer
            end,
        })
    end,
}
```

- `build = ":TSUpdate"` — when lazy.nvim updates the plugin, recompile all installed parsers (grammars evolve)
- `setup({})` — initialize the plugin (no special config needed)
- The `FileType` autocmd — start tree-sitter highlighting for every file you open
- `pcall` — silently ignore files that don't have a parser installed (e.g. if you open a `.toml` but never installed that parser)

## Installing new language parsers

```vim
:TSInstall rust python
```

This requires the `tree-sitter` CLI (`npm install -g tree-sitter-cli`), because it compiles C code into the `.so` binary that Neovim loads.

## Debugging

- `:Inspect` on a token — shows what highlight group it has. `@function.call` = tree-sitter is working. `typescriptIdentifierName` = old regex fallback.
- `:InspectTree` — shows the full syntax tree for the buffer.
- `:TSInstallInfo` — shows which parsers are installed.
