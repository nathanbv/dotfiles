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

get_git_ready() {
    # Format for git_prompt_status()
    ZSH_THEME_GIT_PROMPT_ADDED="A"
    ZSH_THEME_GIT_PROMPT_STASHED="S"
    if [[ -n $(git_prompt_status) ]]; then
        echo -n "%{$GREEN%}●"
    fi
    ZSH_THEME_GIT_PROMPT_ADDED=""
    ZSH_THEME_GIT_PROMPT_STASHED=""
}

get_git_waiting() {
    # Format for git_prompt_status()
    ZSH_THEME_GIT_PROMPT_MODIFIED="M"
    ZSH_THEME_GIT_PROMPT_RENAMED="R"
    ZSH_THEME_GIT_PROMPT_DELETED="D"
    ZSH_THEME_GIT_PROMPT_UNMERGED="U"
    if [[ -n $(git_prompt_status) ]]; then
        echo -n "%{$YELLOW%}●"
    fi
    ZSH_THEME_GIT_PROMPT_MODIFIED=""
    ZSH_THEME_GIT_PROMPT_RENAMED=""
    ZSH_THEME_GIT_PROMPT_DELETED=""
    ZSH_THEME_GIT_PROMPT_UNMERGED=""
}

get_git_ugly() {
    # Format for git_prompt_status()
    ZSH_THEME_GIT_PROMPT_UNTRACKED="UT"
    ZSH_THEME_GIT_PROMPT_UNMERGED="UM"
    ZSH_THEME_GIT_PROMPT_AHEAD="A"
    ZSH_THEME_GIT_PROMPT_BEHIND="B"
    ZSH_THEME_GIT_PROMPT_DIVERGED="D"
    if [[ -n $(git_prompt_status) ]]; then
        echo -n "%{$RED%}●"
    fi
    ZSH_THEME_GIT_PROMPT_UNTRACKED=""
    ZSH_THEME_GIT_PROMPT_UNMERGED=""
    ZSH_THEME_GIT_PROMPT_AHEAD=""
    ZSH_THEME_GIT_PROMPT_BEHIND=""
    ZSH_THEME_GIT_PROMPT_DIVERGED=""
}

get_git_info() {
    # Verify if the current directory is inside a git repository
    if [[ -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]]; then
        echo -n "${GIT_INFO_PREFIX}"
        get_git_branch
        get_git_ready
        get_git_waiting
        get_git_ugly
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
