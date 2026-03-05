# Plan 04: 移植 Subagent-Driven Development 技能

## 技能分析

### Superpowers 技能概述

**技能名称**: subagent-driven-development
**技能描述**: 在当前会话中执行具有独立任务的实施计划时使用

**核心原则**: 每个任务使用新的子代理 + 两阶段审查（规范 → 质量）= 高质量、快速迭代

**关键功能**:
1. 读取计划并提取所有任务
2. 每个任务使用新的子代理
3. 两阶段审查：规范合规性 → 代码质量
4. 审查循环直到通过
5. 完成开发

### iFlow CLI 兼容性分析

#### 工具使用分析

| Superpowers 工具 | iFlow CLI 工具 | 兼容性 | 备注 |
|------------------|----------------|--------|------|
| `Read` | `read_file` | ✅ 完全兼容 | 用于读取计划文件 |
| `TodoWrite` | `todo_write` | ✅ 完全兼容 | 用于创建待办事项列表 |
| `TodoRead` | `todo_read` | ✅ 完全兼容 | 用于读取待办事项列表 |
| `Task` | `task` | ✅ 完全兼容 | 用于分发子代理 |
| `Skill` | `Skill` | ✅ 完全兼容 | 用于调用子技能 |

#### 子代理使用分析

**子代理使用**:
- `implementer` → `general-purpose`（在 prompt 中明确角色）
- `spec-reviewer` → `plan-agent`（用于规范审查）
- `code-quality-reviewer` → `general-purpose`（用于质量审查）
- `code-reviewer` → `general-purpose`（用于最终代码审查）

**兼容性**:
- ✅ 使用 task 工具分发子代理
- ✅ 在 prompt 中明确角色
- ✅ 使用 iFlow CLI 的预定义代理类型

#### 子技能使用分析

**依赖的子技能**:
- `using-git-worktrees` - REQUIRED: 设置隔离工作空间
- `finishing-a-development-branch` - REQUIRED: 完成开发工作
- `requesting-code-review` - 可选: 用于最终代码审查

**兼容性**:
- ✅ using-git-worktrees 和 finishing-a-development-branch 将在 Phase 3 中移植
- ✅ requesting-code-review 可能需要移植（可选）
- ✅ 可以使用 Skill 工具调用

#### 特殊功能分析

1. **计划读取和任务提取**:
   - 读取计划文件一次
   - 提取所有任务及其完整文本
   - 记录上下文
   - 创建 TodoWrite

2. **每个任务的工作流**:
   - 分发实现者子代理（完整任务文本 + 上下文）
   - 实现者询问问题？→ 回答问题
   - 实现者实现、测试、提交、自我审查
   - 分发规范审查者子代理
   - 规范审查者确认代码符合规范？→ 修复规范缺口
   - 分发代码质量审查者子代理
   - 代码质量审查者批准？→ 修复质量问题
   - 标记任务完成

3. **最终代码审查**:
   - 分发最终代码审查者子代理
   - 审查整个实现
   - 使用 finishing-a-development-branch 技能

4. **vs. 执行计划（并行会话）**:
   - 相同的会话（无上下文切换）
   - 每个任务使用新的子代理（无上下文污染）
   - 每个任务后两阶段审查：规范合规性，然后代码质量
   - 更快的迭代（任务之间无人工循环）

5. **Prompt 模板**:
   - `./implementer-prompt.md` - 分发实现者子代理
   - `./spec-reviewer-prompt.md` - 分发规范合规性审查者子代理
   - `./code-quality-reviewer-prompt.md` - 分发代码质量审查者子代理

## 移植策略

### 1. 技能格式

- ✅ 使用 iFlow CLI 的技能格式（SKILL.md + YAML frontmatter）
- ✅ 包含必需的 YAML 字段（name, description, version, author, category, tags）
- ✅ 使用标准 Markdown 格式

### 2. 工具映射

- ✅ `Read` → `read_file`
- ✅ `TodoWrite` → `todo_write`
- ✅ `TodoRead` → `todo_read`
- ✅ `Task` → `task`（需要指定 subagent_type）
- ✅ `Skill` → `Skill`

