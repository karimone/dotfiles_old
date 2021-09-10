#!/bin/sh

BW_SESSION_FILE="$HOME/.bw-session"
BW_BIN="/usr/bin/bw"
VAULT_UNLOCKED="Vault is unlocked!"


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


