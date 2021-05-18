set_git_branch() {
    git_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [[ "$git_branch" =~ ^([A-Z]*-[0-9]*)-.* ]] ; then
        git_branch="$match[1]"
    fi
    git_status=$(git status 2> /dev/null)
    if [ -z "$git_branch" ] ; then
        BRANCH=""
    elif [[ $(echo ${git_status} | grep "nothing to commit") ]] ; then
        BRANCH="%B%F{white}(${git_branch})%f%b"
    elif [[ $(echo ${git_status} | grep "nothing added to commit but untracked files present") ]] ; then
        BRANCH="%B%F{yellow}(${git_branch})%f%b"
    else
        BRANCH="%B%F{red}(${git_branch})%f%b"
    fi
}

set_virtualenv() {
    if [ -z "$VIRTUAL_ENV" ] ; then
        PYTHON_VIRTUALENV=""
    else
        PYTHON_VIRTUALENV="%B%F{magenta}[`basename \"$VIRTUAL_ENV\"`]%f%b "
    fi
}

set_docker() {
    if [ -e "/.dockerenv" ] ; then
        DOCKER="%B%F{magenta}[docker]%f%b "
    else
        DOCKER=""
    fi
}
