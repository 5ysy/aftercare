<div align="center">

# Aftercare

**面向编码 Agent 的"开发后"架构治理框架。**

在代码已经跑通*之后*才介入的纪律层。

[![Release](https://img.shields.io/github/v/release/your-org/aftercare?color=369eff&labelColor=black&style=flat-square)](https://github.com/your-org/aftercare/releases)
[![License](https://img.shields.io/badge/license-MIT-white?labelColor=black&style=flat-square)](LICENSE)
[![Stars](https://img.shields.io/github/stars/your-org/aftercare?color=ffcb47&labelColor=black&style=flat-square)](https://github.com/your-org/aftercare/stargazers)
[![Issues](https://img.shields.io/github/issues/your-org/aftercare?color=ff80eb&labelColor=black&style=flat-square)](https://github.com/your-org/aftercare/issues)
[![Contributors](https://img.shields.io/github/contributors/your-org/aftercare?color=c4f042&labelColor=black&style=flat-square)](https://github.com/your-org/aftercare/graphs/contributors)

[Claude Code](docs/README.claude-code.md) · [OpenCode](docs/README.opencode.md) · [Workflows](docs/WORKFLOWS.md) · [Philosophy](docs/PHILOSOPHY.md)

[English](README.md) | **简体中文**

</div>

---

## 这是什么问题

绝大多数 AI 编码工具,优化的都是同一个时刻:**从需求到能跑的代码**。

Aftercare 关心的是另一个时刻 —— 那些工具留下的烂摊子。

工单关了。测试过了。CI 是绿的。但与此同时:

- 职责悄悄滑到了错误的层
- 路由和控制器不知不觉变成了应用服务
- 公共工具目录沦为垃圾场
- 流水线越堆越多,没有契约、重试,也没有可观测性
- 目录结构和产品模型早已对不上
- 每个新需求都走"最省力的路径",而不是"正确的路径"

这就是 **架构漂移 (architecture drift)**。它不会出现在测试报告里,而是在六个月后浮出水面 —— 那时下一次改动的代价会变成原本的三倍。

Aftercare 的目标,是让编码 Agent 在宣告"完成"之前先慢下来,审视结构,把批评转化成分阶段执行的计划。

## Aftercare 是什么

一个 **以 skill 为核心** 的"开发后"阶段框架。它接入你现有的 Host(Claude Code、OpenCode 等),为它们补上下面这些事情上的判断力:

- 架构 Review
- 边界 Review
- 项目结构 Review
- 流水线与编排 Review
- 依赖治理
- 可观测性 Review
- 测试加固
- 增量重构计划
- 合并就绪性决策

它**不是**又一个埋头执行的 Agent,不是 CLI 的替代品,也不打算给你灌输某种框架信仰。它教你的 Host *怎么看待已经写完的代码,以及下一步该做什么*。

## 核心能力

|       | 能力                  | 解释                                                                                            |
| :---: | :------------------ | :-------------------------------------------------------------------------------------------- |
|   🔍   | **七项 Review skill** | 架构、边界、结构、流水线、依赖、可观测性、测试 —— 每一项都有结构化产出。                                                       |
|   📐   | **严重度模型**           | Critical / High / Medium / Low 四档评分,把真正的阻塞项和"以后再清理"清晰分开。                                     |
|   🧭   | **工作流地图**           | "什么时候用哪个 skill、按什么顺序"有现成的决策树,不靠拍脑袋。                                                          |
|   🧱   | **重构计划**            | Review 发现转化成分阶段的、保行为的执行计划,**先有计划再动代码**。                                                      |
|   ✂️   | **增量执行**            | 重构按小切片推进,每一片都重跑测试、可回滚。                                                                        |
|   🛂   | **合并就绪性闸**          | 输出结构化判定:proceed / fix-then-merge / hold,带风险账目,而不是模糊评语。                                       |
|   📋   | **报告模板**            | 每个 Review 都按统一模板输出,便于人看、便于复盘、便于做规模化治理。                                                        |
|   🧩   | **Host 无关**         | 一等公民支持 Claude Code 与 OpenCode,其他支持 skill 的 Host 同样工作。                                        |
|   🧠   | **强观点的共享参考**        | 反模式、工程原则、严重度评分都集中在 `references/`,各 skill 只做差异化扩展,不重复抄写。                                     |
|   🪶   | **零运行时**            | 纯 Markdown skill + 极小的 plugin manifest。无构建、无运行时、无 lock-in。                                  |

## 为什么需要它

AI 生成的代码,失败模式通常只有两种:

1. 局部正确,但全局乱。
2. 工单完成了,但仓库被悄悄削弱了。

更深层的问题不是"代码烂",而是 **在交付压力下发生的结构性退化**。一个功能完全可以满足验收标准,同时又让承载它的代码库变得更脆弱。

Aftercare 存在的理由,正是因为这是当下 Agent 最薄弱、而代价随时间被放大得最厉害的那个区域。

## 核心工作流

```
                  ┌─────────────────────────────┐
   完成的工作        │ 1. Review                   │
   ──────────►   │   architecture-review       │
                  │   boundary-review           │
                  │   project-structure-review  │
                  │   pipeline-review           │
                  │   dependency-governance     │
                  │   observability-review      │
                  │   test-hardening            │
                  └──────────────┬──────────────┘
                                 │ 出现 medium 及以上发现?
                                 ▼
                  ┌─────────────────────────────┐
                  │ 2. Plan(规划)              │
                  │   refactor-planning         │
                  └──────────────┬──────────────┘
                                 │ 方向已被人类批准
                                 ▼
                  ┌─────────────────────────────┐
                  │ 3. Execute(执行)           │
                  │   executing-incremental-    │
                  │   refactors                 │
                  └──────────────┬──────────────┘
                                 ▼
                  ┌─────────────────────────────┐
                  │ 4. Gate(放行闸)            │
                  │   merge-readiness-review    │
                  └─────────────────────────────┘
```

详细决策树见 [`references/workflow-maps.md`](references/workflow-maps.md) 与 [`docs/WORKFLOWS.md`](docs/WORKFLOWS.md)。

## Skill 库

每个 skill 位于 `skills/<name>/SKILL.md`,同目录下可附带子文件。

| Skill                              | 用途                              |
| ---------------------------------- | ------------------------------- |
| `using-aftercare`                  | 介绍框架本身及其决策规则                    |
| `architecture-review`              | 实施完成后的整体结构契合度审查                 |
| `boundary-review`                  | 找出分层与依赖边界的泄漏                    |
| `pipeline-review`                  | 审查请求、异步、数据、Agent 等各类流水线         |
| `project-structure-review`         | 审查目录布局与模块可发现性                   |
| `dependency-governance`            | 审查新引入的库、共享模块与耦合                 |
| `observability-review`             | 审查日志、指标、追踪与故障可见性                |
| `test-hardening`                   | 在重构前补齐/打磨测试,以保护既有行为             |
| `refactor-planning`                | 把 Review 发现转换成分阶段执行计划           |
| `executing-incremental-refactors`  | 以小而安全的切片执行已批准的计划                |
| `merge-readiness-review`           | 给出带风险账目的合并判定                    |
| `handling-review-feedback`         | 严肃处理来自 AI / 人类的 Review 反馈       |
| `writing-aftercare-skills`         | 贡献者用的元 skill,用于扩展 skill 库       |

## 安装

### Claude Code

见 [`docs/README.claude-code.md`](docs/README.claude-code.md)。

### OpenCode

见 [`docs/README.opencode.md`](docs/README.opencode.md)。

### 让 Agent 帮你装(一句 Prompt)

如果你懒得自己装,把下面这段贴给你的 Agent:

```
请按照 https://github.com/your-org/aftercare 仓库 docs/ 目录下的 host 安装指南
为当前仓库安装 Aftercare。从中挑出与我使用的编码 Agent (Claude Code 或 OpenCode)
对应的那一份,严格按它执行。
```

## 常用 Prompt 示例

装好之后,直接在你现有的 Host 里这样用:

- "在我宣告完成前,用 Aftercare 把当前改动 review 一遍。"
- "用 Aftercare 检查这个功能有没有引入边界泄漏。"
- "跑一次项目结构 review,告诉我哪些文件该挪。"
- "把上面的发现转换成一份增量重构计划。"
- "合并前对这份 diff 跑一次 Aftercare 合并就绪性 review。"

## 设计目标

1. 优先保住已经能跑的行为。
2. 宁可做小而安全的重构,也不要戏剧性地大改。
3. 把代码结构当作一等的产品议题,而不是格式偏好。
4. 区分"阻塞合并"与"待清理 backlog"。
5. 输出可执行的计划,而不是模糊的批评。
6. 跨多个 Host Agent 通用。
7. 在已有代码库里就能用,不只服务于干净的 greenfield 项目。

## 仓库结构

```text
aftercare/
├── AGENTS.md                       # 与 Host 无关的 Agent 指南
├── .claude-plugin/                 # Claude Code 插件清单
├── agents/                         # 专用的 reviewer / planner agents
├── docs/                           # 架构、工作流、Host 安装指南
├── examples/                       # 真实的报告、计划与 Host 配置
├── references/                     # 严重度模型、反模式、工程原则
├── scripts/validate-skills.sh      # 结构校验脚本
├── skills/<name>/SKILL.md          # skill 库本体
└── tests/smoke.sh                  # 端到端校验入口
```

## 推荐的采用路径

### 个人
全局安装。每次完成非琐碎功能、合并前、以及大段 AI 生成 diff 之后,都跑一次 Aftercare。

### 团队
- 先就"哪些 finding 算阻塞"达成一致
- 统一一份合并判定输出格式
- 明确"哪些 skill 在合并前必跑"
- 把真实项目里的 review 报告反哺回 `examples/`

### 组织
- 通过 marketplace 或插件分发
- 在 `references/business-scenarios.md` 里维护各技术栈的取舍说明
- 度量"架构漂移随时间的变化",而不是只看每个 PR 是否过关

## 校验

- `scripts/validate-skills.sh` —— 对 skill 库结构、以及本 README 的 skill 表做一致性校验
- `tests/smoke.sh` —— 端到端校验入口;开 PR 之前先跑一遍

完整贡献流程见 [`CONTRIBUTING.md`](CONTRIBUTING.md)。

## Aftercare **不是**什么

- 不是又一个埋头执行的 Agent
- 不是你 Host CLI 的替代品
- 不是放之四海皆准的"架构打分机器人"
- 不是某种框架信仰的传教工具

Aftercare 默认你的 Host 已经会读文件、写代码、跑测试、用 shell。它唯一的工作,是给 Host 补上**"开发后"阶段的判断力**。

## License

MIT。详见 [LICENSE](LICENSE)。
