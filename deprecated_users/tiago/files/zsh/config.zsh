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

gpgconf --reload gpg-agent
