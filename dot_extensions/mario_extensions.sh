export MARIO_PROJECT="$HOME/Code/Feex/mario-project"
export MARIO_ANSIBLE="/Users/karim/Code/Feex/ansible-django-stack"
export MARIO_ENV="feex"
export MARIO_DB="mario"
export MARIO_ENV_PATH="$VIRTUALENVWRAPPER_HOOK_DIR/$MARIO_ENV"

# Mario stuff

mario() {
    cd $MARIO_PROJECT;
    if [ "$MARIO_ENV_PATH" != "$VIRTUAL_ENV" ]; then;
        workon "$MARIO_ENV";
    fi
}

alias m="mario"
alias me="vim ~/.mario_extensions.sh"
alias re="source ~/.mario_extensions.sh"
alias mario-command="mario; DJANGO_CONFIGURATION=Local src/manage.py"
alias mc="mario-command"
alias mario-shell="mario-command shell_plus"
alias mario-server="mario-command runserver 0.0.0.0:8003"
alias mario-tailwind="mario-command tailwind start"
alias mario-migrate="mario-command migrate"
alias mario-makemigrations="mario-command makemigrations"
alias mario-instance="ssh ubuntu@app.feex.com.au"
alias mario-clean="inv clean"
alias mario-tests="inv run-tests"

mario-recreate-db() {
    dropdb "$MARIO_DB" && createdb "$MARIO_DB"
}

mario-recreate-migrations(){
    mario; 
    rm src/**/migrations/0*.py
    mario-makemigrations
    mario-migrate
}


mario-recreate() {
    mario-recreate-db;
    mario-recreate-migrations;
    mario-command seed_db --not-dry-run
}


mario-install() { 
    cd $MARIO_PROJECT;
    pip install $1 && pip freeze | grep $1 >> requirements.txt
    cd -
}

mario-deploy(){
    cd "$MARIO_ANSIBLE" 
    echo "Deploying Mario ..."
    ansible-playbook --ssh-extra-args=-A -i development site.yml --tags=deploy
    cd -
}

