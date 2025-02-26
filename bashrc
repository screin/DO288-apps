# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# BEGIN ANSIBLE MANAGED BLOCK

# ===============================
# General environment variables
# ===============================

# Set editor for oc commands
export EDITOR=/usr/bin/vim

# Set bash history size
export HISTSIZE=10000

# Set bash history timestamps
export HISTTIMEFORMAT="%F %T "

# Set pager not to clear on exit
export LESS='-X'

# Append to .bash_history
PROMPT_COMMAND="$PROMPT_COMMAND; history -a; history -n"

# =========================================
# OpenShift Training environment variables
# =========================================

# Source variables on new shell
if [ -e /usr/local/etc/ocp4.config ]
  then 
    source /usr/local/etc/ocp4.config
    # Set simpler variables for OCP classes
    M=$RHT_OCP4_MASTER_API
    WC=$RHT_OCP4_WILDCARD_DOMAIN
    NS=$RHT_OCP4_NEXUS_SERVER
    U=$RHT_OCP4_DEV_USER
    P=$RHT_OCP4_DEV_PASSWORD
    G=$RHT_OCP4_GITHUB_USER
    Q=$RHT_OCP4_QUAY_USER
fi

# Set login aliases for OCP classes
alias lcl="oc login -u admin -p redhat https://api.ocp4.example.com:6443"
alias mcl="oc login -u admin -p redhat https://api.ocp4-mng.example.com:6443"
alias dl="oc login -u developer -p developer https://api.ocp4.example.com:6443"

# ===============================
# Git bash environment variables
# ===============================

source /usr/share/git-core/contrib/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export PS1='[\u@\h \W$(declare -F __git_ps1 &>/dev/null && __git_ps1 " (%s)")]\$ '

# ===============================
# Ansible aliases (ansible-core)
# ===============================

alias ap="ansible-playbook"
alias apsc="ansible-playbook --syntax-check"
alias acd="ansible-config dump"
alias av="ansible --version"
alias aig="ansible-inventory --graph"

# =====================================
# Ansible aliases (ansible-navigator)
# =====================================

alias anr="ansible-navigator run -m stdout"
alias ansc="ansible-navigator run -m stdout --syntax-check"
alias ancd="ansible-navigator config dump -m stdout"
alias anv="ansible-navigator --version"
alias anig="ansible-navigator inventory --graph"

# ============
# Git aliases
# ============

alias gc="git commit -m"

# ================
# General aliases
# ================

# strip comments inside file (assume # is comment character)
alias decomment='egrep -v "^[[:space:]]*((#|;|//).*)?$" '

# stop using scp 
alias scp="echo -e \nStop using scp\n\nSee https://www.redhat.com/en/blog/openssh-scp-deprecation-rhel-9-what-you-need-know"

# python virtual environments

# Create virtual environment
alias ve='python3 -m venv ./venv'

# Activate virtual environment
alias va='source ./venv/bin/activate'

# pastebin
alias pastebin="curl -F 'sprunge=<-' http://sprunge.us"

# ==========
# functions
# ==========

# make and change to directory
mcd (){
  mkdir -pv "$1"
  cd "$1" || return
}

# Show which block devices are mounted
mnt (){ 
  mount | awk '$1 ~ /\/dev/ { print $1,$3; }' | column -t | sort ; 
}

# create, switch to, push new git branch
gnb (){
  git checkout -b "$1" 
  git push -u origin "$1"
}
# END ANSIBLE MANAGED BLOCK
