#!/bin/sh

BW_SESSION_FILE="$HOME/.bw-session"
BW_BIN="/usr/bin/bw"
VAULT_UNLOCKED="Vault is unlocked!"
LOGGED_IN="You are logged in!"


if [[ ! -f "$BW_BIN" ]];
then
    echo "Install bw-cli"
    yay -S bitwarden-cli
fi

generate_session_file() {
    echo "Generate BW_SESSION"
    KEY="$(bw unlock --raw)"
    echo "$KEY" > "$BW_SESSION_FILE"
}

generate_session_file_from_login() {
    echo "Generate BW_SESSION after login"
    KEY="$(bw login --raw)"
    echo "$KEY" > "$BW_SESSION_FILE"
}


LOGGED_STATUS=$(bw login --check)

if [ "$LOGGED_STATUS" != "$LOGGED_IN" ]; then
    # is not logged in
    generate_session_file_from_login;
    export BW_SESSION="$(cat $BW_SESSION_FILE)"
fi

if [[ ! -f "$BW_SESSION_FILE" ]]
then
    generate_session_file;
    export BW_SESSION="$(cat $BW_SESSION_FILE)"
else
    # session exists as a file
    export BW_SESSION="$(cat $BW_SESSION_FILE)"
    VAULT_STATUS=$(bw unlock --check)
    if [ "$VAULT_STATUS" != "$VAULT_UNLOCKED" ]; then
        # session file is outdated
        generate_session_file;
        export BW_SESSION="$(cat $BW_SESSION_FILE)"
    fi
fi


