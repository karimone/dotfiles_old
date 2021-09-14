export LEISS_PROJECT="$HOME/Code/leiss"
export LEISS_ENV="leiss"
export LEISS_ENV_PATH="$VIRTUALENVWRAPPER_HOOK_DIR/$MARIO_ENV"

leiss() {
    cd $LEISS_PROJECT;
    if [ "$LEISS_ENV_PATH" != "$VIRTUAL_ENV" ]; then;
        workon "$LEISS_ENV";
    fi
}
alias pl="leiss; python leiss.py"
alias plr="pl refresh-rank && pl show-rank --ranks 5"
alias plw="pl show-rank"
