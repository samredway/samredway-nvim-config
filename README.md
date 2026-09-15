# My Nvim Config

Just my nvim config. I keep it here because its handy to be able to pull it onto multiple devices (I work on mac though so dont know if it works well on other setups).

This is a simple setup which I use daily as a software engineer working with primarily Python (for which I use pylsp, flake8 and mypy respectively for code completion, linting and static analysis). However I also work on and have decent config here for Js and Typescript, C++, Golang and Java, you will have to uncomment the relevant sections for those last three though and install dependencies as required.

If you stumble across this and want to use it or just check or copy something from my config feel free. I think the way I have mypy setup using [Guard](https://github.com/nvimdev/guard.nvim), for example, is probably the best/easiest way to do this.

I gained original inspiration for the excellent [Kickstart](https://github.com/nvim-lua/kickstart.nvim) project, so you should probably check that out if you want a minimal setup from scratch with plenty of instructions including how to setup the base dependencies - notable Lazy.nvim.

## Fresh install on macOS

This configuration requires Neovim 0.12 or newer, Git, `curl`, `tar`, a C compiler, and `tree-sitter-cli` 0.26.1 or newer. Install the macOS dependencies with Homebrew and ensure the Xcode command-line tools are available:

```sh
xcode-select --install
brew install neovim tree-sitter
```

Then clone the configuration and start Neovim:

```sh
git clone https://github.com/samredway/samredway-nvim-config.git ~/.config/nvim
nvim
```

On first launch, Lazy.nvim bootstraps itself and installs the plugins. Nvim-treesitter then installs the configured language parsers. Run `:checkhealth nvim-treesitter` if parser installation or syntax highlighting does not work.

The committed `lazy-lock.json` pins plugin versions known to work with this configuration. Update them deliberately with `:Lazy update` and commit the resulting lockfile change.
