# AGENTS-md

여러 AI 도구에 넣을 전역 작업 지침의 원본 저장소.

`instructions/core.md` 하나가 공통 규칙을 갖고, 도구별 차이만 델타 파일로 분리한다. 같은 규칙을 여러 파일에 복사하지 않는다.

## 구조

```
AGENTS.md                      이 repo 작업용 메타 지침 (배포 대상 아님)
README.md                      구조·배포표
instructions/
  core.md                      모든 도구 공통 규칙
  claude.md                    Claude Code 델타 (모델명, Verifier 분리)
  hermes-memory.md             Hermes 기억 노트 (작업 경로, Slack 매핑)
  hermes-user.md               Hermes 사용자 선호 (한국어, caveman)
.agents/skills/sync-ai-instruction/SKILL.md   배포 절차
```

## 배포표

| 원본 | 도구 | 배포 경로 |
|------|------|-----------|
| `core.md` | pi | `~/.pi/agent/AGENTS.md` |
| `core.md` | opencode | `~/.config/opencode/AGENTS.md` |
| `core.md` | Hermes | `~/.hermes/SOUL.md` |
| `core.md` + `claude.md` | Claude Code | `~/.claude/CLAUDE.md` 또는 `<project>/CLAUDE.md` |
| `hermes-memory.md` | Hermes | `~/.hermes/memories/MEMORY.md` |
| `hermes-user.md` | Hermes | `~/.hermes/memories/USER.md` |

pi·opencode·Hermes SOUL은 델타가 없다. `core.md`를 그대로 쓴다.

## 배포

배포본은 원본을 합친 결과다. `core.md`와 해당 델타를 이어 붙여 대상에 반영한다.

1. 대상 파일과 합친 내용을 `diff`한다.
2. 다른 부분을 반영한다. 대상에만 있는 도구 전용 블록은 보존한다.
3. 반영 후 `diff` 출력을 인용해 확인한다.

통째 덮어쓰기 금지. 보존 대상은 `AGENTS.md`의 "배포 시 보존" 절 참조.
기존 내용 삭제나 문구 재작성은 사용자 승인 후에만 한다.

## 규칙

- 문서는 한국어로 작성하되 코드·명령어·고유명사는 원문 유지
- 상황별 절차(TDD, 디버깅 등)는 별도 스킬 파일로 분리
