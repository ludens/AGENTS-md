---
name: sync-ai-instruction
description: >
  Use when applying AGENTS-md source files (instructions/core.md and tool
  deltas) to global instruction files for pi, opencode, Claude Code, or
  Hermes, or when asked to sync, update, merge, or distribute global agent
  rules. Preserves tool-only blocks. Deletes nothing without approval.
---

# Instruction Sync

전역 지침 원본을 각 도구의 지침 파일로 반영한다. 배포본은 `core.md`와 해당 델타를 합친 결과다.

## 원칙

1. `instructions/`가 진실이다. 원본을 먼저 고치고 배포본에 반영한다. 배포본을 역으로 고치지 않는다.
2. 대상에만 있는 도구 전용 블록은 보존한다. 기존 내용의 삭제·문구 재작성은 승인 후에만 한다.
3. 동일 여부가 애매하면 지우지 않고 질문한다.
4. 기존 스킬 파일은 수정하지 않는다. 규칙이 기존 스킬(caveman, ponytail 등)과 겹치면 보고하고 질문한다.
5. 시크릿 값은 읽지도 출력하지도 않는다. 경로와 변수명만 다룬다.

## 배포 매핑

repo root `README.md`의 배포표가 유일한 매핑 소스다. 표를 읽고 대상 경로와 필요한 델타를 얻는다.

## 절차

### 1. 대상 탐지 및 선택

1. `README.md` 배포표에서 도구와 경로 목록을 뽑는다.
2. 각 경로의 존재 여부만 확인한다. 내용은 아직 읽지 않는다.

```sh
for p in <표의 경로들>; do [ -e "$p" ] && echo "installed: $p" || echo "absent: $p"; done
```

3. 결과를 표로 보고하고 `question` 도구(multiple)로 적용 대상 도구를 고르게 한다. 선택지: 설치된 도구 각각, `설치된 것 전부`, `설치 안 된 것 포함 전부`.
4. 추천 기본값은 `설치된 것 전부`다. 선택을 받기 전에는 어떤 파일도 쓰지 않는다.
5. 선택되지 않은 도구는 `skipped: <tool> (not selected)`로 보고한다.

### 2. 원본 조합

`instructions/core.md`가 있는 디렉터리를 repo root로 잡는다. 없으면 사용자에게 경로를 묻는다.

선택된 도구마다 `core.md`와 표에 적힌 델타를 이어 붙여 기대 내용을 만든다. 델타가 없으면 `core.md`만 쓴다.

```sh
cat instructions/core.md instructions/claude.md > <임시 파일>
diff <임시 파일> "$dst"
```

### 3. 상태 분류

| 상태 | 동작 |
|------|------|
| 대상 없음 | 기대 내용으로 생성 |
| `diff` 결과 동일 | 변경 없음으로 보고, 쓰지 않음 |
| 대상에만 있는 블록 있음 | 보존 목록과 대조하고 병합 |
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

- 도구 전용 블록(`<!-- caveman-begin -->` 등)은 건드리지 않는다.
- 규칙 목록에 추가할 때는 기존 번호를 재정렬하지 않고 끝에 다음 번호로 붙인다.
- 수정 전 백업: `cp "$dst" "$dst.bak-$(date +%Y%m%d%H%M%S)"`.
- 쓰기는 임시 파일 후 `mv`로 원자적 교체한다.

### 6. 검증

원본 규칙이 모두 대상에 존재하는지 확인한다. 확인한 출력을 인용한다.

```
changed:  <path> (+N rules)
skipped:  <path> (identical)
pending:  <path> (awaiting approval: N duplicates)
preserved:<path> (tool-specific blocks untouched)
```

## 하지 말 것

- `cp`, `curl -o`로 통째 덮어쓰기. 도구 전용 블록이 사라진다.
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
| 델타를 따로 배포 | 공통 규칙 누락 | `core.md`와 합쳐서 배포 |
