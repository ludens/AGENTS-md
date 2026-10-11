# AGENTS.md

## 배포 매핑 (원본 → 도구)

| 원본 | 도구 | 배포 경로 |
|------|------|-----------|
| `_AGENTS.md` | pi | `~/.pi/agent/AGENTS.md` |
| `_CLAUDE.md` | Claude Code | `<project>/CLAUDE.md` |
| `_SOUL.md` | Hermes | `~/.hermes/SOUL.md` |
| `_MEMORY.md` | Hermes | `~/.hermes/memories/MEMORY.md` |
| `_USER.md` | Hermes | `~/.hermes/memories/USER.md` |

변경 시 원본(`_*.md`) 먼저 수정 → 배포본 반영. 역방향 수정 금지.

## Landmines

- 공통 규칙이 파일 간 중복. 한 규칙 수정 시 모든 중복본 함께 수정:
  - ponytail · Advisor/위임 · "파일 최소화" → `_AGENTS.md`, `_CLAUDE.md`, `_SOUL.md`
  - 한국어/caveman 출력 → `_AGENTS.md`, `_CLAUDE.md`, `_USER.md`
  - README의 "파일 간 독립"은 include 없음(사용 시점) 뜻. 중복 없음 뜻 아님.
- 원본↔배포본 드리프트 있음 (수동 동기화라 어긋남):
  - `~/.hermes/memories/MEMORY.md`에 `_MEMORY.md`에 없는 hermes 전용 노트 (cron 주기, config 키, 인증)
  - `~/.pi/agent/AGENTS.md` 모델 문구가 `_AGENTS.md`와 상이
  - 어느 쪽이 진짜 원본인지 확정 후 한쪽으로 통일할 것.
- 다른 에이전트(`~/.moltis`, `~/.zeroclaw`, `~/.nanobot`, `~/.nullclaw`)는 각자 workspace 파일 사용 — 원본과 미동기화.
