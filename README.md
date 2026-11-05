# AGENTS-md

**글로벌 작업 지침** 원본(소스 오브 트루스). 각 파일은 서로 다른 AI 도구가 사용한다.

| 파일 | 도구 | 배포 경로 | 내용 |
|------|------|-----------|------|
| `_AGENTS.md` | pi | `~/.pi/agent/AGENTS.md` | Advisor 모델 활용, Worker 위임 |
| `_AGENTS.md` | opencode | `~/.config/opencode/AGENTS.md` | Advisor 모델 활용, Worker 위임 |
| `_CLAUDE.md` | Claude Code | `~/.claude/CLAUDE.md` 또는 `<project>/CLAUDE.md` | Advisor/Coder/Verifier 분리 |
| `_SOUL.md` | Hermes | `~/.hermes/SOUL.md` | 공통 작업 원칙 (ponytail, 위임, 범위 변경) |
| `_MEMORY.md` | Hermes | `~/.hermes/memories/MEMORY.md` | 오래 기억할 상식 (ctx7, 작업 경로, Slack 매핑) |
| `_USER.md` | Hermes | `~/.hermes/memories/USER.md` | 사용자 출력 선호 (한국어, caveman) |

파일 간 include 없음 — 각 파일 단독 복사·배포 가능. 단 내용 일부 중복: 공통 규칙 수정 시 중복본 모두 갱신.

## 배포 · 동기화

위 표의 경로로 원본을 복사하거나 추가 병합한다. 절차는 [`sync-ai-instruction`](.agents/skills/sync-ai-instruction/SKILL.md) 스킬, landmine은 [AGENTS.md](AGENTS.md) 참조.

⚠️ 통째 덮어쓰기 금지: 대상에만 있는 내용이 사라진다. `~/.hermes/memories/MEMORY.md`의 hermes 전용 노트, `~/.config/opencode/AGENTS.md`의 caveman 블록, `~/.pi/agent/AGENTS.md`의 모델 문구가 그 예. 보존 필요 시 먼저 백업하고 병합한다.

## 규칙

- 문서는 한국어로 작성하되 코드·명령어·고유명사는 원문 유지
- 상황별 절차(TDD, 디버깅 등)는 별도 스킬 파일로 분리
