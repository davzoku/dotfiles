#!/usr/bin/env bash
# Claude Code status line
# Mirrors: auth | dir | git branch | model | context % | rate limits

input=$(cat)

dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
dir_display=$(echo "$dir" | sed "s|$HOME|~|")
model=$(echo "$input" | jq -r '.model.display_name // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Auth status — check if claude CLI can report its auth state
if claude auth status > /dev/null 2>&1; then
  auth_status="authed"
else
  auth_status="unauthed"
fi

# Rate limits
five_pct=$(echo "$input"   | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
week_pct=$(echo "$input"   | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Git branch (skip optional locks to avoid contention)
git_branch=""
if [ -d "$dir/.git" ] || git -C "$dir" rev-parse --git-dir > /dev/null 2>&1; then
  git_branch=$(git -C "$dir" -c core.hooksPath=/dev/null symbolic-ref --short HEAD 2>/dev/null || git -C "$dir" rev-parse --short HEAD 2>/dev/null)
fi

# --- Auth indicator ---
if [ "$auth_status" = "authed" ]; then
  printf '\033[32mauth\033[0m'
else
  printf '\033[31munauthed\033[0m'
fi

# --- Dir ---
printf '  \033[36m%s\033[0m' "${dir_display}"

# --- Git branch ---
if [ -n "$git_branch" ]; then
  printf '  \033[33m%s\033[0m' "${git_branch}"
fi

# --- Model ---
if [ -n "$model" ]; then
  printf '  \033[34m%s\033[0m' "${model}"
fi

# --- Context usage ---
if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")
  if [ "$used_int" -ge 80 ]; then
    printf '  \033[31mctx:%s%%\033[0m' "${used_int}"
  elif [ "$used_int" -ge 50 ]; then
    printf '  \033[33mctx:%s%%\033[0m' "${used_int}"
  else
    printf '  \033[2mctx:%s%%\033[0m' "${used_int}"
  fi
fi

# --- 5-hour session limit ---
if [ -n "$five_pct" ]; then
  five_int=$(printf '%.0f' "$five_pct")
  reset_str=""
  if [ -n "$five_reset" ]; then
    # Format reset time as HH:MM SGT
    reset_str=" resets $(TZ=Asia/Singapore date -r "$five_reset" +%H:%M 2>/dev/null || TZ=Asia/Singapore date -d "@$five_reset" +%H:%M 2>/dev/null)"
  fi
  if [ "$five_int" -ge 80 ]; then
    printf '  \033[31m5h:%s%%%s\033[0m' "${five_int}" "${reset_str}"
  elif [ "$five_int" -ge 50 ]; then
    printf '  \033[33m5h:%s%%%s\033[0m' "${five_int}" "${reset_str}"
  else
    printf '  \033[2m5h:%s%%%s\033[0m' "${five_int}" "${reset_str}"
  fi
fi

# --- 7-day weekly limit ---
if [ -n "$week_pct" ]; then
  week_int=$(printf '%.0f' "$week_pct")
  if [ "$week_int" -ge 80 ]; then
    printf '  \033[31m7d:%s%%\033[0m' "${week_int}"
  elif [ "$week_int" -ge 50 ]; then
    printf '  \033[33m7d:%s%%\033[0m' "${week_int}"
  else
    printf '  \033[2m7d:%s%%\033[0m' "${week_int}"
  fi
fi

echo ""
