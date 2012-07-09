#
# This is my zsh config (mooontes.com), some of custom code, 
# some of other's code
#
# Only tested in Ubuntu, use at your own risk
#

# This is to force Ubuntu's VIM to load my own config
###export VIM='~/.vim/'

# For MacPorts:
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

#Home/End keys in OSX command line
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Load colors
autoload -U colors
colors

# Color table from: http://www.understudy.net/custom.html
fg_black=%{$'\e[0;30m'%}
fg_red=%{$'\e[0;31m'%}
fg_green=%{$'\e[0;32m'%}
fg_brown=%{$'\e[0;33m'%}
fg_blue=%{$'\e[0;34m'%}
fg_purple=%{$'\e[0;35m'%}
fg_cyan=%{$'\e[0;36m'%}
fg_lgray=%{$'\e[0;37m'%}
fg_dgray=%{$'\e[1;30m'%}
fg_lred=%{$'\e[1;31m'%}
fg_lgreen=%{$'\e[1;32m'%}
fg_yellow=%{$'\e[1;33m'%}
fg_lblue=%{$'\e[1;34m'%}
fg_pink=%{$'\e[1;35m'%}
fg_lcyan=%{$'\e[1;36m'%}
fg_white=%{$'\e[1;37m'%}
# Text Background Colors
bg_red=%{$'\e[0;41m'%}
bg_green=%{$'\e[0;42m'%}
bg_brown=%{$'\e[0;43m'%}
bg_blue=%{$'\e[0;44m'%}
bg_purple=%{$'\e[0;45m'%}
bg_cyan=%{$'\e[0;46m'%}
bg_gray=%{$'\e[0;47m'%}
# Attributes
at_normal=%{$'\e[0m'%}
at_bold=%{$'\e[1m'%}
at_italics=%{$'\e[3m'%}
at_underl=%{$'\e[4m'%}
at_blink=%{$'\e[5m'%}
at_outline=%{$'\e[6m'%}
at_reverse=%{$'\e[7m'%}
at_nondisp=%{$'\e[8m'%}
at_strike=%{$'\e[9m'%}
at_boldoff=%{$'\e[22m'%}
at_italicsoff=%{$'\e[23m'%}
at_underloff=%{$'\e[24m'%}
at_blinkoff=%{$'\e[25m'%}
at_reverseoff=%{$'\e[27m'%}
at_strikeoff=%{$'\e[29m'%}

# Allow for functions in the prompt.
setopt PROMPT_SUBST

# GIT (some code from https://github.com/bryanl/zshkit/blob/master/06_git )
#if [[ -x `which git` ]]; then
    function precmd () {
        GITOUTPUT=$(git branch -v 2> /dev/null)
        if [ "$GITOUTPUT" != "" ]; then
            GITCOMMITPENDING=$(git status 2> /dev/null)
            if [[ $GITCOMMITPENDING =~ "nothing to commit" ]]; then
                GITCOMMITPENDING='%{${fg[green]}%}√%{${fg[default]}%}'
            else
                GITCOMMITPENDING='%{${fg[red]}%}≠%{${fg[default]}%}'
            fi

            GITBRANCH=' '`echo $GITOUTPUT | grep '^\*' | sed 's/^\*\ //' | sed 's/\ .*$//'`

            GITBRANCHSHA1=' '`echo $GITOUTPUT | grep '^\*' | sed 's/^\*\ [^\ ]*\ //' | grep -Poh '^[^\s]+'`

            GITLASTCOMMIT=' (Last:'`git branch -v 2> /dev/null | grep '^\*' | sed 's/^\*\ [^\ ]*\ [^\ ]*//'`')'
        else
            GITCOMMITPENDING=''
            GITBRANCH=''
            GITBRANCHSHA1=''
            GITLASTCOMMIT=''
        fi

        PROMPT="%{${fg[magenta]}%}$gitbranch%n@${at_underl}%m${at_underloff}${fg_dgray}[${fg_cyan}%~${fg_dgray}]${fg_pink}$GITBRANCHSHA1$GITLASTCOMMIT
%{${fg[blue]}%}%T${fg_dgray}$GITBRANCH$GITCOMMITPENDING:${at_normal} "
    }

#Set the auto completion on
autoload -Uz compinit
compinit

zstyle ':completion:*' special-dirs true

#Lets set some options
####setopt correctall  #Very annoying auto complete
setopt autocd
setopt auto_resume
     
## Enables the extgended globbing features
setopt extendedglob
      
#Set some ZSH styles
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
       
HISTFILE=~/.zsh-histfile
HISTSIZE=1000
SAVEHIST=1000
        
#Aliases
##ls, the common ones I use a lot shortened for rapid fire usage
alias ls='ls -G' #I like color
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
         
##cd, because typing the backslash is ALOT of work!!
alias .='cd ../'
alias ..='cd ../../'
alias ...='cd ../../../'
alias ....='cd ../../../../'

##many clear + ls, so better a cl
alias cl='clear && ls'

# SSH aliases - short cuts to ssh to a host
# alias -g shost='ssh -p 9999 user@host.com'
#  
#  # Screen aliases - add a new screen , or entire session, name it, then ssh to the host
#  alias sshost='screen -t HOST shost'
