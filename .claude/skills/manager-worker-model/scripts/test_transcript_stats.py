import json
import tempfile
from pathlib import Path

from transcript_stats import count_stats, munge_project_path


def write_transcript(records):
    """Write records to a temp .jsonl and return its path."""
    d = Path(tempfile.mkdtemp())
    p = d / "session.jsonl"
    p.write_text("".join(json.dumps(r) + "\n" for r in records))
    return p


def test_counts_only_human_prompts():
    p = write_transcript([
        {"type": "user", "promptSource": "typed", "sessionId": "s1",
         "message": {"role": "user", "content": "hello"}},
        {"type": "user", "promptSource": "queued", "sessionId": "s1",
         "message": {"role": "user", "content": "second"}},
        {"type": "user", "sessionId": "s1",
         "message": {"role": "user", "content": [{"type": "tool_result"}]}},
        {"type": "user", "promptSource": "system", "sessionId": "s1",
         "message": {"role": "user", "content": "not the human"}},
        {"type": "user", "promptSource": "suggestion_accepted", "sessionId": "s1",
         "message": {"role": "user", "content": "clicked"}},
    ])
    assert count_stats([p])["prompts"] == 2


def test_counts_human_characters_only():
    p = write_transcript([
        {"type": "user", "promptSource": "typed", "sessionId": "s1",
         "message": {"role": "user", "content": "12345"}},
        {"type": "user", "sessionId": "s1",
         "message": {"role": "user", "content": [{"type": "tool_result"}]}},
    ])
    assert count_stats([p])["user_chars"] == 5


def test_counts_assistant_text_and_tool_calls():
    p = write_transcript([
        {"type": "assistant", "sessionId": "s1", "message": {
            "role": "assistant",
            "content": [
                {"type": "text", "text": "abcd"},
                {"type": "tool_use", "name": "Bash"},
                {"type": "thinking", "thinking": "ignored"},
            ],
            "usage": {"input_tokens": 10, "output_tokens": 20},
        }},
    ])
    stats = count_stats([p])
    assert stats["assistant_chars"] == 4
    assert stats["tool_calls"] == 1
    assert stats["input_tokens"] == 10
    assert stats["output_tokens"] == 20


def test_counts_distinct_sessions():
    p = write_transcript([
        {"type": "user", "promptSource": "typed", "sessionId": "s1",
         "message": {"role": "user", "content": "a"}},
        {"type": "user", "promptSource": "typed", "sessionId": "s2",
         "message": {"role": "user", "content": "b"}},
    ])
    assert count_stats([p])["sessions"] == 2


def test_skips_malformed_lines():
    d = Path(tempfile.mkdtemp())
    p = d / "session.jsonl"
    p.write_text(
        '{"type": "user", "promptSource": "typed", "sessionId": "s1",'
        ' "message": {"role": "user", "content": "ok"}}\n'
        "not json at all\n"
        "\n"
    )
    assert count_stats([p])["prompts"] == 1


def test_empty_input_returns_zeros():
    stats = count_stats([])
    assert stats["prompts"] == 0
    assert stats["sessions"] == 0


def test_missing_usage_does_not_crash():
    p = write_transcript([
        {"type": "assistant", "sessionId": "s1",
         "message": {"role": "assistant", "content": [{"type": "text", "text": "hi"}]}},
    ])
    stats = count_stats([p])
    assert stats["input_tokens"] == 0
    assert stats["assistant_chars"] == 2


def test_munge_path_doubles_dash_for_dot_directories():
    assert munge_project_path("/home/tim/.claude").endswith("-home-tim--claude")
