# Color shortcuts
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

# Git functions
get_git_branch() {
    echo -n "%{$GREEN_BOLD%}$(git_current_branch)"
}

get_git_staged() {
    # Format for git_prompt_status()
    ZSH_THEME_GIT_PROMPT_ADDED="%{$GREEN%}●"
    echo -n "$(git_prompt_status)"
    ZSH_THEME_GIT_PROMPT_ADDED=""
}

get_git_dirty() {
    # Format for parse_git_dirty()
    ZSH_THEME_GIT_PROMPT_DIRTY="%{$YELLOW%}●"
    echo -n "$(parse_git_dirty)"
}

get_git_untracked() {
    # Format for git_prompt_status()
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$RED%}●"
    echo -n "$(git_prompt_status)"
    ZSH_THEME_GIT_PROMPT_UNTRACKED=""
}

get_git_info() {
    # Verify if the current directory is inside a git repository
    if [[ -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]]; then
        echo -n "${GIT_INFO_PREFIX}"
        get_git_branch
        get_git_staged
        get_git_dirty
        get_git_untracked
        echo -n "${GIT_INFO_SUFFIX}"
    fi
}

START_PROMPT="%{$BLUE_BOLD%}%C"
END_PROMPT="%{$RESET_COLOR%} "

##carplay|master●●● foo # In a git repo
##Downloads| foo # Otherwise
#SEPARATOR="%{$RED_BOLD%}|"

#carplay[master●●●] foo # In a git repo
#Downloads foo # Otherwise
GIT_INFO_PREFIX="%{$GREEN_BOLD%}["
GIT_INFO_SUFFIX="%{$GREEN_BOLD%}]"

PROMPT='${START_PROMPT}${SEPARATOR}$(get_git_info)${END_PROMPT}'

# Status:
# - are there background jobs?
prompt_status() {
  [[ $(jobs -l | wc -l) -gt 0 ]] && echo -n " ⚙"
}

RPROMPT='%{$GREY_BOLD%}$(prompt_status)%{$RESET_COLOR%}'
