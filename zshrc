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

alias nogit="disable_git_prompt_info; compdef -d git"
alias nog="nogit"

PATH=~/bin/:~/node_modules/.bin/:$PATH

################################################################################
# Custom PATH configuration
################################################################################

export PATH=$PATH:~/bin:~/android-extra/scripts:~/scripts:~/tools/arm-2009q3/bin:~/src/android/prebuilt/linux-x86/toolchain/arm-eabi-4.3.1/bin:~/src/kvm-arm-encoder:/home/christoffer/tools/cil-1.3.7/bin:/home/christoffer/tools/zchaff:~/x-tools/arm-unknown-eabi/bin:/home/christoffer/TA/android-sdk-os.f2011/tools


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
export ARCH=arm
#export CROSS_COMPILE=arm-none-linux-gnueabi-
export CROSS_COMPILE=arm-unknown-eabi-
export MENUCONFIG_COLOR=blackbg

################################################################################
# Android compilation settings
################################################################################
export ANDROID_PRODUCT_OUT=~/src/android-cont/android/out/target/product/generic
export ANDROID_IMAGES=~/images/android-cont
export JAVA_HOME=~/install/jdk1.6.0_23
export ANROID_JAVA_HOME=$JAVA_HOME


################################################################################
# ARM FAST Model Settings
################################################################################
#export MAXCORE_HOME=~/ARM/FastModelTools_5.2
#export PATH=$PATH:~/ARM/FastModelTools_6.0/bin:~/ARM/FLEXlm
#. ~/ARM/FastModelTools_6.0/source_all.sh
#export ARMLMD_LICENSE_FILE=~/ARM/Cortex_A15_Trial/sw/A15_Trial/license.dat
#. /home/christoffer/ARM/FastModelTools_6.0/ModelDebugger_5.2/etc/setup.sh
#. /home/christoffer/ARM/FastModelPortfolio_5.2/etc/setup.sh
