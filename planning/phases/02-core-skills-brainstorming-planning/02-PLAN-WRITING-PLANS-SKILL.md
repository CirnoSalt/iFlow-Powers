# Plan 02: 移植 Writing Plans 技能

## 目标

将 Superpowers 的 Writing Plans 技能移植到 iFlow CLI，确保与 iFlow CLI 的工具集和技能格式完全兼容。

## 背景

Writing Plans 技能是 Superpowers 的核心规划技能之一，用于在实施多步骤任务之前创建详细的实施计划。它的核心价值是：

1. **零上下文假设**：假设工程师对代码库零上下文，文档化所有需要知道的内容
2. **细粒度任务**：每个步骤一个动作（2-5 分钟），确保可执行性
3. **完整代码**：在计划中提供完整的代码，而不是"添加验证"这样的描述
4. **精确命令**：提供精确的命令和预期输出
5. **执行交接**：提供两种执行方式供用户选择

## 技能分析

### Superpowers Writing Plans 技能的核心组件

1. **概述**：说明技能的用途和目标受众假设
2. **任务粒度**：定义每个步骤的时间范围（2-5 分钟）
3. **计划文档头部**：标准化的计划文档头部格式
4. **任务结构**：详细的任务结构模板
5. **记住事项**：关键原则（精确路径、完整代码、精确命令等）
6. **执行交接**：两种执行方式的说明

### 工具使用分析

| Superpowers 工具 | 使用场景 | iFlow CLI 映射 |
|-----------------|---------|---------------|
| `Write` | 保存计划文档 | `write_file` |
| `Skill` | 调用 executing-plans 或 subagent-driven-development 技能 | `Skill` |

### 子代理使用分析

Writing Plans 技能本身不直接使用子代理，但会根据用户选择调用以下技能：
- `executing-plans`：用于并行会话中的批量执行
- `subagent-driven-development`：用于当前会话中的子代理驱动执行

**注意**：这些子技能在 Phase 2 中不移植，将在后续阶段处理。

## 移植策略

### 1. 技能格式适配

**YAML Frontmatter**：
```yaml
---
name: writing-plans
description: 在接触代码之前，当你有规范或需求用于多步骤任务时使用此技能
version: 1.0.0
author: iFlow CLI
category: Planning
tags: planning,implementation,tasks
---
```

**主内容结构**：
- 概述（Overview）
- 任务粒度（Bite-Sized Task Granularity）
- 计划文档头部（Plan Document Header）
- 任务结构（Task Structure）
- 记住事项（Remember）
- 执行交接（Execution Handoff）

### 2. 工具映射

- `Write` → `write_file`：直接映射
- `Skill` → `Skill`：直接映射（但需要说明这些子技能尚未移植）

### 3. Bash 命令适配

Superpowers 使用 `git add` 和 `git commit` 命令。iFlow CLI 运行在 Windows 上，需要使用 PowerShell 命令。

**策略**：
- 将 `git add` 和 `git commit` 命令转换为 PowerShell 兼容的命令
- 或者提供 PowerShell 和 Git Bash 两种版本的命令
- 在文档中说明命令的执行方式

### 4. 子技能调用适配

Writing Plans 技能需要调用 executing-plans 和 subagent-driven-development 技能，但这些技能在 Phase 2 中不移植。

**策略**：
- 保留子技能调用说明
- 添加注释说明这些技能将在后续阶段移植
- 提供临时的执行方式说明

### 5. 文件路径格式

Superpowers 使用 Unix 风格的路径（`/`）。iFlow CLI 运行在 Windows 上，可能需要使用 Windows 风格的路径（`\`）。

**策略**：
- 保留 Unix 风格的路径（因为 Git 和大多数现代工具都支持）
- 在文档中说明路径格式的兼容性
- 如果需要，提供 Windows 路径作为备选

## 实施步骤

### Step 1: 创建技能目录结构

```
skills/writing-plans/
├── SKILL.md
└── examples/
    └── README.md
