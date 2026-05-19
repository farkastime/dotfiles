#!/usr/bin/env bash
# Fetches Claude service health from status.claude.com with a 5-minute cache.
# Usage: source this file, then call claude_status_indicator or claude_status_full.
#
# claude_status_indicator — one-line colored symbol for the status bar
# claude_status_full      — detailed component + incident report for /claude-status

CACHE_FILE="/tmp/claude-status-cache.json"
CACHE_TTL=300  # seconds

_fetch_status() {
  local now
  now=$(date +%s)

  if [ -f "$CACHE_FILE" ]; then
    local mtime
    mtime=$(stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0)
    if (( now - mtime < CACHE_TTL )); then
      cat "$CACHE_FILE"
      return
    fi
  fi

  # Fetch both endpoints in parallel, merge into one object
  local status components incidents
  status=$(curl -sf --max-time 4 "https://status.claude.com/api/v2/status.json" 2>/dev/null)
  components=$(curl -sf --max-time 4 "https://status.claude.com/api/v2/components.json" 2>/dev/null)
  incidents=$(curl -sf --max-time 4 "https://status.claude.com/api/v2/incidents/unresolved.json" 2>/dev/null)

  local empty_components='{"components":[]}'
  local empty_incidents='{"incidents":[]}'

  if [ -z "$status" ]; then
    # Don't cache failures — let the next render retry
    echo '{"error":true}'
    return
  else
    jq -n \
      --argjson s "$status" \
      --argjson c "${components:-$empty_components}" \
      --argjson i "${incidents:-$empty_incidents}" \
      '{indicator: $s.status.indicator, description: $s.status.description,
        components: ($c.components // []), incidents: ($i.incidents // [])}' > "$CACHE_FILE"
  fi

  cat "$CACHE_FILE"
}

# ── Status bar indicator (single token) ───────────────────────────────────────
claude_status_indicator() {
  local data indicator
  data=$(_fetch_status)

  if echo "$data" | jq -e '.error' &>/dev/null; then
    printf "\033[90m❓ api?\033[0m"
    return
  fi

  indicator=$(echo "$data" | jq -r '.indicator')

  case "$indicator" in
    none)        printf "\033[32m✓ claude\033[0m" ;;
    minor)       printf "\033[33m⚠ claude\033[0m" ;;
    major|critical) printf "\033[31m✖ claude\033[0m" ;;
    *)           printf "\033[90m❓ claude\033[0m" ;;
  esac
}

# ── Full status report (for /claude-status command) ───────────────────────────
claude_status_full() {
  local data indicator description
  data=$(_fetch_status 2>/dev/null)

  if echo "$data" | jq -e '.error' &>/dev/null; then
    echo "Could not reach status.claude.com"
    return 1
  fi

  indicator=$(echo "$data" | jq -r '.indicator')
  description=$(echo "$data" | jq -r '.description')

  # Overall status
  case "$indicator" in
    none)           echo -e "\033[32m✓ All systems operational\033[0m" ;;
    minor)          echo -e "\033[33m⚠ ${description}\033[0m" ;;
    major|critical) echo -e "\033[31m✖ ${description}\033[0m" ;;
    *)              echo -e "\033[90m? ${description}\033[0m" ;;
  esac

  # Components (only show degraded ones)
  local degraded
  degraded=$(echo "$data" | jq -r '
    .components[]
    | select(.status != "operational" and .group == false)
    | "  • \(.name): \(.status | gsub("_"; " "))"
  ')
  [ -n "$degraded" ] && echo -e "\nAffected components:\n${degraded}"

  # Active incidents
  local incident_count
  incident_count=$(echo "$data" | jq '.incidents | length')
  if (( incident_count > 0 )); then
    echo -e "\nActive incidents:"
    echo "$data" | jq -r '
      .incidents[]
      | "  [\(.impact | ascii_upcase)] \(.name)\n    Status: \(.status)\n    \(.incident_updates[0].body // "")"
    '
  fi

  # Cache age
  if [ -f "$CACHE_FILE" ]; then
    local age=$(( $(date +%s) - $(stat -c %Y "$CACHE_FILE") ))
    echo -e "\n\033[90mCached ${age}s ago — refreshes every ${CACHE_TTL}s\033[0m"
  fi
}
