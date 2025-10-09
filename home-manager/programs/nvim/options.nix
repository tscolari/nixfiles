{ config, lib, pkgs, ... }@args:

{

  programs.nixvim.opts = {
    autoread      = true;                  # reload changes from disk
    autowriteall  = true;                  # Writes on make/shell commands
    hidden        = true;                  # Allow buffer switching without saving
    linespace     = 0;                     # No extra spaces between rows
    wrap          = false;                 # Do not wrap long lines
    number        = true;                  # Show line numbers
    scrolloff     = 5;                     # Minumum lines to keep above and below cursor
    showmatch     = true;                  # Show matching brackets/parentthesis
    splitright    = true;                  # Vertical splits to the right
    termguicolors = true;                  # Enable true colors in terminal
    updatetime    = 300;                   # Update swap file and CursorHold delay
    swapfile      = false;                 # no swap file
    signcolumn    = "yes";                 # Always enable sign column to avoid spasms
    timeoutlen    = 700;                   # Timeout for keybindings
    ttimeoutlen   = 0;                     # Timeout for completing commands
    inccommand    = "nosplit";             # Preview commands like substitute
    # iskeyword:append('$', '@', '-');
    wildmode      = [ "list" "longest" ];  # Use emacs-style tab completion in command mode































  };

}
