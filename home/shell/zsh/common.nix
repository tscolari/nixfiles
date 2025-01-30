{ config, pkgs, userData, ... }:

let

  homeDir = config.userData.homeDir;

in {
  home = {
    file = {
      "${homeDir}/.config/zsh/.empty".source = ../../files/empty;

    };
  };

  programs.zsh = {
    enable = true;

    defaultKeymap = "viins";

    initExtra = ''
      if [ -e ~/.secrets ]; then
        source ~/.secrets
      fi

      # Goes to the root path of the git repository
      function cdg() { cd "$(git rev-parse --show-toplevel)" }

      # Makes git auto completion faster favouring for local completions
      __git_files () {
          _wanted files expl 'local files' _files
      }

      # emacs style
      bindkey '^a' beginning-of-line
      bindkey '^e' end-of-line

      set -o vi

      eval "$(fasd --init auto)"

      for config_file in $(ls -A $HOME/.config/zsh | grep -e '.zsh$')
      do
        source "$HOME/.config/zsh/$config_file"
      done

      for p in $(echo $NIX_PROFILES | tr " " "\n"); do
        GOPATH="$GOPATH:$p/share/go"
      done

      for p in $(echo $GOPATH | tr ":" "\n"); do
        PATH="$PATH:$p/bin"
      done
    '';
  };
}
