# Add aliases commands here

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -h --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# Enable alias on sudo
alias sudo='sudo '

# For apt
alias apt-get='apt-get -y'
alias apti='sudo apt-get install'
alias aptb='sudo apt-get build-dep'
alias aptd='sudo apt-get update'
alias aptg='sudo apt-get upgrade'
alias aptdg='sudo apt-get dist-upgrade'
alias aptad='sudo apt-add-repository'
alias aptr='sudo apt-get remove'
alias aptra='sudo apt-get autoremove'
alias aptl='apt list --installed'
function apt_cache_search() { apt-cache search $@ | grep -i $@ ; }
alias apts=apt_cache_search
function apt_install_with_dep() { sudo aptb $@ ; sudo apti $@ ; }
alias apta=apt_install_with_dep


# For ls, rm, cp, which, etc.
# The 'ls' family
alias lx='ls -lXB'			#  Sort by extension.
alias lk='ls -lSr'			#  Sort by size, biggest last.
alias lt='ls -ltr'			#  Sort by date, most recent last.
alias lc='ls -ltcr'			#  Sort by/show change time, most recent last.
alias lu='ls -ltur'			#  Sort by/show access time, most recent last.

# some more ls aliases
alias ll='ls -lv --group-directories-first'
alias lm='ll |more'
alias lr='ll -R'
alias la='ll -A'
alias l='ls -CF'
alias tree='tree -Csuh'

# extend common operators
alias rm='rm -if'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias ln='ln -snvf'

alias h='history'
alias j='jobs -l'
function get_which_one() { type -a $1 | grep "$(which $1)" ; type -a $1 | grep -v "$(which $1)" ; }
alias where=get_which_one
alias ..='cd ..'
alias ~='cd ~'

alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'		#  Dynamic library path
alias slibpath='echo -e ${LIBRARY_PATH//:/\\n}'			#  Static library path
alias incpath='echo -e ${CPATH//:/\\n}'				#  Include path (for C/C++ headers)

alias du='du -kh'
alias df='df -kTh'

# Quickly get work
alias acv3='source ${HOME}/pyenv/py3-dev/bin/activate && cd ${HOME}/pyenv/py3-dev'
function quick_acc()
{
    acv3
    case $1 in
        "cpu")
            cd intel-cpu-extension
            ;;
        "gpu")
            cd intel-gpu-extension
            ;;
        "pyt")
            cd pytorch
            ;;
        "por")
            cd por-models
            ;;
        *)
            cd $1
            ;;
    esac
}
alias ac=quick_acc

alias pyin='python setup.py install'
alias pycl='python setup.py clean'
