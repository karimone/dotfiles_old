rule () {
	print -Pn '%F{blue}'
	local columns=$(tput cols)
	for ((i=1; i<=columns; i++)); do
	   printf "\u2588"
	done
	print -P '%f'
}

function _my_clear() {
	echo
	rule
	zle clear-screen
}

zle -N _my_clear
bindkey '^l' _my_clear

# Ctrl-O opens zsh at the current location, and on exit, cd into ranger's last location.
ranger-cd() {
	tempfile=$(mktemp)
	ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
	test -f "$tempfile" &&
	if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
	cd -- "$(cat "$tempfile")"
	fi
	rm -f -- "$tempfile"
	# hacky way of transferring over previous command and updating the screen
	VISUAL=true zle edit-command-line
}
zle -N ranger-cd
bindkey '^o' ranger-cd


# TODO: move the functions away
feex(){
    eval "$(ssh-agent -s)";
    ssh-add ~/.ssh/id_rsa;
    ssh-add ~/.ssh/gitlab_personal;
    cd ~/Code/Feex/feex-mobile/
}

fixup(){
    last_sha=$(git rev-parse --verify HEAD)
    echo "Applying fixup to the SHA: $last_sha"
    git commit --edit --fixup $last_sha
}

docker-stop() {
    docker stop $(docker ps -q)
}


