# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/vpikkal/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

fpath=(/usr/local/share/zsh-completions $fpath)

alias zshconfig="atom ~/.zshrc"
alias zshreload="source ~/.zshrc"

alias home="cd ~"
alias dc="~/Documents"
alias ds="~/Desktop"
alias ows="~/Desktop/Workspace/office"
alias pws="~/Desktop/Workspace/personal"
alias gs="git status"
alias gc="git checkout"
alias ga="git add ."
alias gpl="git pull origin"
alias gps="git push origin"
alias gemail="git config user.email"
alias gname="git config user.name"
alias ni="npm install"
alias nig="npm install -g"
alias nis="npm install --save"
alias nisd="npm install --save-dev"
alias nu="npm uninstall"
alias nug="npm uninstall -g"
alias nus="npm uninstall --save"
alias nusd="npm uninstall --save-dev"
alias gnb="git checkout -b"
alias gcm="git commit -m"

function newdir () {
	mkdir $1 && cd $1
}

# git add && git commit -m "Message" && git push origin
# assuming upstream is set
function gacp() {
	ga
	if [ -z "$2" ]; then
		gcm "$1"
	else
		echo "Commiting with message and description"
		gcm "$1" -m "$2"
	fi
	gps
}

# create git repo from terminal
function startgit() {
	repo=$1
	if [ -z "$1" ]; then
		repo=${PWD##*/}
		echo "Repo name ${repo}"
	fi
	curl -u 'Venugopal46' https://api.github.com/user/repos -d '{"name": "'${repo}'"}'
	echo '# '${repo}'' >> README.md
	git init
	gemail venu.siddu46@gmail.com
	ga
	gcm "First Commit"
	git remote add origin git@personalGit:Venugopal46/${repo}.git
	git push --set-upstream origin master
}

# Compatible in all bash versions
# Automatically switches between work and personal git profiles
# You have to setup your SSH keys for each profile
# Compatible in all bash versions
# Developed using http://mherman.org/blog/2013/09/16/managing-multiple-github-accounts/
function gcn() {
	hosts=( "github.com:personalGit"
        "gecgithub01.walmart.com:walmartGit"
        "vcm.wal-mart.com:walmartBit" )
	ssh_url=$1
	for host in "${hosts[@]}" ; do
		KEY=${host%%:*}
 		VALUE=${host#*:}
 		if (test "${ssh_url#*$KEY}" != "$ssh_url")
 		then
 			echo "Cloning with $VALUE profile..."
 			git clone "${ssh_url/$KEY/$VALUE}"
 			cd ${${ssh_url#*/*}%%.git*}
      if [ $VALUE = "personalGit" ]
      then
        echo "Setting gemail"
        git config user.email "venu.siddu46@gmail.com"
      fi
 			break
		fi
	done
}
