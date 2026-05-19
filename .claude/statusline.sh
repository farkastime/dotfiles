#!/usr/bin/env bash
# Claude Code status line script
# Reads JSON from stdin (provided by Claude Code harness)

input=$(cat)
settings=~/.claude/settings.json

# shellcheck source=claude-status-check.sh
source ~/.claude/claude-status-check.sh

# ── Working directory ──────────────────────────────────────────────────────────
dir=$(echo "$input" | jq -r '.workspace.current_dir')

# ── Git branch ────────────────────────────────────────────────────────────────
branch=$(git -C "$dir" symbolic-ref --short HEAD 2>/dev/null)

# ── Model ─────────────────────────────────────────────────────────────────────
model_raw=$(echo "$input" | jq -r '.model.display_name // .model.id // .model // empty' 2>/dev/null)
[ -z "$model_raw" ] && model_raw=$(jq -r '.model // empty' "$settings" 2>/dev/null)
case "$(echo "$model_raw" | tr '[:upper:]' '[:lower:]')" in
  *opus*)   model="Opus"   ;;
  *sonnet*) model="Sonnet" ;;
  *haiku*)  model="Haiku"  ;;
  *)        model="$model_raw" ;;
esac

# ── Effort level ──────────────────────────────────────────────────────────────
effort=$(jq -r '.effortLevel // empty' "$settings" 2>/dev/null)

# ── Context usage ─────────────────────────────────────────────────────────────
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty' 2>/dev/null)
[ -n "$ctx_pct" ] && ctx_pct="$(printf "%.0f" "$ctx_pct")%"

# ── Claude service health ─────────────────────────────────────────────────────
health=$(claude_status_indicator)

# ── Render ────────────────────────────────────────────────────────────────────
out="\033[94m📁 ${dir}\033[0m"
[ -n "$branch"   ] && out+="  \033[32m🌿 ${branch}\033[0m"
[ -n "$model"    ] && out+="  \033[35m🤖 ${model}\033[0m"
[ -n "$effort"   ] && out+="  \033[33m⚡ ${effort}\033[0m"
[ -n "$ctx_pct"  ] && out+="  \033[36m🧠 ${ctx_pct}\033[0m"
[ -n "$health"   ] && out+="  ${health}"

printf "%b\n" "$out"
