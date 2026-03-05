# Plan 01: 移植 Using Git Worktrees 技能

## 技能分析

### Superpowers 技能概述

**技能名称**: using-git-worktrees
**技能描述**: 在开始需要隔离工作空间的特性工作或执行实施计划之前使用 - 创建具有智能目录选择和安全验证的隔离 git worktree

**核心原则**: 系统化的目录选择 + 安全验证 = 可靠的隔离

**关键功能**:
1. 目录选择优先级（现有 > CLAUDE.md > 用户选择）
2. 安全性验证（检查 git ignore）
3. 项目设置自动检测和运行
4. 清洁基线验证

### iFlow CLI 兼容性分析

#### 工具使用分析

| Superpowers 工具 | iFlow CLI 工具 | 兼容性 | 备注 |
|------------------|----------------|--------|------|
| `Bash` | `run_shell_command` | ✅ 完全兼容 | 需要适配 Windows 环境 |
| `Read` | `read_file` | ✅ 完全兼容 | 用于读取 CLAUDE.md |
| `Write` | `write_file` | ✅ 完全兼容 | 用于更新 .gitignore |

#### 子代理使用分析

**子代理使用**: 无

#### 特殊功能分析

1. **目录选择优先级**:
   - 检查 `.worktrees` 或 `worktrees` 目录
   - 检查 CLAUDE.md 中的偏好设置
   - 询问用户选择

2. **安全性验证**:
   - 对于项目本地目录，检查是否被 git ignore
   - 如果未忽略，自动添加到 .gitignore 并提交

3. **项目设置**:
   - 自动检测并运行项目设置（npm install, cargo build, 等）
   - 支持多种项目类型

4. **基线验证**:
   - 运行测试以确保 worktree 从清洁状态开始
   - 如果测试失败，报告失败并询问是否继续

## 移植策略

### 1. 技能格式

- ✅ 使用 iFlow CLI 的技能格式（SKILL.md + YAML frontmatter）
- ✅ 包含必需的 YAML 字段（name, description, version, author, category, tags）
- ✅ 使用标准 Markdown 格式

### 2. 工具映射

- ✅ `Bash` → `run_shell_command`
- ✅ `Read` → `read_file`
- ✅ `Write` → `write_file`

### 3. 跨平台兼容性

- ⚠️ 需要处理 Windows 和 Unix 的差异
- ✅ 提供 PowerShell 和 Git Bash 两种版本的命令
- ✅ 使用 `git` 命令（跨平台）
- ✅ 使用 Unix 风格路径（`/`）

### 4. 目录选择逻辑

- ✅ 保留 Superpowers 的目录选择优先级
- ✅ 提供两种位置选项（项目本地 vs 全局）
- ✅ 检查现有目录和 CLAUDE.md 偏好设置

### 5. 安全性验证

- ✅ 保留安全性验证机制
- ✅ 检查 git ignore
- ✅ 自动更新 .gitignore

### 6. 项目设置

- ✅ 保留项目设置自动检测
- ✅ 支持多种项目类型（Node.js, Rust, Python, Go）
- ✅ 适配 Windows 环境

### 7. 基线验证

- ✅ 保留基线验证机制
- ✅ 运行项目测试
- ✅ 报告失败并询问

## 实施步骤

### Step 1: 创建技能文件结构

**目录结构**:
```
skills/using-git-worktrees/
├── SKILL.md
└── examples/
    └── README.md
```

### Step 2: 编写 SKILL.md

**内容**:
1. YAML frontmatter
2. 概述
3. 目录选择过程
4. 安全性验证
5. 创建步骤
6. 快速参考
7. 常见错误
8. 示例工作流
9. 警告标志
10. 集成信息

**YAML frontmatter**:
```yaml
---
name: using-git-worktrees
description: 在开始需要隔离工作空间的特性工作或执行实施计划之前使用 - 创建具有智能目录选择和安全验证的隔离 git worktree
version: 1.0.0
author: iFlow CLI
category: Execution
tags: git,workflow,isolation
---
```

