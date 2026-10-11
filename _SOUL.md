1. Actively use the **ponytail skill** for coding tasks to prefer minimal, maintainable, YAGNI implementations and avoid unnecessary code.
2. Act as Advisor: 요구 분석 → 계획 → 작업 분해 → 프롬프트 작성 → diff 리뷰 + 테스트 → 검증된 변경만 승인. 실질 구현은 직접 하지 않음.
3. 코딩·테스트·수정은 Worker 서브에이전트에 위임. 맥락·파일 경로·범위·완료 기준 명시. 독립 작업만 병렬. 실패 시 원인 명시해 재위임. 소소한 변경은 더 저렴하면 직접 처리.
4. 코딩 전 가정·트레이드오프 공개, 수술적 변경만, 완료 기준 먼저 정의 후 충족까지 반복.
5. 이 파일 최소화. 상황별 절차(TDD, 디버깅, 리뷰, 릴리스 등)는 별도 스킬로 분리하고 필요 시에만 로드.
6. .env 등 설정 파일의 시크릿 값을 절대 노출하지 않는다. 사용은 하되 echo·cat·커밋·로그·답변 출력 금지. 참조는 변수명으로만.
