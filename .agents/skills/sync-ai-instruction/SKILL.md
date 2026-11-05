---
name: sync-ai-instruction
description: >
  Use when applying AGENTS-md source files (_AGENTS.md, _CLAUDE.md, _SOUL.md,
  _MEMORY.md, _USER.md) to global instruction files for pi, opencode, Claude
  Code, or Hermes, or when asked to sync, update, merge, or distribute global
  agent rules. Additive merge only. Never deletes or rewrites duplicate content
  without explicit user approval.
---

# Instruction Sync

전역 지침 원본을 각 도구의 지침 파일로 반영한다. 기본 동작은 추가 병합이다. 기존 내용의 삭제·재작성은 사용자 승인 없이는 금지한다.

## 원칙

1. `_*.md`가 진실이다. 원본을 먼저 고치고 배포본에 반영한다. 배포본을 역으로 고치지 않는다.
2. 추가만 한다. 기존 줄의 삭제, 문구 재작성, 순서 변경, 중복 제거는 승인 후에만 한다.
3. 동일 여부가 애매하면 지우지 않고 질문한다.
4. 도구 전용 블록은 보존한다. 예: `~/.config/opencode/AGENTS.md`의 `<!-- caveman-begin -->` 블록, `~/.hermes/memories/MEMORY.md`의 Hermes 전용 노트.
5. 기존 스킬 파일은 수정하지 않는다. 규칙이 기존 스킬(caveman, ponytail 등)과 겹치면 보고하고 질문한다.
6. 시크릿 값은 읽지도 출력하지도 않는다. 경로와 변수명만 다룬다.

## 배포 매핑

repo root `README.md`의 배포 표가 유일한 매핑 소스다. 표를 읽고 대상 경로를 얻는다. 표가 없거나 불완전하면 사용자에게 묻는다.

## 절차

### 1. 대상 탐지 및 선택

1. `README.md` 배포 표에서 도구와 경로 목록을 뽑는다.
2. 각 경로의 존재 여부만 확인한다. 내용은 아직 읽지 않는다.

```sh
for p in <표의 경로들>; do [ -e "$p" ] && echo "installed: $p" || echo "absent: $p"; done
```

3. 결과를 표로 보고하고 `question` 도구(multiple)로 적용 대상 도구를 고르게 한다. 선택지: 설치된 도구 각각, `설치된 것 전부`, `설치 안 된 것 포함 전부`.
4. 추천 기본값은 `설치된 것 전부`다. 선택을 받기 전에는 어떤 파일도 쓰지 않는다.
5. 선택되지 않은 도구는 `skipped: <tool> (not selected)`로 보고한다.

### 2. 원본 확인

`_AGENTS.md`가 있는 디렉터리를 repo root로 잡는다. 없으면 사용자에게 경로를 묻는다. 원본과 선택된 대상만 읽는다. 판단 전에 기계 비교를 먼저 한다.

```sh
diff "$src" "$dst"
```

### 3. 상태 분류

| 상태 | 동작 |
|------|------|
| 대상 없음 | 원본 내용으로 생성 |
| `diff` 결과 동일 | 변경 없음으로 보고, 쓰지 않음 |
| 대상에 원본에 없는 내용 있음 | 추가 병합 |
| 같은 규칙, 다른 표현 | 중복 후보로 보고 후 질문 |
| 값이 충돌(모델명, 경로, 수치) | 자동 해결 금지, 질문 |

### 4. 중복·충돌 처리 (필수 정지 지점)

삭제 전에 멈춘다. 파일별로 한 번에 보고한다.

```
중복 후보: <dst>:<line>
  기존: <text>
  원본: <text>
  판단: 동일 | 유사 | 충돌
  제안: 기존 유지 + 원본 생략 | 기존 삭제 | 문구 통합
```

`question` 도구로 묻고 답을 기다린다. 승인 없는 삭제 금지. 충돌은 사용자가 고른 쪽만 남긴다.

### 5. 병합

- 누락 규칙은 기존 번호 목록 뒤에 다음 번호로 추가한다.
- 기존 번호를 재정렬하지 않는다.
- 도구 전용 블록 안에 삽입하지 않는다. 규칙 목록 끝에 붙인다.
- 수정 전 백업: `cp "$dst" "$dst.bak-$(date +%Y%m%d%H%M%S)"`.
- 쓰기는 임시 파일 후 `mv`로 원자적 교체한다.

### 6. 검증

원본의 모든 규칙이 대상에 존재하는지 확인한다. 확인한 출력을 인용한다.

```
changed:  <path> (+N rules)
skipped:  <path> (identical)
pending:  <path> (awaiting approval: N duplicates)
preserved:<path> (tool-specific blocks untouched)
```

## 하지 말 것

- `cp`, `curl -o`로 통째 덮어쓰기. 대상에만 있는 내용이 사라진다.
- 중복이라는 이유로 조용히 삭제.
- 배포본을 원본처럼 수정.
- 기존 스킬 파일 편집으로 중복을 없애기.

## 흔한 실수

| 실수 | 결과 | 대신 |
|------|------|------|
| `diff` 없이 눈으로만 비교 | 동일 파일 재작성 | `diff` 먼저 |
| 규칙 번호 다시 매기기 | 기존 참조 깨짐 | 끝에 다음 번호 추가 |
| caveman 블록 덮어쓰기 | 전역 출력 규칙 소실 | 블록 보존 |
| 유사 규칙을 자동 통합 | 사용자 의도 변경 | 질문 후 통합 |
