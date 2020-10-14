# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# If not running interactively 
case $- in
    *i*)
       # disable flow control to liberate key combinations such as <C-s> <C-q>
       stty -ixon
       ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# load user defined aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# load fzf key combinations
if [ -f ~/.vim/plugged/fzf/shell/completion.bash ]; then
    . ~/.vim/plugged/fzf/shell/completion.bash
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# load fzf completion
if [ -f ~/.vim/plugged/fzf/shell/key-bindings.bash ]; then
    . ~/.vim/plugged/fzf/shell/key-bindings.bash
fi
_fzf_setup_completion dir tree
_fzf_setup_completion path ls cd ag

# Handy Extract Program
function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)	tar xvjf $1	;;
            *.tar.gz)	tar xvzf $1	;;
            *.bz2)	bunzip2 $1	;;
            *.rar)	unrar x $1	;;
            *.gz)	gunzip $1	;;
            *.tar)	tar xvf $1	;;
            *.tbz2)	tar xvjf $1	;;
            *.tgz)	tar xvzf $1	;;
            *.zip)	unzip $1	;;
            *.Z)	uncompress $1	;;
            *.7z)	7z x $1		;;
            *)		echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz" "${1%%/}/"; }

# Creates a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Check proxy environment variables.
function checkproxy() { env | grep -i '_proxy' ; }

# Set proxy environment variables.
function setproxy() {
  # export http_proxy="http://proxy-prc.intel.com:911"
  # export https_proxy="http://proxy-prc.intel.com:912"
  # export ftp_proxy="http://proxy-prc.intel.com:911"
  # export socks_proxy="socks5://proxy-prc.intel.com:1080"

  export http_proxy="http://xunsongh:Jmx07026319*3@child-prc.intel.com:914"
  export https_proxy="http://xunsongh:Jmx07026319*3@child-prc.intel.com:914"
  export ftp_proxy="http://xunsongh:Jmx07026319*3@child-prc.intel.com:914"
  export socks_proxy="socks5://xunsongh:Jmx07026319*3@child-prc.intel.com:1084"
}

########################################################
# Set environment variables
########################################################

# user's root directories
USER_INSTALL_ROOT=${HOME}/.local
USER_CONFIG_ROOT=${HOME}/.config
INTELONEAPIROOT=/opt/intel/oneapi

# load inteloneapi env
# if [ -f "${USER_INSTALL_ROOT}/linux_prod/compiler/env/vars.sh" ] ; then
#   . ${USER_INSTALL_ROOT}/linux_prod/compiler/env/vars.sh
# fi
# if [ -f "${USER_INSTALL_ROOT}/linux_prod/dpcpp-ct/env/vars.sh" ] ; then
#   . ${USER_INSTALL_ROOT}/linux_prod/dpcpp-ct/env/vars.sh
# fi

# load inteloneapi env
if [ -f "${INTELONEAPIROOT}/compiler/2021.1-beta09/env/vars.sh" ] ; then
  . ${INTELONEAPIROOT}/compiler/2021.1-beta09/env/vars.sh
