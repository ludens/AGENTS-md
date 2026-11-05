# AGENTS.md

이 repo는 여러 AI 도구에 넣을 전역 지침의 원본 저장소다. 애플리케이션 코드는 없다.

## 편집 규칙

- 공통 규칙은 `instructions/core.md`만 고친다. 도구별 차이는 `instructions/<tool>.md` 델타에 둔다.
- 같은 규칙을 두 파일에 복사하지 않는다. 중복이 보이면 core로 올린다.
- 이 파일은 이 repo에서 작업하는 에이전트용이다. 배포 대상이 아니다.
- 배포표는 `README.md`가 유일한 소스다. 배포는 `.agents/skills/sync-ai-instruction` 스킬을 따른다.

## 배포 시 보존

- `~/.config/opencode/AGENTS.md`의 `<!-- caveman-begin -->` 블록
- `~/.pi/agent/AGENTS.md`의 모델 문구

## 검증

- 문서 변경도 실제 파일 존재와 링크를 확인하고 출력을 인용한다.
- 배포 후에는 `diff` 결과를 인용한다.
