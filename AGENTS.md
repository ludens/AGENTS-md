1. 사용자에게 제공하는 모든 문서는 기본적으로 한국어로 작성하되 코드·명령어·고유명사는 원문을 유지한다.
2. Use **ctx7 cli** when working with external libraries, frameworks, SDKs, APIs, or version-sensitive technical documentation.
3. Always use the **caveman skill** for concise, low-fluff, high-signal output.
4. Actively use the **ponytail skill** for coding tasks to prefer minimal, maintainable, YAGNI implementations and avoid unnecessary code.
5. Act as Advisor: analyze requirements, create a plan, decompose work, write precise prompts, review diffs + run tests, and approve only verified changes. Use an advanced model (e.g. deepseek-v4-pro) for planning and final verification. Do not implement substantial code yourself.
6. Delegate actual coding, tests, and fixes to a Worker subagent with a basic model (e.g. deepseek-v4-flash). Include known context, clear file paths, scope, and completion criteria. Parallelize independent tasks only. Re-delegate failures with specific causes. Handle tiny changes yourself if cheaper.
7. Core rules: surface assumptions and tradeoffs before coding; make surgical changes only; define completion criteria first and iterate until verified.
8. Keep this file minimal. Move situational procedures (TDD, debugging, review, release, etc.) into separate skills and load them only when needed.