fi
# if [ -f "${INTELONEAPIROOT}/mkl/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/mkl/2021.1-beta09/env/vars.sh
# fi
# if [ -f "${INTELONEAPIROOT}/tbb/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/tbb/2021.1-beta09/env/vars.sh
# fi
# if [ -f "${INTELONEAPIROOT}/vtune/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/vtune/2021.1-beta09/env/vars.sh
# fi
# if [ -f "${INTELONEAPIROOT}/debugger/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/debugger/2021.1-beta09/env/vars.sh
# fi
# if [ -f "${INTELONEAPIROOT}/daal/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/daal/2021.1-beta09/env/vars.sh
# fi
# if [ -f "${INTELONEAPIROOT}/vpl/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/vpl/2021.1-beta09/env/vars.sh
# fi
# if [ -f "${INTELONEAPIROOT}/ipp/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/ipp/2021.1-beta09/env/vars.sh
# fi
# if [ -f "${INTELONEAPIROOT}/dpcpp-ct/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/dpcpp-ct/2021.1-beta09/env/vars.sh
# fi
# if [ -f "${INTELONEAPIROOT}/advisor/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/advisor/2021.1-beta09/env/vars.sh
# fi
# if [ -f "${INTELONEAPIROOT}/ippcp/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/ippcp/2021.1-beta09/env/vars.sh
# fi
# if [ -f "${INTELONEAPIROOT}/dev-utilities/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/dev-utilities/2021.1-beta09/env/vars.sh
# fi
# if [ -f "${INTELONEAPIROOT}/dnnl/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/dnnl/2021.1-beta09/env/vars.sh
# fi
# if [ -f "${INTELONEAPIROOT}/mpi/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/mpi/2021.1-beta09/env/vars.sh
# fi
# if [ -f "${INTELONEAPIROOT}/ccl/2021.1-beta09/env/vars.sh" ] ; then
#   . ${INTELONEAPIROOT}/ccl/2021.1-beta09/env/vars.sh
# fi

# gcc list
GCC_DEFAULT=/usr/bin/gcc
GCC_7=/usr/bin/gcc-7
GCC_8=/usr/bin/gcc-8
GCC_9=/usr/bin/gcc-9
GCC_C89=/usr/bin/c89-gcc
GCC_C99=/usr/bin/c99-gcc

# gcc-ar list
GCC_AR_DEFAULT=/usr/bin/gcc-ar
GCC_AR_7=/usr/bin/gcc-ar-7
GCC_AR_8=/usr/bin/gcc-ar-8
GCC_AR_9=/usr/bin/gcc-ar-9

# g++ list
GXX_DEFAULT=/usr/bin/g++
GXX_7=/usr/bin/g++-7
GXX_8=/usr/bin/g++-8
GXX_9=/usr/bin/g++-9

# cpp list
CPP_DEFAULT=/usr/bin/cpp
CPP_7=/usr/bin/cpp-7
CPP_8=/usr/bin/cpp-8
CPP_9=/usr/bin/cpp-9

# gfortran list
GFORTRAN_DEFAULT=/usr/bin/gfortran
GFORTRAN_7=/usr/bin/gfortran-7
GFORTRAN_8=
GFORTRAN_9=/usr/bin/gfortran-9

# gnat list
GNAT_DEFUAULT=/usr/bin/gnat
GNAT_8=/usr/bin/gnat-8
GNATBIND_DEFAULT=/usr/bin/gnatbind
GNATBIND_8=/usr/bin/gnatbind-8
GNATCHOP_DEFAULT=/usr/bin/gnatchop
GNATCHOP_8=/usr/bin/gnatchop-8
GNATCLEAN_DEFAULT=/usr/bin/gnatclean
GNATCLEAN_8=/usr/bin/gnatclean_8
GNATFIND_DEFAULT=/usr/bin/gnatfind
GNATFIND_8=/usr/bin/gnatfind
GNATGCC_DEFAULT=/usr/bin/gnatgcc
GNATHTML_DEFAULT=/usr/bin/gnathtml
GNATHTML_8=/usr/bin/gnathtml-8
GNATKR_DEFAULT=/usr/bin/gnatkr
GNATKR_8=/usr/bin/gnatkr-8
GNATLINK_DEFAULT=/usr/bin/gnatlink
GNATLINK_8=/usr/bin/gnatlink-8
GNATLS_DEFAULT=/usr/gnatls
GNATLS_8=/usr/bin/gnatls-8
GNATMAEK_DEFAULT=/usr/bin/gnatmake
GNATMAKE_8=/usr/bin/gnatmake-8
GNATNAME_DEFAULT=/usr/bin/gnatname
GNATNAME_8=/usr/bin/gnatname-8
GNATPREP_DEFAULT=/usr/bin/gnatprep
GNATPREP_8=/usr/bin/gnatprep-8
GNATXREF_DEFAULT=/usr/bin/gnatxref
GNATXREF_8=/usr/bin/gnatxref-8

