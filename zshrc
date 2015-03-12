# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="gentoo"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github git-flow cap gem lol zsh-syntax-highlighting)

source /etc/profile
source $ZSH/oh-my-zsh.sh

unsetopt nomatch
unsetopt pushd_ignore_dups

# Customize to your needs...
LS_COLORS='no=00;32:fi=00:di=00;34:ln=01;36:pi=04;33:so=01;35:bd=33;04:cd=33;04:or=31;01:ex=00;32:*.rtf=00;33:*.txt=00;33:*.html=00;33:*.doc=00;33:*.pdf=00;33:*.ps=00;33:*.sit=00;31:*.hqx=00;31:*.bin=00;31:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.deb=00;31:*.dmg=00;36:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.mpg=00;37:*.avi=00;37:*.gl=00;37:*.dl=00;37:*.mov=00;37:*.mp3=00;35:'
export LS_COLORS;
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
ZSH_HIGHLIGHT_STYLES+=(
  default                       'none'
  unknown-token                 'fg=red,bold'
  reserved-word                 'fg=yellow'
  alias                         'fg=none,bold'
  builtin                       'fg=none,bold'
  function                      'fg=none,bold'
  command                       'fg=none,bold'
  hashed-command                'fg=none,bold'
  path                          'fg=cyan'
  globbing                      'fg=cyan'
  history-expansion             'fg=blue'
  single-hyphen-option          'fg=magenta'
  double-hyphen-option          'fg=magenta'
  back-quoted-argument          'fg=magenta,bold'
  single-quoted-argument        'fg=green'
  double-quoted-argument        'fg=green'
  dollar-double-quoted-argument 'fg=cyan'
  back-double-quoted-argument   'fg=cyan'
  assign                        'none'
)

#bindkey "\e[H" beginning-of-line
#bindkey "\e[F" end-of-line
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word

alias noh="unsetopt sharehistory"

unsetopt auto_name_dirs # rvm_rvmrc_cwd fix
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
unset RUBYOPT
cd . # to rvm reload

if [[ -x `which hitch` ]]; then
	hitch() {
		command hitch "$@"
		if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
	}
	alias unhitch='hitch -u'
	hitch
fi

function git_prompt_info() {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

alias nogit="disable_git_prompt_info"
compdef -d git

alias tmux="tmux -2"

PATH=~/bin/:~/node_modules/.bin/:$PATH
export PATH=$PATH:/opt/local/bin:/usr/texbin
export PATH=$PATH:~/bin:~/scripts
export PATH=$PATH:/home/christoffer/tools/ndk

export LIBVIRT_DEFAULT_URI=qemu:///system

################################################################################
# pbcopy wrapper
################################################################################
function clipboard
{
	cat | nc -q1 localhost 2224
}

################################################################################
# transfer.sh wrapper
################################################################################

transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
	tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }; alias transfer=transfer

################################################################################
# Git settings
################################################################################
export GIT_EDITOR=/usr/bin/vim
export GIT_AUTHOR_NAME="Christoffer Dall"
export GIT_AUTHOR_EMAIL="christoffer.dall@linaro.org"
export GIT_COMMITTER_NAME="Christoffer Dall"
export GIT_COMMITTER_EMAIL="christoffer.dall@linaro.org"

################################################################################
# Linux compilation settings 
################################################################################
export MENUCONFIG_COLOR=blackbg
export USE_CCACHE=1
export CCACHE_DIR=/home/christoffer/.ccache
export CCACHE_BASEDIR=/home/christoffer

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

function mountSource()
{
	hdiutil attach -quiet -mountpoint ~/src ~/SourceCode.sparsebundle;
}

################################################################################
# KVM/ARM environment
################################################################################

function kvmarm_env() {
	export CROSS_COMPILE=arm-linux-gnueabihf-
	export ARCH=arm

	export GIT_AUTHOR_NAME="Christoffer Dall"
	export GIT_AUTHOR_EMAIL="christoffer.dall@linaro.org"
	export GIT_COMMITTER_NAME="Christoffer Dall"
	export GIT_COMMITTER_EMAIL="christoffer.dall@linaro.org"
}

function kvm_aarch64_env() {
	kvmarm_env

	export PATH=$PATH:~/tools/aarch64-toolchain/bin
	export CROSS_COMPILE=aarch64-linux-gnu-
	export ARCH=arm64

	export FDT_SRC="vexpress-foundation-v8.dts"
	export IMAGE="linux-system-foundation.axf"
}


################################################################################
# Directory-based environment config settings
################################################################################

function source_dir() {
	envdir=$1
	re_env_ignore="^\."
	if [ -d "$envdir" ]; then
		_T=$(ls "$envdir")
		if [ ! -z "$_T" ]; then
			for d in $(ls -1 "$envdir"); do
				if [[ "$d" =~ $re_env_ignore ]]; then
					echo "ignoring env setup file '$d'" > /dev/null
				else
					source "$envdir/$d"
				fi
			done
		fi
	fi
}
source_dir "$ZSH/env.d"
