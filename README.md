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

## 규칙

- 문서는 한국어로 작성하되 코드·명령어·고유명사는 원문 유지
- 상황별 절차(TDD, 디버깅 등)는 별도 스킬 파일로 분리