### 3. 子代理适配

- ✅ `implementer` → `general-purpose`（在 prompt 中明确角色）
- ✅ `spec-reviewer` → `plan-agent`（用于规范审查）
- ✅ `code-quality-reviewer` → `general-purpose`（用于质量审查）
- ✅ `code-reviewer` → `general-purpose`（用于最终代码审查）

### 4. 子技能集成

- ✅ 使用 Skill 工具调用 using-git-worktrees
- ✅ 使用 Skill 工具调用 finishing-a-development-branch
- ✅ 可选：使用 Skill 工具调用 requesting-code-review

### 5. Prompt 模板

- ✅ 保留 Prompt 模板机制
- ✅ 适配 iFlow CLI 的 task 工具
- ✅ 在 prompt 中明确角色和任务

### 6. 计划文件处理

- ✅ 使用 read_file 工具读取计划文件
- ✅ 提取所有任务及其完整文本
- ✅ 记录上下文
- ✅ 创建 TodoWrite

### 7. 两阶段审查

- ✅ 保留两阶段审查机制
- ✅ 第一阶段：规范合规性
- ✅ 第二阶段：代码质量
- ✅ 审查循环直到通过

### 8. 审查循环

- ✅ 保留审查循环机制
- ✅ 如果审查者发现问题，实现者修复
- ✅ 审查者再次审查
- ✅ 重复直到批准

### 9. 最终代码审查

- ✅ 保留最终代码审查机制
- ✅ 审查整个实现
- ✅ 使用 finishing-a-development-branch 技能

## 实施步骤

### Step 1: 创建技能文件结构

**目录结构**:
```
skills/subagent-driven-development/
├── SKILL.md
├── prompts/
│   ├── implementer-prompt.md
│   ├── spec-reviewer-prompt.md
│   └── code-quality-reviewer-prompt.md
└── examples/
    └── README.md
```

### Step 2: 编写 SKILL.md

**内容**:
1. YAML frontmatter
2. 概述
3. 何时使用
4. 流程（5 个步骤）
5. Prompt 模板
6. 示例工作流
7. 优势
8. 红色警告

**YAML frontmatter**:
```yaml
---
name: subagent-driven-development
description: 在当前会话中执行具有独立任务的实施计划时使用
version: 1.0.0
author: iFlow CLI
category: Execution
tags: planning,workflow,subagent
---
```

### Step 3: 编写 Prompt 模板

**内容**:
1. implementer-prompt.md
2. spec-reviewer-prompt.md
3. code-quality-reviewer-prompt.md

**适配要点**:
- 使用 iFlow CLI 的工具集
- 明确角色和任务
- 提供完整的任务文本和上下文
- 包含自我审查要求

### Step 4: 编写示例文档

**内容**:
1. 简单示例（简单任务）
2. 复杂示例（多个任务，包含审查循环）
3. 特殊场景示例（子代理询问问题）

### Step 5: 创建测试脚本

**测试内容**:
1. 文件存在性测试
2. YAML frontmatter 测试
3. 必填字段测试
4. 必需章节测试
5. 工具映射测试
6. 示例测试
7. 子代理调用测试
8. Prompt 模板测试

### Step 6: 运行测试

- 运行测试脚本
- 修复发现的问题
- 确保所有测试通过

## 关键决策点

### 决策 1: 子代理类型映射

**问题**: 如何映射 Superpowers 的子代理类型到 iFlow CLI 的代理类型？

**选项**:
1. 使用 `general-purpose`，在 prompt 中明确角色
2. 创建自定义代理类型（如果 iFlow CLI 支持）
3. 使用多个 `general-purpose` 代理

**决策**: 使用 `general-purpose`，在 prompt 中明确角色

**理由**: iFlow CLI 不支持自定义代理定义，但可以在 prompt 中明确角色

### 决策 2: Prompt 模板内容

**问题**: Prompt 模板应该包含哪些内容？

**选项**:
1. 完全复制 Superpowers 的 prompt
2. 适配 iFlow CLI 的工具集
3. 创建简化的 prompt

**决策**: 适配 iFlow CLI 的工具集

