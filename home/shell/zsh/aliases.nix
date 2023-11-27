{ config, pkgs, userData, ... }:

{
  programs.zsh = {
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

      vim = "nvim";

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
  };
}
