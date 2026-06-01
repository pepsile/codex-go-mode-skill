---
name: go-mode
description: Use when the user wants go-mode, goal execution, phased implementation, phase documentation, continuation after lost context, worktree/parallel-agent orchestration, or says 分阶段推进、进入 go mode、继续目标、按阶段执行、恢复上次进度.
---

# Go Mode

把这个 skill 当成“总入口”。它负责接收目标、拆分阶段，并把后续工作路由到合适的 Superpowers 流程里。顶层始终只盯一个目标。

## Operating Rules

- 先用一句话把目标锁死，再开始别的动作。
- 目标不清楚，或者有隐藏约束，就只问最少的问题，把阻塞点问开。
- 非 trivial 任务必须先给出 phase table，再改文件。
- 每个 phase 都必须有明确验收点；没有验收点，不算 phase。
- 非 trivial phase 必须沉淀阶段文档；先写计划，结束时回填状态、验证和下一步。
- 优先拆成小而能收尾的阶段，不要把一个大计划硬推到底。
- 一次运行里不要混进无关目标。
- 先判断工作是否需要隔离或并行；需要时先铺开战场，再执行任务。

## Required Opening

进入 go-mode 后，先做并展示这 4 件事；除非任务明显是单步小事，否则不要跳过：

1. **Goal Lock**：用一句话锁定本轮唯一目标。
2. **Phase Sketch**：列出 phase table，每个 phase 写清验收点。
3. **Isolation Check**：判断是否已经在 worktree / 是否需要创建或使用隔离 workspace。
4. **Routing Check**：说明本轮会使用哪些 skill / Superpowers，哪些暂不使用。

## Phase Gate

- 当前 phase 未验证，不进入下一个 phase。
- 如果中途发现 scope 扩大，先更新 phase table，再继续实现。
- 如果某个 phase 变得太大，先拆成更小 phase，不要硬推。
- 完成判断必须按原目标和 phase 验收点逐条核对，不能用已完成工作反推目标完成。

## Phase Documentation

非 trivial phase 开始前，必须创建或更新一份阶段 PRD 文档：

- 优先沿用当前 repo 的阶段文档目录和命名；如果已有 `docs/prd/`，使用 `docs/prd/phase-NN.md` 或当前项目已有的 phase 文件命名。
- 如果项目同时维护执行计划，可再按既有惯例创建 `docs/superpowers/plans/YYYY-MM-DD-phase-NN-slug.md`，但 PRD 是阶段沉淀的主文档。
- 如果 repo 没有既有惯例，按项目文档规则放到合适的 `docs/` 二级目录，例如 `docs/development/` 或 `docs/architecture/`。
- 使用 `templates/phase-prd-template.md` 作为骨架。
- 计划阶段至少写清：背景、用户价值、本期范围（包含 / 不包含）、关键数据字段或模块、验收标准、验证命令。
- 执行过程中如果范围变化，先更新 PRD 的包含 / 不包含和验收标准，再继续实现；不要只在聊天里维护状态。
- 收尾时回填 `完成状态`、实际 verification 结果、偏离计划的原因、下一期建议；如果项目有 `docs/dev-logs/`、`docs/NEXT_ACTIONS.md`、`docs/project-status.md` 等惯例，也要同步更新。
- 用户明确要求“只分析、不落文档”时，可以跳过写文件，但仍要给出同样结构的阶段草案。

## Route To Superpowers

- 还没有计划，或者需求还不清楚：用 `superpowers:brainstorming`
- 需要一份多步骤书面计划：用 `superpowers:writing-plans`
- 开始实现前需要隔离当前分支、保护现有改动，或准备并行任务：用 `superpowers:using-git-worktrees`
- 有 2 个以上互不依赖的问题域、测试失败、调研方向或实现切片：用 `superpowers:dispatching-parallel-agents`
- 已经有计划，希望在当前会话里执行：用 `superpowers:subagent-driven-development`
- 已经有计划，希望在独立会话里执行：用 `superpowers:executing-plans`
- 每个实现任务内部：用 `superpowers:test-driven-development`
- 遇到测试失败、构建失败、行为异常或原因不明的问题：用 `superpowers:systematic-debugging`
- 准备声称完成、修复、通过或收尾前：用 `superpowers:verification-before-completion`
- 某个任务已经变绿以后：先 simplify / refactor，再进入下一个任务
- 工作结束时：用 `superpowers:finishing-a-development-branch`

## Worktree / Agent Policy

- 开始实现前必须做 Isolation Check：当前 repo 是否 git 管理、当前工作区是否干净、是否已在 worktree、是否需要隔离。
- 默认先检查是否已经在隔离 workspace / worktree；不要重复套娃。
- 大改、长期任务、用户当前分支可能有未提交改动、或多个方案要试时，优先建议/创建 worktree。
- 目标包含 2 个以上互不依赖的问题域、测试失败、调研方向或实现切片时，必须先做 Parallel Agent Check。
- 并行 agent 只用于能清楚切开的任务：文件范围、责任边界、验收输出都要写清。
- 不把同一文件或同一状态交给多个 worker 同时改；主线程负责整合、审查和最终取舍。
- 一个方向卡住时，可以让另一个 worktree / agent 继续推进；但顶层目标仍只保留一个。
- 如果当前工具策略要求用户明确授权 sub-agent / parallel agent work，先提出并行方案；只有用户已授权时才派发。

## Default Loop

目标 -> Required Opening -> phase doc -> phase gate -> 测试 -> 实现 -> review -> simplify -> 验证 -> 更新 phase doc -> commit -> 下一个 phase

## Final Audit Gate

在宣布目标完成前，必须做一次最终审计：

- 覆盖表或任务清单里不能还有真实的 `未开始`、`开发中`、`需修复`。
- 状态文档不能还指向已经完成的 phase、审计或旧下一步。
- NEXT_ACTIONS 必须表达当前真实状态：已完成、可选 polish，或明确的新目标。
- 验证证据必须写入 dev log / status / 记忆库，而不是只留在聊天里。
- 如果只剩可选打磨，不要为了凑流程继续开新 phase。

## Guardrails

- 除非用户明确改目标，否则保持目标稳定。
- 变绿以后不能跳过 simplify / refactor。
- 当前 phase 没验证完，不要进下一个 phase。
- 如果某个 phase 变得太大，就先拆开，再实现，不要硬推。
- 并行不是目的；只有能降低阻塞、减少上下文污染或验证多个方向时才并行。
