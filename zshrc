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
unsetopt PUSHD_IGNORE_DUPS

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

alias nogit="disable_git_prompt_info"
compdef -d git
nogit

alias tmux="tmux -2"

PATH=~/bin/:~/node_modules/.bin/:$PATH
export PATH=$PATH:/opt/local/bin:/usr/texbin
export PATH=$PATH:~/bin:~/scripts
export PATH=$PATH:~/tools/arm-eabi-4.4.3/bin/

export LIBVIRT_DEFAULT_URI=qemu:///system

#
################################################################################
# Git settings
################################################################################
export GIT_EDITOR=/usr/bin/vim
export GIT_AUTHOR_NAME="Christoffer Dall"
export GIT_AUTHOR_EMAIL="cdall@cs.columbia.edu"
export GIT_COMMITTER_NAME="Christoffer Dall"
export GIT_COMMITTER_EMAIL="cdall@cs.columbia.edu"

################################################################################
# Linux compilation settings 
################################################################################
export MENUCONFIG_COLOR=blackbg
export CCACHE_BASEDIR=/home/christoffer

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

################################################################################
# KVM Specific Settings
################################################################################

function kvmarm_env() {
	export CROSS_COMPILE=arm-linux-gnueabi-
	export ARCH=arm

	export GIT_AUTHOR_NAME="Christoffer Dall"
	export GIT_AUTHOR_EMAIL="c.dall@virtualopensystems.com"
	export GIT_COMMITTER_NAME="Christoffer Dall"
	export GIT_COMMITTER_EMAIL="c.dall@virtualopensystems.com"
}

################################################################################
# Poser specific settings
################################################################################
mountSource() { hdiutil attach -quiet -mountpoint ~/src ~/SourceCode.sparsebundle; }

export PATH=$PATH:~/bin
export COLUMBIA_POSER_ROOT=/Users/christoffer/src/poser
function poser-droid() {
	export ANDROID_ROOT=$COLUMBIA_POSER_ROOT
	export ANDROID_IMGS=$COLUMBIA_POSER_ROOT/imgs
	export ANDROID_KERNEL_DIR=$COLUMBIA_POSER_ROOT/kernel
	export NO_AFLASH_REBOOT_CONF=1
	pushd $ANDROID_ROOT
	source ./source-me.sh full_crespo-eng
	popd
}


################################################################################
# Cells specific settings
################################################################################

function cells-host-droid() {
	export COLUMBIA_CELLS_ROOT=/Users/christoffer/src/cells-host
	export ANDROID_ROOT=$COLUMBIA_CELLS_ROOT
	export ANDROID_IMGS=$COLUMBIA_CELLS_ROOT/imgs
	export ANDROID_KERNEL_DIR=$COLUMBIA_CELLS_ROOT/kernel
	export NO_AFLASH_REBOOT_CONF=1
	pushd $ANDROID_ROOT
	source ./source-me.sh cells_maguro-eng
	popd
}

function cells-guest-droid() {
	export COLUMBIA_CELLS_ROOT=/Users/christoffer/src/cells-guest
	export ANDROID_ROOT=$COLUMBIA_CELLS_ROOT
	export ANDROID_IMGS=$COLUMBIA_CELLS_ROOT/imgs
	export ANDROID_KERNEL_DIR=$COLUMBIA_CELLS_ROOT/kernel
	export NO_AFLASH_REBOOT_CONF=1
	pushd $ANDROID_ROOT
	source ./source-me.sh cells_maguro-eng
	popd
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
