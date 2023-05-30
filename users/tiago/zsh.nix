{ config, pkgs, ... }:

let

  inherit (import <home-manager/nixos> {}) home-manager;

in {

  home-manager.users.tscolari = {
    programs.zsh = {
      enable = true;

      defaultKeymap = "viins";

      initExtra = "
        for config_file in $(ls $HOME/.config/zsh/*.zsh)
        do
          source $config_file
        done
      ";

      prezto = {
        enable = true;

        pmodules = [
          "environment"
          "terminal"
          "editor"
          "history"
          "directory"
          "spectrum"
          "utility"
          "ssh"
          "fasd"
          "completion"
          "ruby"
          "rails"
          "git"
          "history-substring-search"
          "prompt"
          "syntax-highlighting"
        ];

        editor.keymap = "emacs";
        prompt.theme = "sorin";
        tmux.autoStartLocal = true;
      };


      shellAliases = {
        # Bundler
        be = "bundle exec";
        bes = "bundle exec spec";

        # Tmux
        tx = "tmux";
        txa = "tmux attach -t";
        txn = "tmux new -s";
        txs = "tmux switch -t";

        # Show human friendly numbers and colours
        df = "df -h";
        ll = "ls -alGh --color";
        ls = "ls -Gh --color";
        du = "du -h -d 2";

        # Rspec
        rs = "rspec spec";

        open    = "xdg-open";
        weather = "curl wttr.in";
        pbcopy  = "xclip -selection clipboard";
        pbpaste = "xclip -selection clipboard -o";

        # Override rm -i alias which makes rm prompt for every action
        rm      = "nocorrect rm";

        # Don't try to glob with zsh so you can do
        # stuff like ga *foo* and correctly have
        # git add the right stuff
        git = "noglob git";

        C = "| wc -l";
        H = "| head";
        L = "| less";
        N = "| /dev/null";
        S = "| sort";
        G = "| grep";
      };

      sessionVariables = {
        XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
      };
    };
  };

}