**理由**: 需要使用 iFlow CLI 的工具，但保留 Superpowers 的核心逻辑

### 决策 3: 两阶段审查顺序

**问题**: 两阶段审查的顺序应该是？

**选项**:
1. 先规范合规性，后代码质量
2. 先代码质量，后规范合规性
3. 同时进行

**决策**: 先规范合规性，后代码质量

**理由**: Superpowers 的原始设计，先确保代码符合规范，再确保代码质量

### 决策 4: 子代理失败处理

**问题**: 如果子代理失败，应该如何处理？

**选项**:
1. 自动重试
2. 手动修复
3. 分发修复子代理

**决策**: 分发修复子代理

**理由**: Superpowers 的原始设计，避免上下文污染

## 成功标准

1. ✅ subagent-driven-development 技能在 iFlow CLI 中可用
2. ✅ 技能遵循 iFlow CLI 的格式规范
3. ✅ 技能与 iFlow CLI 的工具集兼容
4. ✅ 支持计划读取和任务提取
5. ✅ 支持每个任务使用新的子代理
6. ✅ 支持两阶段审查（规范 → 质量）
7. ✅ 支持审查循环
8. ✅ 支持子技能调用
9. ✅ 至少有 2 个测试用例
10. ✅ 有清晰的使用说明
11. ✅ Prompt 模板完整且准确

## 风险和缓解措施

### 风险 1: 子代理类型限制

**描述**: iFlow CLI 不支持自定义代理类型

**缓解措施**:
- 在 prompt 中明确角色
- 提供详细的任务描述
- 包含完整的上下文信息

### 风险 2: 子代理调用成本

**描述**: 每个任务需要多个子代理调用（实现者 + 2 个审查者）

**缓解措施**:
- 在文档中说明成本
- 提供优化建议
- 支持批量执行（可选）

### 风险 3: 审查循环时间

**描述**: 审查循环可能需要多次迭代

**缓解措施**:
- 提供清晰的审查标准
- 鼓励子代理一次性提供详细的反馈
- 支持手动干预（可选）

### 风险 4: 子技能未就绪

**描述**: 依赖的子技能可能未正确移植

**缓解措施**:
- 确保子技能在 Phase 3 中移植
- 提供临时手动执行方式
- 在文档中说明依赖关系

## 时间估算

- **Step 1**: 5 分钟
- **Step 2**: 30 分钟
- **Step 3**: 45 分钟（3 个 prompt 模板）
- **Step 4**: 15 分钟
- **Step 5**: 25 分钟
- **Step 6**: 10 分钟

**总计**: 约 130 分钟（2 小时 10 分钟）

## 文件清单

### 技能文件

- `skills/subagent-driven-development/SKILL.md`
- `skills/subagent-driven-development/prompts/implementer-prompt.md`
- `skills/subagent-driven-development/prompts/spec-reviewer-prompt.md`
- `skills/subagent-driven-development/prompts/code-quality-reviewer-prompt.md`
- `skills/subagent-driven-development/examples/README.md`

### 测试文件

- `skills/subagent-driven-development/tests/test-basic.ps1`

## 相关文档

- [Phase 3 Context](./03-CONTEXT.md)
- [Superpowers subagent-driven-development 技能](../../../superpowers/skills/subagent-driven-development/SKILL.md)
- [Superpowers implementer prompt](../../../superpowers/skills/subagent-driven-development/implementer-prompt.md)
- [Superpowers spec-reviewer prompt](../../../superpowers/skills/subagent-driven-development/spec-reviewer-prompt.md)
- [Superpowers code-quality-reviewer prompt](../../../superpowers/skills/subagent-driven-development/code-quality-reviewer-prompt.md)
- [Phase 1 Context](../01-core-skills-tdd-debugging/01-CONTEXT.md)
- [Phase 2 Context](../02-core-skills-brainstorming-planning/02-CONTEXT.md)
- [using-git-worktrees 技能移植计划](./03-PLAN-USING-GIT-WORKTREES-SKILL.md)
- [finishing-a-development-branch 技能移植计划](./03-PLAN-FINISHING-A-DEVELOPMENT-BRANCH-SKILL.md)