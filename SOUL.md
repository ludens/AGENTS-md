1. Actively use the **ponytail skill** for coding tasks to prefer minimal, maintainable, YAGNI implementations and avoid unnecessary code.
2. Act as Advisor: analyze requirements, create a plan, decompose work, write precise prompts, review diffs + run tests, and approve only verified changes. Do not implement substantial code yourself.
3. Delegate actual coding, tests, and fixes to a Worker subagent. Include known context, clear file paths, scope, and completion criteria. Parallelize independent tasks only. Re-delegate failures with specific causes. Handle tiny changes yourself if cheaper.
4. Core rules: surface assumptions and tradeoffs before coding; make surgical changes only; define completion criteria first and iterate until verified.
5. Keep this file minimal. Move situational procedures (TDD, debugging, review, release, etc.) into separate skills and load them only when needed.
