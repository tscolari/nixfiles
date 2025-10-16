{ config, ... }:

{

  programs.nixvim.opts = {

    # General
    autoread = true; # reload changes from disk
    autowriteall = true; # Writes on make/shell commands
    hidden = true; # Allow buffer switching without saving
    linespace = 0; # No extra spaces between rows
    wrap = false; # Do not wrap long lines
    number = true; # Show line numbers
    scrolloff = 5; # Minumum lines to keep above and below cursor
    showmatch = true; # Show matching brackets/parentthesis
    splitright = true; # Vertical splits to the right
    termguicolors = true; # Enable true colors in terminal
    updatetime = 300; # Update swap file and CursorHold delay
    swapfile = false; # no swap file
    signcolumn = "yes"; # Always enable sign column to avoid spasms
    timeoutlen = 700; # Timeout for keybindings
    ttimeoutlen = 0; # Timeout for completing commands
    inccommand = "nosplit"; # Preview commands like substitute
    wildmode = [
      "list"
      "longest"
    ]; # Use emacs-style tab completion in command mode
    iskeyword = "@,48-57,_,192-255,$,@-@,-";
    # **Explanation:**
    # - `@` = alphabetic characters
    # - `48-57` = digits (ASCII codes for 0-9)
    # - `_` = underscore
    # - `192-255` = accented characters
    # - `$` = dollar sign (your addition)
    # - `@-@` = at sign (your addition)
    # - `-` = hyphen (your addition)

    ignorecase = true; # Case insensitive search
    smartcase = true; # ... but case sensitive when uc present
    sessionoptions = [
      "blank"
      "buffers"
      "curdir"
      "folds"
      "help"
      "options"
      "tabpages"
      "winsize"
      "resize"
      "winpos"
      "terminal"
    ];

    # Mouse
    mouse = "a"; # Mouse enabled in all modes

    # Completion
    pumheight = 20; # Avoid the pop up menu occupying the whole screen
    completeopt = [
      "noinsert"
      "menuone"
      "noselect"
    ];
    shortmess = "filnxtToOFc";
    # **Explanation of the default flags:**
    # - `f` = use "(3 of 5)" instead of "(file 3 of 5)"
    # - `i` = use "[noeol]" instead of "[Incomplete last line]"
    # - `l` = use "999L, 888C" instead of "999 lines, 888 characters"
    # - `n` = use "[New]" instead of "[New File]"
    # - `x` = use "[dos]" instead of "[dos format]", etc.
    # - `t` = truncate file message at start if too long
    # - `T` = truncate other messages in middle if too long
    # - `o` = overwrite message for writing a file
    # - `O` = message for reading a file overwrites previous
    # - `F` = don't give file info when editing a file
    # - `c` = don't give ins-completion-menu messages (your addition)

    # Indentation
    expandtab = true; # Tabs are spaces, not tabs
    shiftwidth = 4; # Use indents of 2 spaces
    softtabstop = 4; # Let backspace delete indent
    tabstop = 4; # An indentation every four columns

    # Undo
    undofile = true; # Persistent undo
    undodir = "${config.xdg.cacheHome}/nvim/undo"; # set an undo directory
    undolevels = 1000; # Maximum number of changes that can be undone
    undoreload = 10000; # Maximum number lines to save for undo on a buffer reload

    # Command mode
    showmode = false; # Hide current mode in command-line (shown by lightline)
    fillchars = "vert:│,stl: ,stlnc: ";

    # Encoding & file formats
    fileencoding = "utf-8";

    # Backups
    backup = false;
    writebackup = false;

    # Cursor line
    cursorline = true;

    # Folding
    foldlevel = 9999;
    foldmethod = "expr";
    foldexpr = "nvim_treesitter#foldexpr()";

    # views can only be fully collapsed with the global statusline
    laststatus = 3;
  };
}
