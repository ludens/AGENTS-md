#!/usr/bin/env bash
# GitHub 원본(_*.md)으로 로컬 지침 파일 교체.
# 전제: repo public. private이면 curl 대신 gh api로 교체 필요.
set -euo pipefail

REPO="ludens/AGENTS-md"
BASE="https://raw.githubusercontent.com/$REPO/main"

# src = 원본 파일명, dst = 로컬 배포 경로
install() {
  local src="$1" dst="$2" tmp
  tmp="$(mktemp)"
  trap 'rm -f "$tmp"' RETURN
  curl -fsSL "$BASE/$src" -o "$tmp"
  mkdir -p "$(dirname "$dst")"
  mv "$tmp" "$dst"
  chmod 644 "$dst"
  echo "installed: $dst"
}

case "${1:-all}" in
  pi)
    install _AGENTS.md "$HOME/.pi/agent/AGENTS.md"
    ;;
  claude)
    # 2번째 인자 = 프로젝트 디렉터리 (기본: 전역 ~/.claude)
    install _CLAUDE.md "${2:-$HOME/.claude}/CLAUDE.md"
    ;;
  hermes)
    install _SOUL.md   "$HOME/.hermes/SOUL.md"
    install _MEMORY.md "$HOME/.hermes/memories/MEMORY.md"
    install _USER.md   "$HOME/.hermes/memories/USER.md"
    ;;
  all)
    "$0" pi
    "$0" claude
    "$0" hermes
    ;;
  *)
    echo "usage: $0 {pi|claude [project_dir]|hermes|all}" >&2
    exit 1
    ;;
esac
