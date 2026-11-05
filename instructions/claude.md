# Claude Code 델타

`core.md`에 추가로 적용한다.

- 계획·최종 검증 모델: `claude-fable-5` 우선, 없으면 `claude-opus-5`.
- 코딩은 Coder 서브에이전트(`claude-sonnet-5`)에, 검증은 별도 독립 Verifier 서브에이전트(`claude-sonnet-5`)에 맡긴다. 같은 에이전트가 작성과 검증을 겸하지 않는다.
