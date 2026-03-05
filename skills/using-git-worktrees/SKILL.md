---
name: using-git-worktrees
description: 在开始需要隔离工作空间的特性工作或执行实施计划之前使用 - 创建具有智能目录选择和安全验证的隔离 git worktree
version: 1.0.0
author: iFlow CLI
category: Execution
tags: git,workflow,isolation
---

# Using Git Worktrees

## 概述

Git worktrees 创建隔离的工作空间，共享同一个仓库，允许同时在多个分支上工作而无需切换。

**核心原则**: 系统化的目录选择 + 安全验证 = 可靠的隔离。

**开始时声明**: "我正在使用 using-git-worktrees 技能来设置隔离的工作空间。"

## 工具映射

本技能主要使用 Git 命令，但也可能使用以下 iFlow CLI 工具：

- `read_file` - 用于读取 CLAUDE.md 文件以检查工作树目录偏好
- `write_file` - 用于更新 .gitignore 文件（如果需要）
- `run_shell_command` - 用于执行 PowerShell 或 Git Bash 命令

## 目录选择过程

按照以下优先级顺序：

### 1. 检查现有目录

```powershell
# 按优先级检查
Test-Path .worktrees 2>$null    # 首选（隐藏）
Test-Path worktrees 2>$null     # 替代方案
```

**如果找到**: 使用该目录。如果两者都存在，`.worktrees` 优先。

**Git Bash 版本**:
```bash
# 按优先级检查
ls -d .worktrees 2>/dev/null     # 首选（隐藏）
ls -d worktrees 2>/dev/null      # 替代方案
```

### 2. 检查 CLAUDE.md

```powershell
# PowerShell
Select-String -Path "CLAUDE.md" -Pattern "worktree.*director" -CaseSensitive:$false 2>$null
```

**如果指定了偏好**: 使用它，无需询问。

**Git Bash 版本**:
```bash
grep -i "worktree.*director" CLAUDE.md 2>/dev/null
```

### 3. 询问用户

如果没有目录存在且没有 CLAUDE.md 偏好：

```
未找到 worktree 目录。我应该在哪里创建 worktree？

1. .worktrees/ (项目本地，隐藏)
2. ~/.config/superpowers/worktrees/<project-name>/ (全局位置)

您更喜欢哪个？
```

## 安全性验证

### 对于项目本地目录（.worktrees 或 worktrees）

**必须在创建 worktree 之前验证目录被忽略**:

```powershell
# PowerShell
git check-ignore -q .worktrees 2>$null -or git check-ignore -q worktrees 2>$null
```

**Git Bash 版本**:
```bash
git check-ignore -q .worktrees 2>/dev/null || git check-ignore -q worktrees 2>/dev/null
```

**如果未被忽略**:

根据 Jesse 的规则"立即修复问题":
1. 添加适当的行到 .gitignore
2. 提交更改
3. 继续创建 worktree

**为什么关键**: 防止意外将 worktree 内容提交到仓库。

### 对于全局目录（~/.config/superpowers/worktrees）

无需 .gitignore 验证 - 完全在项目外部。

## 创建步骤

### 1. 检测项目名称

```powershell
# PowerShell
$project = Split-Path -Leaf (git rev-parse --show-toplevel)
```

**Git Bash 版本**:
```bash
project=$(basename "$(git rev-parse --show-toplevel)")
```

### 2. 创建 Worktree

```powershell
# PowerShell
# 确定完整路径
switch ($LOCATION) {
    ".worktrees" {
        $path = "$LOCATION/$BRANCH_NAME"
    }
    "worktrees" {
        $path = "$LOCATION/$BRANCH_NAME"
    }
    "~/.config/superpowers/worktrees/*" {
        $path = "~/.config/superpowers/worktrees/$project/$BRANCH_NAME"
    }
}

# 创建带有新分支的 worktree
git worktree add $path -b $BRANCH_NAME
cd $path
```

**Git Bash 版本**:
```bash
# 确定完整路径
case $LOCATION in
  .worktrees|worktrees)
    path="$LOCATION/$BRANCH_NAME"
    ;;
  ~/.config/superpowers/worktrees/*)
    path="~/.config/superpowers/worktrees/$project/$BRANCH_NAME"
    ;;
esac

# 创建带有新分支的 worktree
git worktree add "$path" -b "$BRANCH_NAME"
cd "$path"
```

### 3. 运行项目设置

自动检测并运行适当的设置：

```powershell
# PowerShell
# Node.js
if (Test-Path package.json) { npm install }

# Rust
if (Test-Path Cargo.toml) { cargo build }

# Python
if (Test-Path requirements.txt) { pip install -r requirements.txt }
if (Test-Path pyproject.toml) { poetry install }

# Go
if (Test-Path go.mod) { go mod download }
```

