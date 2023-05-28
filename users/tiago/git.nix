{ config, pkgs, ... }:

let

  inherit (import <home-manager/nixos> {}) home-manager;

in {

  home-manager.users.tscolari = {
    programs.git = {
      enable = true;

      aliases = {
        # add
        a = "add";                           # add

        # branch
        b = "branch -v";                     # branch (verbose)
        br = "branch";

        # commit
        c = "commit -m";                     # commit with message
        ca = "commit --amend --verbose";     # ammend commit
        ci = "commit --verbose";             # commit
        amend = "commit --amend";            # ammend your last commit
        ammend = "commit --amend";           # ammend your last commit

        # checkout
        co = "checkout";                     # checkout
        nb = "checkout -b";                  # create and switch to a new branch (mnemonic: "git new branch branchname...")

        # cherry-pick
        cp = "cherry-pick -x";               # grab a change from a branch

        # diff
        d = "diff";                          # diff unstaged changes
        dc = "diff --cached";                # diff staged changes

        # log
        l = "log --graph --date=short";
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        flog = "log --pretty=fuller --decorate";
        blog = "log origin/master... --left-right";
        changes = "log --pretty=format:\"%h %cr %cn %Cgreen%s%Creset\" --name-status";
        short = "log --pretty=format:\"%h %cr %cn %Cgreen%s%Creset\"";
        changelog = "log --pretty=format:\" * %s\"";
        shortnocolor = "log --pretty=format:\"%h %cr %cn %s\"";

        # duet
        dci = "duet-commit --verbose";
        dca = "duet-commit --amend --reset-author --verbose";

        # pull
        pl = "pull";                         # pull

        # push
        ps = "push";                         # push

        # rebase
        rc = "rebase --continue";            # continue rebase
        rs = "rebase --skip";                # skip rebase
        rebase = "rebase -i --exec 'git duet-commit --amend --reset-author'";

        # remote
        r = "remote -v";                     # show remotes (verbose)

        # reset
        unstage = "reset HEAD";              # remove files from index (tracking)
        uncommit = "reset --soft HEAD^";     # go back before last commit, with files in uncommitted state
        filelog = "log -u";                  # show changes to a file
        mt = "mergetool";                    # fire up the merge tool

        # stash
        ss = "stash";                        # stash changes
        sl = "stash list";                   # list stashes
        sa = "stash apply";                  # apply stash (restore changes)
        sd = "stash drop";                   # drop stashes (destory changes)

        # status
        s = "status";                        # status
        st = "status";                       # status
        stat = "status";                     # status

        # tag
        t = "tag -n";                        # show tags with <n> lines of each tag message
      };

      extraConfig = {

        user = {
          name       = "Tiago Scolari";
          email      = "git@tscolari.me";
          # Add "signingkey" to ~/.gitconfig.user
        };

        author = {
          name       = "Tiago Scolari";
          email      = "git@tscolari.me";
          # Add "signingkey" to ~/.gitconfig.user
        };

        committer = {
          name       = "Tiago Scolari";
          email      = "git@tscolari.me";
          # Add "signingkey" to ~/.gitconfig.user
        };

        advice = {
          statusHints = "false";
        };

        branch = {
          autosetupmerge = "true";
        };

        color = {
          ui = "true";

          branch = {
            current = "yellow reverse";
            local = "yellow";
            remote = "green";
          };

          diff = {
            meta = "yellow bold";
            frag = "magenta bold";
            old = "red bold";
            new = "green bold";
          };
        };

        commit = {
          gpgsign = "true";
        };

        core = {
          autocrlf = "false";
          editor = "nvim";
          excludesfile = "~/.gitignore";
        };

        diff = {
          # Git diff will use (i)ndex, (w)ork tree, (c)ommit and (o)bject
          # instead of a/b/c/d as prefixes for patches
          mnemonicprefix = "true";
        };

        format = {
          pretty = "format:%C(blue)%ad%Creset %C(yellow)%h%C(green)%d%Creset %C(blue)%s %C(magenta) [%an]%Creset";
        };

        github = {
          user = "tscolari";
        };

        gpg = {
          program = "gpg";
        };

        include = {
          path = "~/.gitconfig.user";
        };

        mergetool = {
          prompt = "false";

          vimdiff = {
            cmd = "vim -c 'Gdiff' $MERGED";     # use fugitive.vim for 3-way merge
            keepbackup = "false";
          };
        };

        merge = {
          summary = "true";
          verbosity = "1";
          tool = "mvimdiff";
        };

        url = {
          "git@github.com:" = {
            pushInsteadOf = "https://github.com/";
            insteadOf = "https://github.com/";
          };
        };

        # 'git push' will push the current branch to its tracking branch
        push = {
          # the usual default is to push all branches
          default = "tracking";
        };

        rerere = {
          # Remember my merges
          # http://gitfu.wordpress.com/2008/04/20/git-rerere-rereremember-what-you-did-last-time/
          enable = "true";
        };

        status = {
          submoduleSummary = "true";
        };
      };
    };
  };
}
