if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

if test -f ~/.config/git/git-prompt.sh
then
	. ~/.config/git/git-prompt.sh
else
	PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
	PS1="$PS1"'\n'                 # new line
	PS1="$PS1"'\[\033[32m\]'     # change to green
    #PS2="\@\[$(tput sgr0)\] \n" #PS2="\t [\u@\h \W]\\$ \[$(tput sgr0)\]"
    PS3='\[\033[32m\]'"\d\w\[$(tput sgr0)\] \@\[$(tput sgr0)\]\n"
    #PS1="$PS1"'\[\033[32m\]' #''                   # PS1="$PS1"'\u@\h '             # user@host<space>
    #PS1="$PS1"'\[\033[0m\]'       # change to purple
    #PS1="$PS2"'$MSYSTEM '          # show MSYSTEM
	PS1="$PS1"'\[\033[33m\]\'       # change to brownish yellow
	PS1="$PS1"'\w'                  # current working directory
	if test -z "$WINELOADERNOEXEC"
	then
		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
		if test -f "$COMPLETION_PATH/git-prompt.sh"
		then
			. "$COMPLETION_PATH/git-completion.bash"
			. "$COMPLETION_PATH/git-prompt.sh"
			PS1='\[\033[33m\]'  # change color to cyan "$PS1"
			PS1="$PS1"'`__git_ps1`'   # bash function
		fi
	fi
	PS1="$PS1" ##   '\[\033[35m\]' #'\[\033[0m\]'        # change color
	##PS1="$PS1"'\n'                 # new line
	PS1="$PS3" #'karan:'            # prompt: always $  "$PS2"
fi

MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc
