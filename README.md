# go-mode

`go-mode` 是一个 Codex skill，用来把一个目标接住、锁定、拆成阶段，并把执行过程路由到合适的 Superpowers 工作流。

它适合这些场景：

- 你希望 Codex 进入 `go mode`，持续推进一个目标。
- 任务需要分阶段实现、验证和收尾。
- 任务可能需要 worktree 隔离，避免污染当前工作区。
- 任务可以拆给 parallel agent 或 sub-agent 并行推进。
- 需要为每个非 trivial phase 沉淀阶段 PRD 文档，方便后续恢复上下文。

## 安装位置

把本仓库放到 Codex skills 目录下：

```text
~/.codex/skills/go-mode
```

典型结构：

```text
go-mode/
  SKILL.md
  agents/
    openai.yaml
  templates/
    phase-prd-template.md
```

## 触发方式

可以在 Codex 里直接说：

```text
进入 go mode，帮我把这个目标分阶段推进：...
```

或者显式引用 skill：

```text
[$go-mode](/Users/pepsi/.codex/skills/go-mode/SKILL.md)
```

## 核心流程

进入 `go-mode` 后，先做四件事：

1. **Goal Lock**：用一句话锁定本轮唯一目标。
2. **Phase Sketch**：列出 phase table，每个 phase 写清验收点。
3. **Isolation Check**：判断当前工作区是否需要 worktree 隔离。
4. **Routing Check**：说明本轮会使用哪些 skill / Superpowers。

之后按 phase gate 推进：

```text
目标 -> Required Opening -> phase doc -> phase gate -> 测试 -> 实现 -> review -> simplify -> 验证 -> 更新 phase doc -> commit -> 下一个 phase
```

## 阶段文档

非 trivial phase 开始前，需要创建或更新阶段 PRD 文档。

如果项目已有 `docs/prd/`，优先使用：

```text
docs/prd/phase-NN.md
```

模板在：

```text
templates/phase-prd-template.md
```

阶段 PRD 建议覆盖：

- 背景
- 用户价值
- 本期范围：包含 / 不包含
- 数据字段 / 模块
- 完成状态
- 验收标准
- 验证命令

收尾时回填完成状态、实际验证结果、偏离计划和下一期建议。

## Worktree 与并行 Agent

`go-mode` 会在实现前判断：

- 当前目录是否是 git repo。
- 当前工作区是否干净。
- 是否已经处于 worktree。
- 是否需要创建隔离 workspace。
- 是否存在 2 个以上可以独立推进的问题域。

并行 agent 只用于边界清楚的任务。主线程负责整合、审查和最终取舍。

## 相关文件

- `SKILL.md`：skill 运行时指令。
- `agents/openai.yaml`：Codex UI 中展示的名称、说明和默认 prompt。
- `templates/phase-prd-template.md`：阶段 PRD 模板。
