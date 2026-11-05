---
name: sync-ai-instruction
description: Use when deploying or syncing source instructions (instructions/core.md and tool deltas) to global instruction files for pi, opencode, Claude Code, or Hermes, or when asked to update, merge, or distribute global agent rules.
---

# Instruction Sync

원본을 각 도구 지침 파일에 반영한다. 매핑·보존 대상·금지 사항은 repo `README.md`의 "배포" 절과 `AGENTS.md`의 "배포 시 보존" 절이 소스다. 여기서는 판단 지점만 다룬다.

## 원칙

1. `instructions/`가 진실이다. 원본을 먼저 고치고 배포본에 반영한다. 배포본을 역으로 고치지 않는다.
2. 대상에만 있는 내용은 지우지 않고 질문한다. 동일 여부가 애매해도 질문한다.
3. 시크릿 값은 읽지도 출력하지도 않는다. 경로와 변수명만 다룬다.

## 절차

### 1. 대상 선택

배포표의 경로를 존재 여부만 확인한다. 내용은 아직 읽지 않는다.

```sh
for p in <표의 경로들>; do [ -e "$p" ] && echo "installed: $p" || echo "absent: $p"; done
```

설치 여부를 표로 보고하고, 사용자가 고른 도구만 배포한다. 추천 기본값은 "설치된 것 전부". 선택 전에는 어떤 파일도 쓰지 않는다. 선택되지 않은 도구는 `skipped: <tool> (not selected)`로 보고한다.

### 2. 기대 내용 조합

`core.md`와 표에 적힌 델타를 이어 붙여 기대 내용을 만든다. 델타가 없으면 `core.md`만 쓴다. `diff`로 대상과 비교한다.

### 3. 상태 분류

| 상태 | 동작 |
|------|------|
| 대상 없음 | 기대 내용으로 생성 |
| `diff` 결과 동일 | 변경 없음으로 보고, 쓰지 않음 |
| 대상에만 있는 블록 | 보존 목록과 대조하고 병합 |
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

사용자 답을 기다린다. "알아서 정리해도 된다"는 사전 허가도 이 정지 지점을 해제하지 않는다. 승인 없는 삭제 금지. 충돌은 사용자가 고른 쪽만 남긴다.

### 5. 반영

- 도구 전용 블록은 바이트 그대로 보존한다.
- 규칙 목록에 추가할 때는 기존 번호를 재정렬하지 않고 끝에 다음 번호로 붙인다.
- 수정 전 백업: `cp "$dst" "$dst.bak-$(date +%Y%m%d%H%M%S)"`.
- 임시 파일에 쓴 뒤 `mv`로 원자적 교체한다.

### 6. 검증

원본 규칙이 모두 대상에 존재하는지 확인하고 출력을 인용한다.

```
changed:  <path> (+N rules)
skipped:  <path> (identical)
pending:  <path> (awaiting approval: N duplicates)
preserved:<path> (tool-specific blocks untouched)
```

## 하지 말 것

- 대상에만 있는 내용을 조용히 삭제.
- 델타를 따로 배포 (공통 규칙 누락).
- 중복을 없애려고 기존 스킬 파일을 고치기.
