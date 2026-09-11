#!/usr/bin/env python3
"""Count human and assistant activity from Claude Code session transcripts."""

import json
import sys
from pathlib import Path

# Tool results also carry role "user"; only these promptSource values are a
# human typing. Without this filter prompt counts overreport by roughly 9x.
HUMAN_PROMPT_SOURCES = {"typed", "queued"}


def munge_project_path(project_dir):
    """Return the transcript directory name Claude Code uses for a project.

    Both "/" and "." become "-", so /home/tim/.claude maps to
    -home-tim--claude.
    """
    resolved = str(Path(project_dir).resolve())
    return resolved.replace("/", "-").replace(".", "-")


def transcript_paths(project_dir):
    """Return the .jsonl transcripts recorded for a project directory."""
    d = Path.home() / ".claude" / "projects" / munge_project_path(project_dir)
    return sorted(d.glob("*.jsonl")) if d.is_dir() else []


def _text_len(content):
    """Character count of readable text, ignoring thinking and tool blocks."""
    if isinstance(content, str):
        return len(content)
    if not isinstance(content, list):
        return 0
    return sum(
        len(b.get("text", ""))
        for b in content
        if isinstance(b, dict) and b.get("type") == "text"
    )


def count_stats(paths):
    stats = {
        "prompts": 0,
        "user_chars": 0,
        "assistant_chars": 0,
        "tool_calls": 0,
        "input_tokens": 0,
        "output_tokens": 0,
        "sessions": 0,
    }
    sessions = set()

    for path in paths:
        with open(path, encoding="utf-8") as fh:
            for line in fh:
                line = line.strip()
                if not line:
                    continue
                try:
                    rec = json.loads(line)
                except json.JSONDecodeError:
                    continue
                if not isinstance(rec, dict):
                    continue

                kind = rec.get("type")
                if kind not in ("user", "assistant"):
                    continue
                if rec.get("sessionId"):
                    sessions.add(rec["sessionId"])

                message = rec.get("message") or {}
                content = message.get("content")

                if kind == "user":
                    if rec.get("promptSource") in HUMAN_PROMPT_SOURCES:
                        stats["prompts"] += 1
                        stats["user_chars"] += _text_len(content)
                    continue

                stats["assistant_chars"] += _text_len(content)
                if isinstance(content, list):
                    stats["tool_calls"] += sum(
                        1
                        for b in content
                        if isinstance(b, dict) and b.get("type") == "tool_use"
                    )
                usage = message.get("usage") or {}
                stats["input_tokens"] += usage.get("input_tokens") or 0
                stats["output_tokens"] += usage.get("output_tokens") or 0

    stats["sessions"] = len(sessions)
    return stats


def main():
    project = sys.argv[1] if len(sys.argv) > 1 else "."
    paths = transcript_paths(project)
    if not paths:
        print(f"No transcripts found for {Path(project).resolve()}")
        return 1

    s = count_stats(paths)
    print(f"Project:            {Path(project).resolve()}")
    print(f"Transcripts:        {len(paths)}")
    print(f"Sessions:           {s['sessions']}")
    print(f"Prompts written:    {s['prompts']:,}")
    print(f"Words written:      ~{s['user_chars'] // 5:,} ({s['user_chars']:,} chars)")
    print(f"Assistant text:     {s['assistant_chars']:,} chars")
    print(f"Tool calls:         {s['tool_calls']:,}")
    print(f"Input tokens:       {s['input_tokens']:,}")
    print(f"Output tokens:      {s['output_tokens']:,}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
