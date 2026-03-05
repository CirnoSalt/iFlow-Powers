# Plan 02: 移植 Finishing a Development Branch 技能

## 技能分析

### Superpowers 技能概述

**技能名称**: finishing-a-development-branch
**技能描述**: 在实现完成、所有测试通过，并且需要决定如何集成工作时使用 - 通过呈现结构化选项来指导开发工作的完成

**核心原则**: 验证测试 → 呈现选项 → 执行选择 → 清理

**关键功能**:
1. 验证测试通过
2. 确定基础分支
3. 呈现 4 个选项（合并本地、创建 PR、保持、丢弃）
4. 执行选择的选项
5. 清理 worktree

### iFlow CLI 兼容性分析

#### 工具使用分析

| Superpowers 工具 | iFlow CLI 工具 | 兼容性 | 备注 |
|------------------|----------------|--------|------|
| `Bash` | `run_shell_command` | ✅ 完全兼容 | 需要适配 Windows 环境 |

#### 子代理使用分析

**子代理使用**: 无

#### 特殊功能分析

1. **测试验证**:
   - 在呈现选项之前验证测试通过
   - 如果测试失败，停止并报告
   - 运行项目测试套件

2. **基础分支检测**:
   - 尝试常见的基础分支（main, master）
   - 使用 `git merge-base` 检测

3. **选项呈现**:
   - 精确呈现 4 个选项
   - 不添加解释
   - 简洁明了

4. **选项执行**:
   - 选项 1: 合并到基础分支并清理 worktree
   - 选项 2: 推送并创建 PR，保留 worktree
   - 选项 3: 保持分支，保留 worktree
   - 选项 4: 丢弃工作，需要确认

5. **Worktree 清理**:
   - 仅对选项 1、2、4 清理 worktree
   - 检查是否在 worktree 中
   - 使用 `git worktree remove` 清理

## 移植策略

### 1. 技能格式

- ✅ 使用 iFlow CLI 的技能格式（SKILL.md + YAML frontmatter）
- ✅ 包含必需的 YAML 字段（name, description, version, author, category, tags）
- ✅ 使用标准 Markdown 格式

### 2. 工具映射

- ✅ `Bash` → `run_shell_command`

### 3. 跨平台兼容性

- ⚠️ 需要处理 Windows 和 Unix 的差异
- ✅ 提供 PowerShell 和 Git Bash 两种版本的命令
- ✅ 使用 `git` 命令（跨平台）
- ✅ 使用 Unix 风格路径（`/`）

### 4. 测试验证

- ✅ 保留测试验证机制
- ✅ 支持多种测试命令（npm test, cargo test, pytest, go test）
- ✅ 报告失败并停止

### 5. 基础分支检测

- ✅ 保留基础分支检测机制
- ✅ 支持常见的基础分支（main, master）
- ✅ 使用 `git merge-base` 检测

### 6. 选项呈现

- ✅ 保留精确的 4 个选项
- ✅ 简洁明了，不添加解释

### 7. 选项执行

- ✅ 保留选项执行机制
- ✅ 正确处理每个选项
- ✅ 对于选项 4 需要明确的确认

### 8. Worktree 清理

- ✅ 保留 worktree 清理机制
- ✅ 检查是否在 worktree 中
- ✅ 仅对选项 1、2、4 清理 worktree

## 实施步骤

### Step 1: 创建技能文件结构

**目录结构**:
```
skills/finishing-a-development-branch/
├── SKILL.md
└── examples/
    └── README.md
```

### Step 2: 编写 SKILL.md

**内容**:
1. YAML frontmatter
2. 概述
3. 流程（5 个步骤）
4. 快速参考
5. 常见错误
6. 警告标志
7. 集成信息

**YAML frontmatter**:
```yaml
---
name: finishing-a-development-branch
description: 在实现完成、所有测试通过，并且需要决定如何集成工作时使用 - 通过呈现结构化选项来指导开发工作的完成
version: 1.0.0
author: iFlow CLI
category: Execution
tags: git,workflow,completion
---
```

### Step 3: 编写示例文档

**内容**:
1. 简单示例（合并本地）
2. 复杂示例（创建 PR）
3. 特殊场景示例（丢弃工作）

