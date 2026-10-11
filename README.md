# AGENTS-md

**글로벌 작업 지침** 원본(소스 오브 트루스). 각 파일은 서로 다른 AI 도구가 사용한다.

| 파일 | 도구 | 내용 |
|------|------|------|
| `_AGENTS.md` | pi | Advisor 모델 활용, Worker 위임 |
| `_CLAUDE.md` | Claude Code | Advisor/Coder/Verifier 분리 |
| `_SOUL.md` | Hermes | 공통 작업 원칙 (ponytail, 위임, 범위 변경) |
| `_MEMORY.md` | Hermes | 오래 기억할 상식 (ctx7, 작업 경로, Slack 매핑) |
| `_USER.md` | Hermes | 사용자 출력 선호 (한국어, caveman) |

파일 간 include 없음 — 각 파일 단독 복사·배포 가능. 단 내용 일부 중복: 공통 규칙 수정 시 중복본 모두 갱신.

## 배포 · 동기화

배포 경로, 동기화 규칙, landmine은 [AGENTS.md](AGENTS.md) 참조.

### 원격 배포 (pull)

#### 한 줄 curl (복붙용)

```sh
# pi
curl -fsSL https://raw.githubusercontent.com/ludens/AGENTS-md/main/_AGENTS.md -o ~/.pi/agent/AGENTS.md

# claude (전역)
curl -fsSL https://raw.githubusercontent.com/ludens/AGENTS-md/main/_CLAUDE.md -o ~/.claude/CLAUDE.md

# hermes
mkdir -p ~/.hermes/memories && curl -fsSL https://raw.githubusercontent.com/ludens/AGENTS-md/main/_SOUL.md -o ~/.hermes/SOUL.md && curl -fsSL https://raw.githubusercontent.com/ludens/AGENTS-md/main/_MEMORY.md -o ~/.hermes/memories/MEMORY.md && curl -fsSL https://raw.githubusercontent.com/ludens/AGENTS-md/main/_USER.md -o ~/.hermes/memories/USER.md
```

#### 스크립트 (원자적 교체)

GitHub 원본(`_*.md`)을 받아 로컬 지침 파일로 교체하는 스크립트: [`sync.sh`](sync.sh)

```sh
./sync.sh pi        # _AGENTS.md → ~/.pi/agent/AGENTS.md
./sync.sh claude    # _CLAUDE.md → ~/.claude/CLAUDE.md (전역)
./sync.sh claude /path/to/project  # → /path/to/project/CLAUDE.md (프로젝트별)
./sync.sh hermes    # _SOUL/_MEMORY/_USER → ~/.hermes/*
./sync.sh all       # 위 셋 전부
```

- 전제: repo public. private이면 스크립트 내 `curl`을 `gh api`로 교체.
- 다운로드 성공 후 원자적 교체(`mktemp` → `mv`)라 fetch 실패 시 기존 파일 안 깨짐.
- ⚠️ 덮어쓰기 주의: `~/.hermes/memories/MEMORY.md`에 원본에 없는 hermes 전용 노트, `~/.pi/agent/AGENTS.md`에 상이한 모델 문구 있음(AGENTS.md landmine 참조). `sync.sh`는 이들을 원본으로 덮어쓴다. 보존 필요 시 먼저 백업.

## 규칙

- 문서는 한국어로 작성하되 코드·명령어·고유명사는 원문 유지
- 상황별 절차(TDD, 디버깅 등)는 별도 스킬 파일로 분리
