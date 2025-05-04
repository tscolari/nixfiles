{ config, pkgs, userData, ... }:

{
  programs.zsh = {
    # Moved to the start of the zshrc so that they can
    # be unaliased if necessary for macos.
    initExtraFirst = ''
      alias pbcopy="xclip -selection clipboard";
      alias pbpaste="xclip -selection clipboard -o";
      alias open="xdg-open";
    '';


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

      weather = "curl wttr.in";

      vim = "nvim";

      # Override rm -i alias which makes rm prompt for every action
      rm      = "nocorrect rm";

      # Don't try to glob with zsh so you can do
      # stuff like ga *foo* and correctly have
      # git add the right stuff
      git = "noglob git";
      gpr = "git pull --rebase";


      # Kubernetes
      k = "kubectl";
      kn = "kubens";
      kc = "kubectx";
      kg = "kubectl get";
      kd = "kubectl describe";
    };

    shellGlobalAliases = {
      C = "| wc -l";
      H = "| head";
      L = "| less";
      N = "| /dev/null";
      S = "| sort";
      G = "| grep";
    };
  };
}
