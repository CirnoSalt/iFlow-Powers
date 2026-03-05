# Plan 01: 移植 Brainstorming 技能

## 目标

将 Superpowers 的 Brainstorming 技能移植到 iFlow CLI，确保与 iFlow CLI 的工具集和技能格式完全兼容。

## 背景

Brainstorming 技能是 Superpowers 的核心规划技能之一，用于在实现任何功能之前进行创意探索和设计。它的核心价值是：

1. **强制设计优先**：在编写任何代码之前必须完成设计并获得用户批准
2. **结构化探索**：通过系统的流程（探索上下文 → 提问 → 提出方案 → 展示设计）确保理解完整
3. **多方案对比**：总是提出 2-3 种方案，展示权衡，并给出推荐
4. **渐进式验证**：分节展示设计，每节后获得用户批准

## 技能分析

### Superpowers Brainstorming 技能的核心组件

1. **流程图**：使用 GraphViz DOT 描述流程
2. **Checklist**：6 个必须完成的任务
3. **HARD-GATE**：强制门禁，确保在获得批准之前不进行实现
4. **Anti-Pattern**：说明"太简单不需要设计"的错误观念
5. **关键原则**：一次一个问题、多选题优先、YAGNI 等

### 工具使用分析

| Superpowers 工具 | 使用场景 | iFlow CLI 映射 |
|-----------------|---------|---------------|
| `Read` | 探索项目上下文（文件、文档、提交） | `read_file` |
| `Write` | 编写设计文档 | `write_file` |
| `Bash` | 提交设计文档到 git | `run_shell_command` |
| `Skill` | 调用 writing-plans 技能 | `Skill` |

### 子代理使用分析

Brainstorming 技能本身不使用子代理，但会调用 writing-plans 技能。

## 移植策略

### 1. 技能格式适配

**YAML Frontmatter**：
```yaml
---
name: brainstorming
description: 在任何创造性工作之前必须使用此技能 - 创建功能、构建组件、添加功能或修改行为。在实现之前探索用户意图、需求和设计。
version: 1.0.0
author: iFlow CLI
category: Planning
tags: brainstorming,design,planning
---
```

**主内容结构**：
- 概述（Overview）
- 硬门禁（HARD-GATE）
- 反模式（Anti-Pattern）
- 检查清单（Checklist）
- 流程图（Process Flow）
- 流程说明（The Process）
- 关键原则（Key Principles）

### 2. 工具映射

- `Read` → `read_file`：直接映射
- `Write` → `write_file`：直接映射
- `Bash` → `run_shell_command`：需要适配为 PowerShell 命令
- `Skill` → `Skill`：直接映射

### 3. 流程图适配

Superpowers 使用 GraphViz DOT 格式的流程图。iFlow CLI 也支持 Markdown 中的流程图，但可能需要确认具体支持的格式。

**策略**：
- 保留 GraphViz DOT 格式（如果 iFlow CLI 支持）
- 或者转换为 ASCII 艺术或 Mermaid 格式
- 在文档中提供文字描述作为备选

### 4. Bash 命令适配

Superpowers 使用 `git commit` 命令提交设计文档。iFlow CLI 运行在 Windows 上，需要使用 PowerShell 命令。

**策略**：
- 将 `git commit` 命令转换为 PowerShell 兼容的命令
- 或者提供 PowerShell 和 Git Bash 两种版本的命令
- 在文档中说明命令的执行方式

### 5. 子代理调用适配

Brainstorming 技能需要调用 writing-plans 技能。

**策略**：
- 使用 `Skill` 工具调用 writing-plans 技能
- 确保调用时传递正确的上下文和参数

## 实施步骤

### Step 1: 创建技能目录结构

```
skills/brainstorming/
├── SKILL.md
└── examples/
    └── README.md
```

### Step 2: 编写 SKILL.md

- 编写 YAML frontmatter
- 翻译和适配主内容
- 确保工具调用正确
- 添加 iFlow CLI 特定的说明

### Step 3: 编写使用示例

- 创建简单的使用示例
- 展示如何调用技能
- 展示技能的输出格式

### Step 4: 创建测试

- 创建 PowerShell 测试脚本
- 测试技能的基本功能
- 测试工具调用
- 测试子代理调用

### Step 5: 验证和文档

- 运行测试确保功能正常
- 编写验证报告
- 更新项目状态文档

## 关键决策点

### 决策 1: 流程图格式

**选项**：
1. 保留 GraphViz DOT 格式
2. 转换为 Mermaid 格式
3. 使用 ASCII 艺术
4. 提供多种格式

**推荐**：选项 1（保留 GraphViz DOT 格式）+ 选项 4（提供文字描述作为备选）

**理由**：
- GraphViz DOT 是标准格式，易于维护
- 文字描述确保在不支持图形渲染的环境中也能理解流程

### 决策 2: Bash 命令处理

**选项**：
1. 使用 PowerShell 命令
2. 使用 Git Bash 命令
3. 提供两种版本
4. 不包含 git 命令

**推荐**：选项 3（提供两种版本）

**理由**：
- 确保在不同环境中的兼容性
- 给用户更多选择

### 决策 3: 技能调用方式

**选项**：
1. 使用 `Skill` 工具
2. 使用手动说明
3. 使用子代理
4. 不包含调用说明

**推荐**：选项 1（使用 `Skill` 工具）

**理由**：
- 与 Superpowers 的方式保持一致
- 确保调用方式标准化

## 成功标准

1. ✅ Brainstorming 技能在 iFlow CLI 中可用
2. ✅ 技能遵循 iFlow CLI 的格式规范
3. ✅ 技能与 iFlow CLI 的工具集兼容
4. ✅ 流程图正确显示或提供备选方案
5. ✅ Bash 命令适配为 PowerShell/Git Bash
6. ✅ 技能可以正确调用 writing-plans 技能
7. ✅ 至少有 2 个测试用例
8. ✅ 有清晰的使用说明和示例

## 风险和缓解措施

### 风险 1: 流程图格式不兼容

**缓解措施**：
- 提供文字描述作为备选
- 在文档中说明支持的格式

### 风险 2: Bash 命令在 Windows 上不工作

**缓解措施**：
- 提供 PowerShell 和 Git Bash 两种版本
- 测试两种环境中的命令执行

### 风险 3: 子代理调用失败

**缓解措施**：
- 确保写作计划技能已经移植
- 测试技能调用链

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
- [Superpowers Brainstorming 技能](../../../superpowers/skills/brainstorming/SKILL.md)
- [Phase 1 TDD 技能移植计划](../01-core-skills-tdd-debugging/01-PLAN-TDD-SKILL.md)