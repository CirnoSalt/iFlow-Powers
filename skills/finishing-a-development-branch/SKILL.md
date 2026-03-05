---
name: finishing-a-development-branch
description: 在实现完成、所有测试通过，并且需要决定如何集成工作时使用 - 通过呈现结构化选项来指导开发工作的完成
version: 1.0.0
author: iFlow CLI
category: Execution
tags: git,workflow,completion
---

# Finishing a Development Branch

## 概述

通过呈现清晰的选项并处理选定的工作流来指导开发工作的完成。

**核心原则**: 验证测试 → 呈现选项 → 执行选择 → 清理。

**开始时声明**: "我正在使用 finishing-a-development-branch 技能来完成这项工作。"

## 流程

### Step 1: 验证测试

**在呈现选项之前，验证测试通过**:

```powershell
# PowerShell
# 运行项目的测试套件
npm test  # 或 cargo test / pytest / go test ./...
```

**Git Bash 版本**:
```bash
# 运行项目的测试套件
npm test  # 或 cargo test / pytest / go test ./...
```

**如果测试失败**:
```
测试失败（<N> 个失败）。必须先修复才能完成：

[显示失败信息]

在测试通过之前无法继续合并/PR。
```

停止。不要继续到 Step 2。

**如果测试通过**: 继续到 Step 2。

### Step 2: 确定基础分支

```powershell
# PowerShell
# 尝试常见的基础分支
$baseBranch = $null
$mainBase = git merge-base HEAD main 2>$null
if ($mainBase) {
    $baseBranch = "main"
} else {
    $masterBase = git merge-base HEAD master 2>$null
    if ($masterBase) {
        $baseBranch = "master"
    }
}

if (-not $baseBranch) {
    Write-Host "无法自动检测基础分支，请指定："
    $baseBranch = Read-Host "基础分支（main/master）"
}
```

**Git Bash 版本**:
```bash
# 尝试常见的基础分支
BASE_SHA=$(git merge-base HEAD main 2>/dev/null)
if [ -z "$BASE_SHA" ]; then
    BASE_SHA=$(git merge-base HEAD master 2>/dev/null)
fi
```

或者询问："此分支从 main 分离 - 是否正确？"

### Step 3: 呈现选项

精确呈现以下 4 个选项：

```
实现完成。您想要做什么？

1. 合并到 <base-branch> 本地
2. 推送并创建 Pull Request
3. 保持分支原样（我稍后处理）
4. 丢弃此工作

选择哪个选项？
```

**不要添加解释** - 保持选项简洁。

### Step 4: 执行选择

#### 选项 1: 本地合并

```powershell
# PowerShell
# 切换到基础分支
git checkout $baseBranch

# 拉取最新
git pull

# 合并特性分支
$featureBranch = git branch --show-current
git merge $featureBranch

# 验证合并结果的测试
<test command>

# 如果测试通过
git branch -d $featureBranch
```

然后：清理 worktree（Step 5）

**Git Bash 版本**:
```bash
# 切换到基础分支
git checkout <base-branch>

# 拉取最新
git pull

# 合并特性分支
git merge <feature-branch>

# 验证合并结果的测试
<test command>

# 如果测试通过
git branch -d <feature-branch>
```

#### 选项 2: 推送并创建 PR

```powershell
# PowerShell
# 推送分支
git push -u origin $featureBranch

# 创建 PR
gh pr create --title "<title>" --body @"
## 摘要
<2-3 个项目符号，描述更改内容>

## 测试计划
- [ ] <验证步骤>
"@
```

然后：清理 worktree（Step 5）

**Git Bash 版本**:
```bash
# 推送分支
git push -u origin <feature-branch>

# 创建 PR
gh pr create --title "<title>" --body '## 摘要
<2-3 个项目符号，描述更改内容>

## 测试计划
- [ ] <验证步骤>'
```

#### 选项 3: 保持原样

报告："保持分支 <name>。Worktree 保留在 <path>。"

**不要清理 worktree。**

#### 选项 4: 丢弃

**首先确认**:
```
这将永久删除：
- 分支 <name>
- 所有提交：<commit-list>
- Worktree 位于 <path>

输入 'discard' 以确认。
```

等待确切确认。

如果确认：
```powershell
# PowerShell
git checkout $baseBranch
git branch -D $featureBranch
```

然后：清理 worktree（Step 5）

**Git Bash 版本**:
```bash
git checkout <base-branch>
git branch -D <feature-branch>
```

### Step 5: 清理 Worktree

**对于选项 1、2、4**:

检查是否在 worktree 中：
```powershell
# PowerShell
$currentBranch = git branch --show-current
$worktrees = git worktree list
if ($worktrees -match $currentBranch) {
    # 清理 worktree
    git worktree remove .
}
```

**Git Bash 版本**:
```bash
CURRENT_BRANCH=$(git branch --show-current)
if git worktree list | grep -q "$CURRENT_BRANCH"; then
    git worktree remove .
fi
```

**对于选项 3**: 保留 worktree。

## 快速参考

| 选项 | 合并 | 推送 | 保留 Worktree | 清理分支 |
|------|------|------|---------------|----------|
| 1. 本地合并 | ✓ | - | - | ✓ |
| 2. 创建 PR | - | ✓ | ✓ | - |
| 3. 保持原样 | - | - | ✓ | - |
| 4. 丢弃 | - | - | - | ✓（强制）|

## 常见错误

### 跳过测试验证

- **问题**: 合并有问题的代码，创建失败的 PR
- **修复**: 在提供选项之前始终验证测试

### 开放式问题

- **问题**: "我应该接下来做什么？" → 模糊
- **修复**: 呈现精确的 4 个结构化选项

### 自动 worktree 清理

- **问题**: 在可能需要时删除 worktree（选项 2、3）
- **修复**: 仅清理选项 1 和 4

### 丢弃时没有确认

- **问题**: 意外删除工作
- **修复**: 要求输入 "discard" 确认

## 警告标志

**从不**:
- 用失败的测试继续
- 在没有验证测试的情况下合并
- 没有确认就删除工作
- 没有明确请求时强制推送

**始终**:
- 在提供选项之前验证测试
- 呈现精确的 4 个选项
- 获取选项 4 的输入确认
- 仅清理选项 1 & 4 的 worktree

## 集成

**被调用者**:
- **subagent-driven-development** (Step 7) - 在所有任务完成后
- **executing-plans** (Step 5) - 在所有批次完成后

**与...配合**:
- **using-git-worktrees** - 清理由该技能创建的 worktree