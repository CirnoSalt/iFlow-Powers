---
name: executing-plans
description: 在有书面实施计划需要在单独的会话中执行时使用，带有审查检查点
version: 1.0.0
author: iFlow CLI
category: Execution
tags: planning,workflow,execution
---

# Executing Plans

## 概述

加载计划，批判性审查，批量执行任务，在批次之间报告以供审查。

**核心原则**: 批量执行与架构师审查的检查点。

**开始时声明**: "我正在使用 executing-plans 技能来实现此计划。"

## 流程

### Step 1: 加载和审查计划

1. 读取计划文件
2. 批判性审查 - 识别对计划的任何问题或顾虑
3. 如果有顾虑：在开始前向您的合作伙伴提出
4. 如果没有顾虑：创建 TodoWrite 并继续

**工具映射**:
- `Read` → `read_file` - 用于读取计划文件
- `TodoWrite` → `todo_write` - 用于创建待办事项列表

### Step 2: 执行批次

**默认：前 3 个任务**

对于每个任务：
1. 标记为 in_progress
2. 严格按照每个步骤（计划有小的步骤）
3. 按指定运行验证
4. 标记为 completed

**工具映射**:
- `TodoWrite` → `todo_write` - 用于更新任务状态
- `TodoRead` → `todo_read` - 用于读取任务状态

### Step 3: 报告

当批次完成时：
- 显示实现了什么
- 显示验证输出
- 说："准备好接受反馈。"

### Step 4: 继续

基于反馈：
- 应用更改（如果需要）
- 执行下一批次
- 重复直到完成

### Step 5: 完成开发

所有任务完成并验证后：
- 声明："我正在使用 finishing-a-development-branch 技能来完成这项工作。"
- **必需子技能**：使用 `Skill` 工具调用 finishing-a-development-branch
- 遵循该技能来验证测试、呈现选项、执行选择

**工具映射**:
- `Skill` → `Skill` - 用于调用 finishing-a-development-branch 子技能

## 何时停止并寻求帮助

**立即停止执行，当**:
- 在批次中间遇到阻塞（缺少依赖、测试失败、指令不清楚）
- 计划有严重的缺口阻止开始
- 您不理解指令
- 验证反复失败

**请求澄清而不是猜测。**

## 何时重新审视早期步骤

**返回到审查（Step 1），当**:
- 合作伙伴根据您的反馈更新计划
- 根本方法需要重新思考

**不要强行通过阻塞** - 停止并询问。

## 记住

- 首先批判性审查计划
- 严格按照计划步骤
- 不要跳过验证步骤
- 计划说明时引用技能
- 批次之间：仅报告并等待
- 阻塞时停止，不要猜测
- 没有明确的用户同意，绝不要在 main/master 分支上开始实现

## 集成

**必需的工作流技能**:
- **using-git-worktrees** - REQUIRED：在开始前设置隔离工作空间
- **writing-plans** - 创建此技能执行的计划
- **finishing-a-development-branch** - 所有任务完成后完成开发

**子技能调用**:
- 使用 `Skill` 工具调用 finishing-a-development-branch
- 在调用时提供技能名称和参数