# ld list
LD_DEFAULT=/usr/bin/ld
LD_BFD=/usr/bin/ld.bfd
LD_GOLD=/usr/bin/gold

# python list
PYTHON_DEFAULT=/usr/bin/python
PYTHON2_DEFAULT=/usr/bin/python2
PYTHON2_7=/usr/bin/python2.7
PYTHON2_7_CONFIG=/usr/bin/python2.7-config
PYTHON3_DEFAULT=/usr/bin/python3
PYTHON3_8=/usr/bin/python3.8
PYTHON3_8_CONFIG=/usr/bin/python3.8-config

# clang list
CLANG_DEFAULT=/usr/bin/clang-10
CLANG_10=/usr/bin/clang-10
CLANGXX_DEFAULT=/usr/bin/clang++-10
CLANGXX_10=/usr/bin/clang++-10
CLANG_CPP_DEFAULT=/usr/bin/clang-cpp-10
CLANG_CPP_10=/usr/bin/clang-cpp-10

# DPCPP_ROOT=${USER_INSTALL_ROOT}/linux_prod/compiler/linux
DPCPP_ROOT=/opt/intel/oneapi/compiler/2021.1-beta09/linux
# MKL_DPCPP_ROOT=
# INTELONEAPIROOT=
INTELOCLSDKROOT=${DPCPP_ROOT}

# set compilers manually
# CC=${GCC_DEFAULT}
CC=${DPCPP_ROOT}/bin/clang
# CXX=${GXX_DEFAULT}
# CXX=${DPCPP_ROOT}/bin/clang++
CXX=${DPCPP_ROOT}/bin/dpcpp
PYTHONEXECUTABLE=${PYTHON3_DEFAULT}
# function select_compiler()
# {
# #TODO:
# }

# build env ops for PyTorch
export USE_CUDNN=0 USE_FBGEMM=0 USE_NNPACK=0 BUILD_CAFFE2_OPS=0

PATH=${DPCPP_ROOT}/bin:${USER_INSTALL_ROOT}/bin:${PATH}
LD_LIBRARY_PATH=${DPCPP_ROOT}/lib:${DPCPP_ROOT}/compiler/lib/intel64_lin:${USER_INSTALL_ROOT}/lib:${USER_INSTALL_ROOT}/lib64:${LD_LIBRARY_PATH}
LIBRARY_PATH=${LD_LIBRARY_PATH}:${LIBRARY_PATH}
CPATH=${DPCPP_ROOT}/include:${USER_INSTALL_ROOT}/include:${CPATH}
# PYTHONPATH=${PYTHONPATH}

# Remove duplicated items in path
function cleanpath()
{
    echo $(echo $1 | sed 's/:/\n/g' | sort | uniq | tr -s '\n' ':' | sed -e 's/:$//g' -e 's/^://g')
}
PATH=`cleanpath ${PATH}`
LD_LIBRARY_PATH=`cleanpath ${LD_LIBRARY_PATH}`
LIBRARY_PATH=`cleanpath ${LIBRARY_PATH}`
# CPATH=`cleanpath ${CPATH}`
# PYTHONPATH=`cleanpath ${PYTHONPATH}`

# Export environment variables
export CC CXX PYTHON_EXEC
export DPCPP_ROOT INTELOCLSDKROOT
export PATH LD_LIBRARY LIBRARY CPATH #PYTHONPATH
# export MKL_DPCPP_ROOT INTELONEAPIROOT INTELOCLSDKROOT

# For test
# echo "PATH=${PATH}"
# echo "LD_LIBRARY_PATH=${LD_LIBRARY_PATH}"
# echo "LIBRARY_PATH=${LIBRARY_PATH}"
# echo "C_INCLUDE_PATH=${C_INCLUDE_PATH}"
# echo "CPLUS_INCLUDE_PATH=${CPLUS_INCLUDE_PATH}"
# echo "CPATH=${CPATH}"
# echo "PYTHONPATH=${PYTHONPATH}"

