# Makes git auto completion faster favouring for local completions
__git_files () {
    _wanted files expl 'local files' _files
}

# Environment Variables
export GIT_DUET_GLOBAL=true
export GIT_DUET_ROTATE_AUTHOR=1
export GPG_TTY=$(tty)

# Git aliases
alias duet='git duet --global'
alias gap="git add -p"
alias gp="git push"
alias gst='git status'
alias gsu="git submodule update --init --recursive"
alias gup="git pull --rebase"
alias gpr="git pull --rebase"
alias solo='git solo --global'
alias gti='git'
alias g='git'
