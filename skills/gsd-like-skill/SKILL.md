---
name: GSD-like Development Workflow
description: 一个基于 GSD (Get Shit Done) 设计理念的规范驱动开发工作流技能，用于 iFlow CLI。
license: MIT 或 Proprietary. LICENSE.txt has complete terms
---


# GSD-like Development Workflow

一个基于 GSD (Get Shit Done) 设计理念的规范驱动开发工作流技能，用于 iFlow CLI。

## 核心理念

- **上下文工程优先**：保持每个任务的上下文新鲜和精简
- **规范驱动开发**：通过文档结构驱动开发，而非临时决策
- **专业化代理**：使用专门的子代理处理不同阶段
- **波式并行执行**：智能分析和并行执行独立任务
- **目标反向验证**：从目标开始验证，而非从任务
- **原子提交**：每个任务独立提交，清晰追踪

## 快速开始

```bash
# 初始化新项目
skill: "gsd-like-skill"
> task: init-project

# 规划阶段
skill: "gsd-like-skill"
> task: plan-phase --phase 1

# 执行阶段
skill: "gsd-like-skill"
> task: execute-phase --phase 1

# 验证工作
skill: "gsd-like-skill"
> task: verify-work --phase 1

# 查看进度
skill: "gsd-like-skill"
> task: progress
```

## 工作流程

### 1. 项目初始化

创建标准化的项目文档结构：

```
.planning/
├── PROJECT.md          # 项目愿景和核心价值
├── REQUIREMENTS.md     # 可检查的需求定义
├── ROADMAP.md          # 阶段规划和进度追踪
├── STATE.md            # 项目短期记忆
├── config.json         # 工作流配置
└── phases/
    └── XX-name/
        ├── XX-CONTEXT.md    # 实现决策
        ├── XX-RESEARCH.md   # 技术研究
        ├── XX-PLAN-*.md     # 执行计划
        ├── XX-PLAN-*-SUMMARY.md # 执行摘要
        └── XX-VERIFICATION.md # 验证报告
```

**使用方式**
```
skill: "gsd-like-skill"
> task: init-project
```

这将启动一个交互式流程，询问项目愿景、核心价值、技术约束等，然后创建标准化的文档结构。

### 2. 讨论阶段（可选）

在规划前捕获实现决策：

**使用方式**
```
skill: "gsd-like-skill"
> task: discuss-phase --phase 1
```

这将创建 `XX-CONTEXT.md`，包含：
- 实现决策（锁定选择）
- Claude 自由裁量（未指定领域）
- 延迟想法（未来考虑）

### 3. 规划阶段

研究、规划和验证阶段计划：

**使用方式**
```
skill: "gsd-like-skill"
> task: plan-phase --phase 1
```

**流程**
1. **研究**（可选）：调查技术领域，识别标准栈和模式
2. **规划**：创建 2-3 个任务的原子计划
3. **验证**：检查计划是否满足阶段目标

**输出**
- `XX-RESEARCH.md`：技术研究结果
- `XX-PLAN-*.md`：可执行计划（2-3个任务）
- 每个计划包含：
  - 目标和目的
  - 上下文引用
  - 任务列表（XML 格式）
  - 验证标准
  - 成功标准

### 4. 执行阶段

使用波式并行执行所有计划：

**使用方式**
```
skill: "gsd-like-skill"
> task: execute-phase --phase 1
```

**流程**
1. 分析依赖关系
2. 分组为执行波（waves）
3. 并行执行独立计划
4. 每个任务原子提交
5. 处理检查点和失败

**波式执行示例**
```
Wave 1 (并行): Plan 01, Plan 02 - 无依赖
Wave 2 (并行): Plan 03, Plan 04 - 依赖 Wave 1
Wave 3 (顺序): Plan 05 - 依赖 Wave 2
```

**输出**
- `XX-PLAN-*-SUMMARY.md`：每个计划的执行摘要
- Git 提交（每个任务一个）
- 更新 STATE.md 和 ROADMAP.md

### 5. 验证阶段

验证阶段目标是否达成：

**使用方式**
```
skill: "gsd-like-skill"
> task: verify-work --phase 1
```

**目标反向验证**
1. 陈述阶段目标
2. 推导可观察真理
3. 验证必需制品存在
4. 验证关键连接正确

**三层验证**
- **存在性**：文件是否存在
- **实质性**：是否有真实实现（非占位符）
- **连接性**：是否正确连接到其他组件

**输出**
- `XX-VERIFICATION.md`：验证报告
- 缺陷列表（如果发现）
- 修复计划（如果需要）

### 6. 阶段完成

标记阶段为完成并进入下一阶段：

**使用方式**
```
skill: "gsd-like-skill"
> task: complete-phase --phase 1
```

这将：
- 更新 ROADMAP.md 进度
- 更新 STATE.md 位置
- 准备下一阶段

## 项目文档结构

### PROJECT.md

项目的长期记忆，包含：

```markdown
# [Project Name]

## What This Is
[2-3句话描述产品]

## Core Value
[最重要的事情 - 一句话]

## Requirements
### Validated
- ✓ [已验证的需求]

### Active
- [ ] [当前范围]

### Out of Scope
- [排除项] — [原因]

## Context
[背景信息]

## Constraints
- **[类型]**: [什么] — [为什么]

## Key Decisions
| Decision | Rationale | Outcome |
|----------|-----------|---------|
```

### REQUIREMENTS.md

可检查的需求定义：

```markdown
# Requirements: [Project Name]

## v1 Requirements
### Authentication
- [ ] **AUTH-01**: User can sign up with email
- [ ] **AUTH-02**: Email verification after signup

## Traceability
| Requirement | Phase | Status |
|-------------|-------|--------|
| AUTH-01 | Phase 1 | Pending |
```

### ROADMAP.md

阶段规划和进度追踪：

```markdown
# Roadmap: [Project Name]

## Phases
- [ ] **Phase 1: Foundation** - [描述]
- [ ] **Phase 2: Features** - [描述]

## Phase Details
### Phase 1: Foundation
**Goal**: [目标]
**Requirements**: [AUTH-01, AUTH-02]
**Success Criteria**:
  1. [可观察行为]
  2. [可观察行为]
**Plans**: 3 plans

## Progress
| Phase | Plans Complete | Status |
|-------|----------------|--------|
| 1 | 0/3 | Not started |
```

### STATE.md

项目的短期记忆（<100行）：

```markdown
# Project State

## Project Reference
See: .planning/PROJECT.md
**Core value**: [一句话]
**Current focus**: [当前阶段]

## Current Position
Phase: 1 of 4 (Foundation)
Plan: 0 of 3
Status: Ready to plan
Progress: [░░░░░░░░░░] 0%

## Performance Metrics
- Total plans completed: 0
- Average duration: N/A

## Accumulated Context
### Decisions
None yet

### Pending Todos
None yet

### Blockers/Concerns
None yet
```

## 配置

### config.json

工作流配置：

```json
{
  "mode": "interactive",
  "granularity": "standard",
  "workflow": {
    "research": true,
    "plan_check": true,
    "verifier": true,
    "auto_advance": false
  },
  "planning": {
    "commit_docs": true
  },
  "parallelization": {
    "enabled": true,
    "max_concurrent_agents": 3,
    "min_plans_for_parallel": 2
  }
}
```

**配置选项**
- `mode`: "interactive" | "yolo"
- `granularity`: "coarse" | "standard" | "fine"
- `workflow.research`: 是否执行研究阶段
- `workflow.plan_check`: 是否验证计划
- `workflow.verifier`: 是否验证工作
- `parallelization.enabled`: 是否并行执行

## 计划格式

### PLAN.md 模板

```markdown
---
phase: 01-foundation
plan: 01
type: execute
wave: 1
depends_on: []
files_modified: []
autonomous: true
requirements: [AUTH-01]
must_haves:
  truths:
    - "User can sign up with email"
  artifacts:
    - path: "src/api/auth/signup.ts"
      provides: "Signup endpoint"
  key_links:
    - from: "src/components/Signup.tsx"
      to: "/api/auth/signup"
      via: "fetch"
---

<objective>
[这个计划完成什么]

Purpose: [为什么重要]
Output: [创建的制品]
</objective>

<context>
@.planning/PROJECT.md
@.planning/ROADMAP.md
@.planning/STATE.md
@.planning/phases/01-foundation/01-CONTEXT.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: [行动导向的名称]</name>
  <files>path/to/file.ts</files>
  <action>[具体实现 - 做什么、怎么做、避免什么]</action>
  <verify>[命令或检查]</verify>
  <done>[可接受的完成标准]</done>
</task>

</tasks>

<verification>
- [ ] [具体测试命令]
- [ ] [构建通过]
- [ ] [行为验证]
</verification>

<success_criteria>
- 所有任务完成
- 所有验证检查通过
- 没有引入错误或警告
</success_criteria>

<output>
After completion, create `.planning/phases/01-foundation/01-01-SUMMARY.md`
</output>
```

## 任务类型

### auto

Claude 可以独立完成的任务：

```xml
<task type="auto">
  <name>Task 1: Create user model</name>
  <files>src/models/user.ts</files>
  <action>Define User type with id, email, name</action>
  <verify>tsc --noEmit passes</verify>
  <done>User type exported and usable</done>
</task>
```

### checkpoint:human-verify

需要人类验证的任务：

```xml
<task type="checkpoint:human-verify" gate="blocking">
  <what-built>Dashboard - server at http://localhost:3000</what-built>
  <how-to-verify>Visit localhost:3000 and check layout</how-to-verify>
  <resume-signal>Type "approved" or describe issues</resume-signal>
</task>
```

### checkpoint:decision

需要人类决策的任务：

```xml
<task type="checkpoint:decision" gate="blocking">
  <decision>Choose authentication library</decision>
  <context>Affects security and implementation complexity</context>
  <options>
    <option id="option-a">
      <name>jose</name>
      <pros>Edge runtime compatible</pros>
      <cons>Newer, less docs</cons>
    </option>
    <option id="option-b">
      <name>jsonwebtoken</name>
      <pros>Well-established</pros>
      <cons>CommonJS issues</cons>
    </option>
  </options>
  <resume-signal>Select: option-a or option-b</resume-signal>
</task>
```

## 验证机制

### 目标反向验证

1. **陈述目标**："工作聊天接口"
2. **推导真理**：
   - 用户能看到现有消息
   - 用户能发送新消息
   - 消息持久化
3. **验证制品**：
   - 消息列表组件存在
   - API 路由存在
   - 类型定义存在
4. **验证连接**：
   - 组件 → API（fetch 调用）
   - API → 数据库（查询）

### 三层验证

| 层级 | 检查项 | 状态 |
|------|--------|------|
| 存在性 | 文件是否存在 | ✓/✗ |
| 实质性 | 是否有真实实现 | ✓/✗ |
| 连接性 | 是否正确连接 | ✓/✗ |

## 自动偏差处理

### 规则 1: 自动修复 Bug

触发：代码不符合预期行为

- 逻辑错误
- 类型错误
- 空指针异常

### 规则 2: 自动添加缺失功能

触发：缺少关键功能

- 错误处理
- 输入验证
- 认证保护

### 规则 3: 自动修复阻塞

触发：阻止完成任务

- 缺少依赖
- 错误的类型
- 缺少环境变量

### 规则 4: 询问架构变更

触发：需要重大结构修改

- 新数据库表
- 主要模式变更
- 切换库/框架

## 快速模式

对于不需要完整规划的临时任务：

```
skill: "gsd-like-skill"
> task: quick
```

快速模式提供 GSD 保证（原子提交、状态追踪），但跳过可选步骤。

## 工具使用

### Git 提交

每个任务完成后自动提交：

```bash
git add src/api/auth.ts
git commit -m "feat(01-01): create signup endpoint

- POST /api/auth/signup accepting email/password
- Validate email format and password strength
- Return 201 with user object on success
- Return 400 with error details on failure"
```

### 上下文引用

使用 `@file` 语法引用上下文：

```markdown
<context>
@.planning/PROJECT.md
@.planning/ROADMAP.md
@.planning/STATE.md
@src/components/Button.tsx
</context>
```

## 最佳实践

### 垂直切片优先

**推荐**（可并行）
```
Plan 01: 用户功能（模型 + API + UI）
Plan 02: 产品功能（模型 + API + UI）
```

**避免**（必须顺序）
```
Plan 01: 所有模型
Plan 02: 所有 API
Plan 03: 所有 UI
```

### 计划大小

- 2-3 个任务每个计划
- ~50% 上下文使用最大值
- 如果 >3 个任务则拆分

### 决策保真度

- **锁定决策**：必须完全实现
- **延迟想法**：不能出现在计划中
- **Claude 自由裁量**：合理选择

## 故障排除

### 计划未找到

错误：没有找到阶段 X 的计划

解决：先运行 `plan-phase --phase X`

### 验证失败

错误：验证发现缺陷

解决：
1. 查看 VERIFICATION.md 中的缺陷列表
2. 运行 `plan-phase --phase X --gaps` 创建修复计划
3. 运行 `execute-phase --phase X` 执行修复

### 状态不一致

错误：STATE.md 与实际状态不符

解决：运行 `task: health --repair` 自动修复

## 高级功能

### 代码库映射

对于现有代码库：

```
skill: "gsd-like-skill"
> task: map-codebase
```

这将分析现有代码并推断需求、模式和约定。

### 插入阶段

在现有阶段之间插入紧急工作：

```
skill: "gsd-like-skill"
> task: insert-phase --after 2 --name "critical-fix"
```

这将创建阶段 2.1 并调整依赖关系。

### PRD 快速路径

从 PRD 文件直接生成上下文：

```
skill: "gsd-like-skill"
> task: plan-phase --phase 1 --prd requirements/prd.md
```

这将解析 PRD 并生成 CONTEXT.md。

## 监控和调试

### 性能指标

STATE.md 包含性能指标：

- 完成的计划总数
- 平均持续时间
- 按阶段分解

### 调试模式

```
skill: "gsd-like-skill"
> task: debug "issue description"
```

这将启动调试代理，系统性诊断问题。

### 健康检查

```
skill: "gsd-like-skill"
> task: health --repair
```

验证 `.planning/` 目录完整性并自动修复问题。

## 限制和注意事项

1. **上下文限制**：每个计划应在 ~50% 上下文内完成
2. **文件冲突**：计划之间不应修改相同文件
3. **依赖循环**：避免循环依赖
4. **状态同步**：确保 STATE.md 始终最新
5. **Git 历史**：每个任务一个提交，保持清晰

## 扩展

### 自定义代理

创建自定义子代理：

```python
# .planning/agents/my-custom-agent.md
---
name: my-custom-agent
description: Custom agent for specific tasks
tools: Read, Write, Bash
color: blue
---

<role>
You are a custom agent for [specific purpose]
</role>

<process>
1. [Step 1]
2. [Step 2]
3. [Step 3]
</process>
```

### 自定义模板

创建自定义计划模板：

```markdown
# .planning/templates/custom-plan.md

---
phase: XX-name
plan: NN
type: execute
wave: N
depends_on: []
files_modified: []
autonomous: true
requirements: []
must_haves:
  truths: []
  artifacts: []
  key_links: []
---
```

## 参考资料

- GSD 原始项目：https://github.com/glittercowboy/get-shit-done
- 规范驱动开发理念
- 上下文工程最佳实践
- 多代理编排模式

---

*版本：1.0.0*
*基于 GSD v1.22.4 设计理念*