```

### Step 2: 编写 SKILL.md

- 编写 YAML frontmatter
- 翻译和适配主内容
- 确保工具调用正确
- 添加 iFlow CLI 特定的说明
- 说明子技能的移植状态

### Step 3: 编写使用示例

- 创建简单的使用示例
- 展示如何调用技能
- 展示计划文档的格式
- 展示任务结构的示例

### Step 4: 创建测试

- 创建 PowerShell 测试脚本
- 测试技能的基本功能
- 测试工具调用
- 测试计划文档的生成

### Step 5: 验证和文档

- 运行测试确保功能正常
- 编写验证报告
- 更新项目状态文档

## 关键决策点

### 决策 1: Bash 命令处理

**选项**：
1. 使用 PowerShell 命令
2. 使用 Git Bash 命令
3. 提供两种版本
4. 不包含 git 命令

**推荐**：选项 3（提供两种版本）

**理由**：
- 确保在不同环境中的兼容性
- 给用户更多选择

### 决策 2: 子技能处理

**选项**：
1. 完全移除子技能调用说明
2. 保留子技能调用说明，但标记为未移植
3. 实现简化版本的子技能
4. 将子技能调用改为手动说明

**推荐**：选项 2（保留子技能调用说明，但标记为未移植）

**理由**：
- 保持与 Superpowers 的一致性
- 为后续移植做好准备
- 让用户知道这些功能的存在

### 决策 3: 文件路径格式

**选项**：
1. 使用 Unix 风格路径（`/`）
2. 使用 Windows 风格路径（`\`）
3. 提供两种格式
4. 使用相对路径

**推荐**：选项 1（使用 Unix 风格路径）

**理由**：
- Git 和大多数现代工具都支持 Unix 风格路径
- 跨平台兼容性更好
- 与 Superpowers 保持一致

### 决策 4: 执行交接方式

**选项**：
1. 保留两种执行方式
2. 只保留子代理驱动方式
3. 只保留并行会话方式
4. 简化为单一执行方式

**推荐**：选项 1（保留两种执行方式）

**理由**：
- 给用户更多选择
- 适应不同的工作流程
- 与 Superpowers 保持一致

## 成功标准

1. ✅ Writing Plans 技能在 iFlow CLI 中可用
2. ✅ 技能遵循 iFlow CLI 的格式规范
3. ✅ 技能与 iFlow CLI 的工具集兼容
4. ✅ Bash 命令适配为 PowerShell/Git Bash
5. ✅ 子技能调用说明正确标记为未移植
6. ✅ 文件路径格式兼容
7. ✅ 至少有 2 个测试用例
8. ✅ 有清晰的使用说明和示例

## 风险和缓解措施

### 风险 1: Bash 命令在 Windows 上不工作

**缓解措施**：
- 提供 PowerShell 和 Git Bash 两种版本
- 测试两种环境中的命令执行

### 风险 2: 子技能未移植导致困惑

**缓解措施**：
- 在文档中明确说明子技能的移植状态
- 提供临时的执行方式说明
- 在子技能移植后更新文档

### 风险 3: 文件路径格式不兼容

**缓解措施**：
- 使用跨平台兼容的路径格式
- 在文档中说明路径格式的兼容性
- 测试不同环境中的路径解析

### 风险 4: 计划文档格式过于复杂

**缓解措施**：
- 提供清晰的模板和示例
- 在文档中解释每个部分的作用
- 创建简单的使用示例

## 时间估算

- Step 1: 创建目录结构 - 5 分钟
- Step 2: 编写 SKILL.md - 30 分钟
- Step 3: 编写使用示例 - 15 分钟
- Step 4: 创建测试 - 20 分钟
- Step 5: 验证和文档 - 10 分钟

**总计**: 约 80 分钟（在 2 小时限制内）

## 下一步行动

1. 创建技能目录结构
2. 开始编写 SKILL.md
3. 创建使用示例
4. 编写测试脚本
5. 运行测试并验证

## 相关文档

- [Phase 2 Context](./02-CONTEXT.md)
- [Superpowers Writing Plans 技能](../../../superpowers/skills/writing-plans/SKILL.md)
- [Brainstorming 技能移植计划](./02-PLAN-BRAINSTORMING-SKILL.md)
- [Phase 1 TDD 技能移植计划](../01-core-skills-tdd-debugging/01-PLAN-TDD-SKILL.md)

## 子技能移植计划

以下子技能将在后续阶段移植：

### Phase 3: 执行技能
- `executing-plans`：批量执行计划
- `subagent-driven-development`：子代理驱动的开发流程

### Phase 4: 集成和优化
- 完善技能调用链
- 优化执行流程
- 添加更多执行选项