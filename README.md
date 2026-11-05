# AGENTS-md

여러 AI 도구에 넣을 전역 작업 지침의 원본 저장소.

`instructions/core.md` 하나가 공통 규칙을 갖고, 도구별 차이만 델타 파일로 분리한다. 같은 규칙을 여러 파일에 복사하지 않는다.

## 구조

```
AGENTS.md                      이 repo 작업용 메타 지침 (배포 대상 아님)
README.md                      구조·배포표
instructions/
  core.md                      모든 도구 공통 규칙
  hermes-user.md               Hermes 사용자 선호 (한국어, caveman)
.agents/skills/sync-ai-instruction/SKILL.md   배포 판단 규칙 (매핑·보존은 이 문서)
```

## 배포표

| 원본 | 도구 | 배포 경로 |
|------|------|-----------|
| `core.md` | pi | `~/.pi/agent/AGENTS.md` |
| `core.md` | opencode | `~/.config/opencode/AGENTS.md` |
| `core.md` | Hermes | `~/.hermes/SOUL.md` |
| `core.md` | Claude Code | `~/.claude/CLAUDE.md` 또는 `<project>/CLAUDE.md` |
| `hermes-user.md` | Hermes | `~/.hermes/memories/USER.md` |

모든 도구가 델타 없이 `core.md`를 쓴다. `hermes-user.md`만 단독으로 `USER.md`에 배포한다. `MEMORY.md`는 원본이 없다. 대상에 있는 내용을 보존한다.

## 배포

배포본은 원본을 합친 결과다. `core.md`와 해당 델타를 이어 붙여 대상에 반영한다.

symlink를 쓰지 않는다. 대상마다 도구 전용 블록이 있고, 보존해야 하기 때문이다.

1. 대상 파일과 합친 내용을 `diff`한다.
2. 다른 부분을 반영한다. 대상에만 있는 도구 전용 블록은 보존한다.
3. 반영 후 `diff` 출력을 인용해 확인한다.

통째 덮어쓰기 금지. 보존 대상은 `AGENTS.md`의 "배포 시 보존" 절 참조.
기존 내용 삭제나 문구 재작성은 사용자 승인 후에만 한다.

## 규칙

- 문서는 한국어로 작성하되 코드·명령어·고유명사는 원문 유지
- 상황별 절차(TDD, 디버깅 등)는 별도 스킬 파일로 분리