**Git Bash 版本**:
```bash
# Node.js
if [ -f package.json ]; then npm install; fi

# Rust
if [ -f Cargo.toml ]; then cargo build; fi

# Python
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
if [ -f pyproject.toml ]; then poetry install; fi

# Go
if [ -f go.mod ]; then go mod download; fi
```

### 4. 验证清洁基线

运行测试以确保 worktree 从清洁状态开始：

```powershell
# 示例 - 使用适当的项目命令
npm test
cargo test
pytest
go test ./...
```

**Git Bash 版本**:
```bash
# 示例 - 使用适当的项目命令
npm test
cargo test
pytest
go test ./...
```

**如果测试失败**: 报告失败，询问是否继续还是调查。

**如果测试通过**: 报告就绪。

### 5. 报告位置

```
Worktree 就绪于 <full-path>
测试通过（<N> 测试，0 失败）
准备实现 <feature-name>
```

## 快速参考

| 情况 | 操作 |
|------|------|
| `.worktrees/` 存在 | 使用它（验证被忽略） |
| `worktrees/` 存在 | 使用它（验证被忽略） |
| 两者都存在 | 使用 `.worktrees/` |
| 两者都不存在 | 检查 CLAUDE.md → 询问用户 |
| 目录未被忽略 | 添加到 .gitignore + 提交 |
| 基线测试期间测试失败 | 报告失败 + 询问 |
| 没有 package.json/Cargo.toml | 跳过依赖安装 |

## 常见错误

### 跳过 ignore 验证

- **问题**: Worktree 内容被跟踪，污染 git 状态
- **修复**: 始终在创建项目本地 worktree 之前使用 `git check-ignore`

### 假设目录位置

- **问题**: 创建不一致，违反项目约定
- **修复**: 遵循优先级：现有 > CLAUDE.md > 询问

### 用失败的测试继续

- **问题**: 无法区分新错误和预存在的问题
- **修复**: 报告失败，获取明确的继续许可

### 硬编码设置命令

- **问题**: 在使用不同工具的项目上中断
- **修复**: 从项目文件自动检测（package.json 等）

## 示例工作流

```
你: 我正在使用 using-git-worktrees 技能来设置隔离的工作空间。

[检查 .worktrees/ - 存在]
[验证被忽略 - git check-ignore 确认 .worktrees/ 被忽略]
[创建 worktree: git worktree add .worktrees/auth -b feature/auth]
[运行 npm install]
[运行 npm test - 47 通过]

Worktree 就绪于 /Users/jesse/myproject/.worktrees/auth
测试通过（47 测试，0 失败）
准备实现 auth 特性
```

**PowerShell 示例**:
```powershell
你: 我正在使用 using-git-worktrees 技能来设置隔离的工作空间。

# 检查目录
$worktreeDir = ".worktrees"
if (-not (Test-Path $worktreeDir)) {
    # 询问用户选择
    $choice = Read-Host "未找到 worktree 目录。选择位置: 1) .worktrees/ (项目本地), 2) ~/.config/superpowers/worktrees/$project/"
    # ... 处理选择
}

# 验证被忽略
git check-ignore -q $worktreeDir
if ($LASTEXITCODE -ne 0) {
    # 添加到 .gitignore
    Add-Content .gitignore "`n$worktreeDir"
    git add .gitignore
    git commit -m "Ignore $worktreeDir directory"
}

# 创建 worktree
$branchName = "feature/auth"
git worktree add "$worktreeDir/$branchName" -b $branchName

# 运行设置
if (Test-Path package.json) {
    npm install
    npm test
}

# 报告
Write-Host "Worktree 就绪于 $(Get-Location)"
```

## 警告标志

**从不**:
- 创建 worktree 而不验证它被忽略（项目本地）
- 跳过基线测试验证
- 用失败的测试继续而不询问
- 假设目录位置当有歧义时
- 跳过 CLAUDE.md 检查

**始终**:
- 遵循目录优先级：现有 > CLAUDE.md > 询问
- 验证目录被忽略对于项目本地
- 自动检测并运行项目设置
- 验证清洁的测试基线

## 集成

**被调用者**:
- **brainstorming** (Phase 4) - REQUIRED 当设计被批准且实现紧随其后时
- **subagent-driven-development** - REQUIRED 在执行任何任务之前
- **executing-plans** - REQUIRED 在执行任何任务之前
- 任何需要隔离工作空间的技能

**与...配合**:
- **finishing-a-development-branch** - REQUIRED 在工作完成后清理