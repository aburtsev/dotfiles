### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
# the next line break fzf
# set -e fish_user_paths 
set -U fish_user_paths $HOME/.deno/bin $HOME/.nvm/versions/node/v16.13.1/bin /opt/bin $fish_user_paths
# set -U fish_user_paths $fish_user_paths $HOME/.local/bin/
set fish_greeting                      # Supresses fish's intro message
set TERM "xterm-256color"              # Sets the terminal type
set EDITOR "emacsclient -t -a ''"      # $EDITOR use Emacs in terminal
set VISUAL "emacsclient -c -a emacs"   # $VISUAL use Emacs in GUI mode

### DEFAULT EMACS MODE OR VI MODE ###
# function fish_user_key_bindings
#   fish_default_key_bindings
#   # fish_vi_key_bindings
# end
### END OF VI MODE ###

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan


### FUNCTIONS ###
function commits
    git log --author="$argv" --format=format:%ad --date=short | uniq -c | awk '{print $1}' | spark | lolcat
end

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
# The bindings for !! and !$
if [ $fish_key_bindings = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end


# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename_bak
end
### ALIASES ###

# vim and emacs
alias vim='nvim'
# alias em='/usr/bin/emacs -nw'
# alias emacs="emacsclient -c -a 'emacs'"
alias doomsync="~/.doom-emacs.d/bin/doom sync"
alias doomdoctor="~/.doom-emacs.d/bin/doom doctor"
alias doomupgrade="~/.doom-emacs.d/bin/doom upgrade"
# alias doompurge="~/.emacs.d/bin/doom purge"

# broot
# alias br='broot -dhp'
# alias bs='broot --sizes'

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
# alias vifm='./.config/vifm/scripts/vifmrun'

# alias merge='xrdb -merge ~/.Xresources'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# switch between shells
# alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
# alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
# alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

# bare git repo alias for dotfiles
alias dtfls="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias pdtfls="/usr/bin/git --git-dir=$HOME/.private_dotfiles/ --work-tree=$HOME"

alias fd=fdfind

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

### SETTING THE STARSHIP PROMPT ###
starship init fish | source
