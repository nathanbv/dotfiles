# Color definition
RED=$fg[red]
YELLOW=$fg[yellow]
GREEN=$fg[green]
WHITE=$fg[white]
BLUE=$fg[blue]
CYAN=$fg[cyan]
GREY=$fg[grey]
RED_BOLD=$fg[red]
YELLOW_BOLD=$fg_bold[yellow]
GREEN_BOLD=$fg_bold[green]
WHITE_BOLD=$fg_bold[white]
BLUE_BOLD=$fg_bold[blue]
CYAN_BOLD=$fg_bold[cyan]
GREY_BOLD=$fg_bold[grey]
RESET_COLOR=$reset_color

# Returns the name of the current branch
function get_git_branch() {
    command echo -n "%{$GREEN_BOLD%}$(git_current_branch)"
}

# Returns a green flag if index and work tree matches (staged changes), or if
# there is stashed changes
function get_git_good() {
    local READY
    if $(command git status --porcelain 2> /dev/null | command grep '^[ACDMRT]. ' &> /dev/null); then
        READY=1 # Staged
    elif $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
        READY=1 # Stashed
    fi
    [[ $READY ]] && command echo -n "%{$GREEN%}●"
}

# Returns a yellow flag if work tree was changed (unstaged changes)
function get_git_bad() {
    if $(command git status --porcelain 2> /dev/null | command grep '^.[ACDMRT] ' &> /dev/null); then
        command echo -n "%{$YELLOW%}●"
    fi
}

# Returns a red flag if there is untracked or unmerged changes
function get_git_ugly() {
    if $(command git status --porcelain 2> /dev/null | command grep -E '^([\?U].|.[\?U]) ' &> /dev/null); then
        command echo -n "%{$RED%}●"
    fi
}

# If the current directory is inside a git tree returns a formatted string with
# the branch name and the flags
function get_git_info() {
    # Return if the current directory is not inside a git repository
    local IS_GIT
    if $(command git symbolic-ref HEAD &> /dev/null); then
        IS_GIT=1
    elif $(command git rev-parse --short HEAD &> /dev/null); then
        IS_GIT=1
    fi
    [[ ! $IS_GIT ]] && return

    command echo -n "${GIT_INFO_PREFIX}"
    get_git_branch
    get_git_good
    get_git_bad
    get_git_ugly
    command echo -n "${GIT_INFO_SUFFIX}"
}

START_PROMPT="%{$BLUE_BOLD%}%C"
END_PROMPT="%{$RESET_COLOR%} "


## You can choose between two flavours of prompt:

##carplay|master●●● foo # In a git repo
##Downloads foo # Otherwise
#GIT_INFO_PREFIX="%{$RED_BOLD%}|"
#GIT_INFO_SUFFIX=""

#carplay[master●●●] foo # In a git repo
#Downloads foo # Otherwise
GIT_INFO_PREFIX="%{$GREEN_BOLD%}["
GIT_INFO_SUFFIX="%{$GREEN_BOLD%}]"

# Create the PS1 prompt
PROMPT='${START_PROMPT}$(get_git_info)${END_PROMPT}'

# Returns a flag if the last command returned a non-zero exit code
function get_error() {
    local -r RET_VAL=$?
    [[ $RET_VAL -ne 0 ]] && command echo -n " ♻"
}

# Returns a flag if there is backgroung jobs running
function get_bg_jobs() {
    [[ $(jobs -l | command wc -l) -gt 0 ]] && command echo -n " ⚙"
}

# Create the PS1 prompt on the right
RPROMPT='%{$GREY%}$(get_error)$(get_bg_jobs)%{$RESET_COLOR%}'
