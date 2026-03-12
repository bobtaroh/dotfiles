#!/bin/sh
input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // empty')
context_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')

# Git branch + dirty count
git_branch=""
git_dirty=""
if [ -n "$cwd" ]; then
    git_branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
    if [ -n "$git_branch" ]; then
        dirty_count=$(git -C "$cwd" status --short 2>/dev/null | wc -l | tr -d ' ')
        [ "$dirty_count" -gt 0 ] && git_dirty=" \033[31m●${dirty_count}\033[0m"
    fi
fi

output=""

# Working directory (blue) - show last 2 path components
if [ -n "$cwd" ]; then
    short_cwd=$(echo "$cwd" | awk -F/ '{if(NF>2) print $(NF-1)"/"$NF; else print $0}')
    output="\033[34m${short_cwd}\033[0m"
fi

# Git branch (green) + dirty count (red)
[ -n "$git_branch" ] && output="${output}  \033[32m${git_branch}\033[0m${git_dirty}"

# Model (yellow)
[ -n "$model" ] && output="${output}  \033[33m${model}\033[0m"

# Context usage gauge
if [ -n "$context_used" ]; then
    gauge_width=10
    filled=$(( context_used * gauge_width / 100 ))
    empty=$(( gauge_width - filled ))
    bar=""
    i=0
    while [ $i -lt $filled ]; do bar="${bar}█"; i=$(( i + 1 )); done
    i=0
    while [ $i -lt $empty ]; do bar="${bar}░"; i=$(( i + 1 )); done
    if [ "$context_used" -ge 90 ]; then
        color="\033[31m"
    elif [ "$context_used" -ge 70 ]; then
        color="\033[33m"
    else
        color="\033[36m"
    fi
    output="${output}  ${color}[${bar}] ${context_used}%\033[0m"
fi

printf "%b" "$output"
