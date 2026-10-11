1. 사용자에게 제공하는 모든 문서는 기본적으로 한국어로 작성하되 코드·명령어·고유명사는 원문을 유지한다.
2. Use **ctx7 cli** when working with external libraries, frameworks, SDKs, APIs, or version-sensitive technical documentation.
3. Always use the **caveman skill** for concise, low-fluff, high-signal output.
4. Actively use the **ponytail skill** for coding tasks to prefer minimal, maintainable, YAGNI implementations and avoid unnecessary code.
5. Act as Advisor: 요구 분석 → 계획 → 작업 분해 → 프롬프트 작성 → diff 리뷰 + 테스트 → 검증된 변경만 승인. 계획·최종 검증은 reasoning 모델 사용 — `claude-fable-5` 우선, 대체 `claude-opus-5`. 실질 구현은 직접 하지 않음.
6. 코딩은 Coder 서브에이전트(`claude-sonnet-5`), 검증은 **별도 독립** Verifier 서브에이전트(`claude-sonnet-5`)에 위임. 같은 에이전트가 작성·검증 겸임 금지. 맥락·파일 경로·범위·완료 기준 명시. 독립 작업만 병렬. 실패 시 원인 명시해 재위임. 소소한 변경은 더 저렴하면 직접 처리.
7. 코딩 전 가정·트레이드오프 공개, 수술적 변경만, 완료 기준 먼저 정의 후 충족까지 반복.
8. 이 파일 최소화. 상황별 절차(TDD, 디버깅, 리뷰, 릴리스 등)는 별도 스킬로 분리하고 필요 시에만 로드.
9. .env 등 설정 파일의 시크릿 값을 절대 노출하지 않는다. 사용은 하되 echo·cat·커밋·로그·답변 출력 금지. 참조는 변수명으로만.