### Step 4: 创建测试脚本

**测试内容**:
1. 文件存在性测试
2. YAML frontmatter 测试
3. 必填字段测试
4. 必需章节测试
5. 工具映射测试
6. 示例测试
7. 跨平台兼容性测试

### Step 5: 运行测试

- 运行测试脚本
- 修复发现的问题
- 确保所有测试通过

## 关键决策点

### 决策 1: 选项 4 确认方式

**问题**: 选项 4（丢弃工作）需要确认，应该如何确认？

**选项**:
1. 要求用户输入 "discard" 确认
2. 要求用户输入 "yes" 确认
3. 提供一个交互式提示

**决策**: 要求用户输入 "discard" 确认

**理由**: Superpowers 的原始设计，明确确认防止误操作

### 决策 2: 测试命令检测

**问题**: 如何检测应该使用哪个测试命令？

**选项**:
1. 自动检测（检查 package.json, Cargo.toml, 等）
2. 要求用户提供测试命令
3. 使用通用命令（npm test）

**决策**: 自动检测

**理由**: Superpowers 的原始设计，支持多种项目类型

### 决策 3: Worktree 清理时机

**问题**: 应该在什么时候清理 worktree？

**选项**:
1. 在每个选项执行后立即清理
2. 在用户确认后再清理
3. 在技能结束时清理

**决策**: 在选项执行后清理（但不是立即）

**理由**: Superpowers 的原始设计，在选项执行完成后清理，但对某些选项（2 和 3）保留 worktree

### 决策 4: 测试失败后的行为

**问题**: 如果测试失败，应该如何处理？

**选项**:
1. 停止并要求用户修复
2. 继续但警告用户
3. 自动尝试修复

**决策**: 停止并要求用户修复

**理由**: Superpowers 的原始设计，防止合并有问题的代码

## 成功标准

1. ✅ finishing-a-development-branch 技能在 iFlow CLI 中可用
2. ✅ 技能遵循 iFlow CLI 的格式规范
3. ✅ 技能与 iFlow CLI 的工具集兼容
4. ✅ 支持测试验证
5. ✅ 支持基础分支检测
6. ✅ 支持 4 个选项的精确呈现
7. ✅ 支持选项执行
8. ✅ 支持 worktree 清理
9. ✅ 至少有 2 个测试用例
10. ✅ 有清晰的使用说明
11. ✅ 支持跨平台兼容性

## 风险和缓解措施

### 风险 1: 测试命令兼容性

**描述**: 不同项目使用不同的测试命令

**缓解措施**:
- 自动检测项目类型
- 提供多种测试命令选项
- 允许用户自定义测试命令

### 风险 2: Worktree 清理问题

**描述**: 在 Windows 上可能无法正确清理 worktree

**缓解措施**:
- 提供详细的错误处理
- 提供手动清理指南
- 验证 worktree 是否在正确的位置

### 风险 3: Git 分支检测问题

**描述**: 可能无法正确检测基础分支

**缓解措施**:
- 提供手动指定基础分支的选项
- 检测常见的基础分支（main, master）
- 提供清晰的错误消息

## 时间估算

- **Step 1**: 5 分钟
- **Step 2**: 40 分钟
- **Step 3**: 15 分钟
- **Step 4**: 20 分钟
- **Step 5**: 10 分钟

**总计**: 约 90 分钟（1 小时 30 分钟）

## 文件清单

### 技能文件

- `skills/finishing-a-development-branch/SKILL.md`
- `skills/finishing-a-development-branch/examples/README.md`

### 测试文件

- `skills/finishing-a-development-branch/tests/test-basic.ps1`

## 相关文档

- [Phase 3 Context](./03-CONTEXT.md)
- [Superpowers finishing-a-development-branch 技能](../../../superpowers/skills/finishing-a-development-branch/SKILL.md)
- [Phase 1 Context](../01-core-skills-tdd-debugging/01-CONTEXT.md)
- [Phase 2 Context](../02-core-skills-brainstorming-planning/02-CONTEXT.md)
- [using-git-worktrees 技能移植计划](./03-PLAN-USING-GIT-WORKTREES-SKILL.md)