export OP_SESSION_octoenergy="r05QV3k7RNBk0c4QWGLW005kJdYm1bknQGtEmKKS4CU"

export OCTODIR="$HOME/Code/Octo"
export OCTODEV="$OCTODIR/octodev"
export KRAKEN="$OCTODIR/kraken-core"
export KRAKEN_VAGRANT="$OCTODIR/kraken-vagrant"

export PGHOST=localhost
export PGPORT=5432
export PGUSER=postgres
export OCTODB=octo-consumer

# aliases
alias ls="exa"
alias l="ls -lh"
alias ll="l -a"
alias lt="l --tree"
alias llt="ll --tree"

alias gs="git st"

alias tmux="tmux -f $HOME/.config/tmux/config"
alias vim=nvim
alias up="brew update"
alias v="cd $KRAKEN_VAGRANT; vagrant"
alias k="cd $KRAKEN; workon octo;" 


clean_snapshot() {
    echo "Delete local snapshots"
    tmutil listlocalsnapshotdates / | grep 20 | while read f; do tmutil deletelocalsnapshots $f; done
}

get_context() {
    pcregrep -o1 "{{(.*?)}}" $1 | sed -e 's/^[ \t]*//' | sort -u
}


branch_decommit() {
    if [[ ! ("$#" == 1) ]]; then 
        echo "Provide the base branch to compare the current branch e.g: master"
        return 1
    fi
    git reset $(git merge-base $1 $(git rev-parse --abbrev-ref HEAD))
}


git_last_sha() {
    git rev-parse --verify HEAD;
}

git_fixup() {
    last_sha=$(git_last_sha)
    command="git commit --edit --fixup $last_sha"
    echo "$command"
    sh -c "$command"
}

git_rebase_autosquash() {
    git rebase --autosquash --interactive origin/master
}