### Step 3: 编写示例文档

**内容**:
1. 简单示例（使用 .worktrees 目录）
2. 复杂示例（使用全局目录）
3. 特殊场景示例（安全性验证）

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

### 决策 1: PowerShell vs Bash 命令

**问题**: Superpowers 使用 Bash 命令，iFlow CLI 运行在 Windows 上

**选项**:
1. 只使用 PowerShell 命令
2. 只使用 Git Bash 命令
3. 提供两种版本

**决策**: 提供两种版本（PowerShell 和 Git Bash）

**理由**: 确保在不同环境中的兼容性，给用户更多选择

### 决策 2: 目录选择默认值

**问题**: 如果没有现有目录和 CLAUDE.md 偏好设置，应该选择哪个目录？

**选项**:
1. 默认使用 `.worktrees/`
2. 默认使用全局目录
3. 询问用户选择

**决策**: 询问用户选择

**理由**: 遵循 Superpowers 的原始设计，让用户做决定

### 决策 3: 自动更新 .gitignore

**问题**: 如果目录未被 git ignore，应该自动更新还是询问用户？

**选项**:
1. 自动更新并提交
2. 询问用户是否更新
3. 报告错误并停止

**决策**: 自动更新并提交（遵循 Jesse 的规则）

**理由**: Superpowers 的原始设计，立即修复问题

### 决策 4: 测试失败处理

**问题**: 如果基线测试失败，应该如何处理？

**选项**:
1. 停止并询问用户是否继续
2. 继续但不报告
3. 报告错误并自动停止

**决策**: 停止并询问用户是否继续

**理由**: Superpowers 的原始设计，让用户决定

## 成功标准

1. ✅ using-git-worktrees 技能在 iFlow CLI 中可用
2. ✅ 技能遵循 iFlow CLI 的格式规范
3. ✅ 技能与 iFlow CLI 的工具集兼容
4. ✅ 支持目录选择优先级
5. ✅ 支持安全性验证
6. ✅ 支持项目设置自动检测
7. ✅ 支持基线验证
8. ✅ 至少有 2 个测试用例
9. ✅ 有清晰的使用说明
10. ✅ 支持跨平台兼容性

## 风险和缓解措施

### 风险 1: Windows 兼容性问题

**描述**: Git worktree 在 Windows 上可能存在问题

**缓解措施**:
- 在测试中验证 Windows 兼容性
- 提供详细的错误处理
- 提供替代方案

### 风险 2: 权限问题

**描述**: 在 Windows 上可能没有足够的权限创建目录或修改 .gitignore

**缓解措施**:
- 提供清晰的错误消息
- 建议用户手动操作
- 提供详细的故障排除指南

### 风险 3: Git 版本兼容性

**描述**: 某些 Git 版本可能不支持 worktree 命令

**缓解措施**:
- 在文档中说明最低 Git 版本要求
- 提供版本检查
- 提供替代方案

## 时间估算

- **Step 1**: 5 分钟
- **Step 2**: 45 分钟
- **Step 3**: 15 分钟
- **Step 4**: 20 分钟
- **Step 5**: 15 分钟

**总计**: 约 100 分钟（1 小时 40 分钟）

## 文件清单

### 技能文件

- `skills/using-git-worktrees/SKILL.md`
- `skills/using-git-worktrees/examples/README.md`

### 测试文件

- `skills/using-git-worktrees/tests/test-basic.ps1`

## 相关文档

- [Phase 3 Context](./03-CONTEXT.md)
- [Superpowers using-git-worktrees 技能](../../../superpowers/skills/using-git-worktrees/SKILL.md)
- [Phase 1 Context](../01-core-skills-tdd-debugging/01-CONTEXT.md)
- [Phase 2 Context](../02-core-skills-brainstorming-planning/02-CONTEXT.md)