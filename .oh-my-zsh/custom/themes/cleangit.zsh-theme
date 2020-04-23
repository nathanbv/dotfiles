#######################################
# GIT PROMPT
#######################################

# Returns the name of the current branch
function get_git_branch() {
    command echo -n "%{$fg_bold[green]%}$(git_current_branch)"
}

# Stores the index to be parsed
function get_git_index() {
    ZSH_THEME_GIT_PROMPT_INDEX=$(command git status --porcelain 2> /dev/null)
}

# Returns a green flag if index and work tree matches (staged changes), or if
# there is stashed changes
function get_git_good() {
    local READY
    if $(command echo "$ZSH_THEME_GIT_PROMPT_INDEX" | command grep -E '^[ACDMRT]. ' &> /dev/null); then
        READY=1 # Staged
    elif $(command git rev-parse --verify refs/stash &> /dev/null); then
        READY=1 # Stashed
    fi
    [[ $READY ]] && command echo -n "%{$fg[green]%}●"
}

# Returns a yellow flag if work tree was changed (unstaged changes)
function get_git_bad() {
    if $(command echo "$ZSH_THEME_GIT_PROMPT_INDEX" | command grep -E '^.[ACDMRT] ' &> /dev/null); then
        command echo -n "%{$fg[yellow]%}●"
    fi
}

# Returns a red flag if there is untracked or unmerged changes
function get_git_ugly() {
    if $(command echo "$ZSH_THEME_GIT_PROMPT_INDEX" | command grep -E '^([\?U].|.[\?U]) ' &> /dev/null); then
        command echo -n "%{$fg[red]%}●"
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

    # Update the git index to be parsed
    get_git_index

    command echo -n "${ZSH_THEME_GIT_PROMPT_PREFIX}"
    get_git_branch
    get_git_good
    get_git_bad
    get_git_ugly
    command echo -n "${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}


#######################################
# MAIN PROMPT
#######################################

## You can choose between two flavours of prompt:

##carplay|master●●● foo # In a git repo
##Downloads foo # Otherwise
#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[red]%}|"
#ZSH_THEME_GIT_PROMPT_SUFFIX=""

#carplay[master●●●] foo # In a git repo
#Downloads foo # Otherwise
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[green]%}]"


ZSH_THEME_PROMPT_PREFIX="%{$fg_bold[blue]%}%C"
ZSH_THEME_PROMPT_SUFFIX="%{$reset_color%} "

# Create the PS1 prompt
PROMPT='${ZSH_THEME_PROMPT_PREFIX}$(get_git_info)${ZSH_THEME_PROMPT_SUFFIX}'


#######################################
# RIGHT PROMPT
#######################################

# Returns a flag if the last command returned a non-zero exit code
function get_error() {
    local -r RET_VAL=$?
    [[ $RET_VAL -ne 0 ]] && command echo -n " ♻"
}

# Returns a flag if there is backgroung jobs running
function get_bg_jobs() {
    [[ $(jobs -l 2> /dev/null | command wc -l 2> /dev/null) -gt 0 ]] && command echo -n " ⚙"
}

# Create the PS1 prompt on the right
RPROMPT='%{$fg[grey]%}$(get_error)$(get_bg_jobs)%{$reset_color%}'
