# Plan 03: 移植 Executing Plans 技能

## 技能分析

### Superpowers 技能概述

**技能名称**: executing-plans
**技能描述**: 在有书面实施计划需要在单独的会话中执行时使用，带有审查检查点

**核心原则**: 批量执行与架构师审查的检查点

**关键功能**:
1. 加载和审查计划
2. 批量执行任务（默认 3 个）
3. 在批次之间报告并等待反馈
4. 应用反馈并继续
5. 完成开发

### iFlow CLI 兼容性分析

#### 工具使用分析

| Superpowers 工具 | iFlow CLI 工具 | 兼容性 | 备注 |
|------------------|----------------|--------|------|
| `Read` | `read_file` | ✅ 完全兼容 | 用于读取计划文件 |
| `TodoWrite` | `todo_write` | ✅ 完全兼容 | 用于创建待办事项列表 |
| `TodoRead` | `todo_read` | ✅ 完全兼容 | 用于读取待办事项列表 |
| `Skill` | `Skill` | ✅ 完全兼容 | 用于调用子技能 |

#### 子代理使用分析

**子代理使用**: 无

#### 子技能使用分析

**依赖的子技能**:
- `using-git-worktrees` - REQUIRED: 设置隔离工作空间
- `finishing-a-development-branch` - REQUIRED: 完成开发工作

**兼容性**:
- ✅ 这些子技能将在 Phase 3 中移植
- ✅ 可以使用 Skill 工具调用

#### 特殊功能分析

1. **计划加载和审查**:
   - 读取计划文件
   - 批判性审查计划
   - 识别问题或顾虑

2. **批量执行**:
   - 默认执行前 3 个任务
   - 每个任务标记为 in_progress
   - 严格按照计划步骤执行
   - 运行指定的验证

3. **报告和反馈**:
   - 批次完成时报告实现内容
   - 显示验证输出
   - 等待反馈

4. **继续执行**:
   - 根据反馈应用更改
   - 执行下一批次
   - 重复直到完成

5. **完成开发**:
   - 使用 finishing-a-development-branch 技能

6. **停止和寻求帮助**:
   - 遇到阻塞时立即停止
   - 询问而不是猜测

7. **重新审视早期步骤**:
   - 根据反馈返回审查
   - 不要强行通过阻塞

## 移植策略

### 1. 技能格式

- ✅ 使用 iFlow CLI 的技能格式（SKILL.md + YAML frontmatter）
- ✅ 包含必需的 YAML 字段（name, description, version, author, category, tags）
- ✅ 使用标准 Markdown 格式

### 2. 工具映射

- ✅ `Read` → `read_file`
- ✅ `TodoWrite` → `todo_write`
- ✅ `TodoRead` → `todo_read`
- ✅ `Skill` → `Skill`

### 3. 子技能集成

- ✅ 使用 Skill 工具调用 using-git-worktrees
- ✅ 使用 Skill 工具调用 finishing-a-development-branch
- ✅ 在文档中说明子技能的调用方式

### 4. 计划文件处理

- ✅ 使用 read_file 工具读取计划文件
- ✅ 保留批判性审查机制
- ✅ 支持识别问题和顾虑

### 5. 批量执行

- ✅ 保留批量执行机制（默认 3 个任务）
- ✅ 使用 todo_write 工具标记任务状态
- ✅ 严格遵循计划步骤
- ✅ 不跳过验证步骤

### 6. 报告和反馈

- ✅ 保留报告机制
- ✅ 显示实现内容和验证输出
- ✅ 等待反馈（不自动继续）

### 7. 停止和寻求帮助

- ✅ 保留停止和寻求帮助机制
- ✅ 遇到阻塞时立即停止
- ✅ 询问而不是猜测

## 实施步骤

### Step 1: 创建技能文件结构

**目录结构**:
```
skills/executing-plans/
├── SKILL.md
└── examples/
    └── README.md
```

### Step 2: 编写 SKILL.md

**内容**:
1. YAML frontmatter
2. 概述
3. 流程（5 个步骤）
4. 何时停止和寻求帮助
5. 何时重新审视早期步骤
6. 记住
7. 集成信息

**YAML frontmatter**:
```yaml
---
name: executing-plans
description: 在有书面实施计划需要在单独的会话中执行时使用，带有审查检查点
version: 1.0.0
author: iFlow CLI
category: Execution
tags: planning,workflow,execution
---
```

### Step 3: 编写示例文档

**内容**:
1. 简单示例（执行简单计划）
2. 复杂示例（执行复杂计划，包含反馈）
3. 特殊场景示例（遇到阻塞）

### Step 4: 创建测试脚本

**测试内容**:
1. 文件存在性测试
2. YAML frontmatter 测试
3. 必填字段测试
4. 必需章节测试
5. 工具映射测试
6. 示例测试
7. 子技能调用测试

### Step 5: 运行测试

- 运行测试脚本
- 修复发现的问题
- 确保所有测试通过

## 关键决策点

### 决策 1: 批量大小

**问题**: 批量大小应该是多少？

**选项**:
1. 固定为 3 个任务
2. 可配置（允许用户调整）
3. 根据任务复杂度动态调整

**决策**: 固定为 3 个任务（默认值）

**理由**: Superpowers 的原始设计，提供一致性和可预测性

### 决策 2: 计划文件格式

**问题**: 计划文件应该使用什么格式？

**选项**:
1. Markdown 格式（Superpowers 原始格式）
2. JSON 格式
3. YAML 格式

**决策**: Markdown 格式

**理由**: Superpowers 的原始设计，与 writing-plans 技能兼容

### 决策 3: 验证失败处理

**问题**: 如果验证失败，应该如何处理？

**选项**:
1. 停止并询问用户
2. 继续但警告用户
3. 自动尝试修复

**决策**: 停止并询问用户

**理由**: Superpowers 的原始设计，防止执行有问题的代码

### 决策 4: 子技能调用方式

**问题**: 应该如何调用子技能？

**选项**:
1. 使用 Skill 工具
2. 直接在流程中说明
3. 提供脚本模板

**决策**: 使用 Skill 工具

**理由**: iFlow CLI 的标准方式，与其他技能一致

## 成功标准

1. ✅ executing-plans 技能在 iFlow CLI 中可用
2. ✅ 技能遵循 iFlow CLI 的格式规范
3. ✅ 技能与 iFlow CLI 的工具集兼容
4. ✅ 支持计划加载和审查
5. ✅ 支持批量执行（默认 3 个任务）
6. ✅ 支持报告和反馈机制
7. ✅ 支持停止和寻求帮助
8. ✅ 支持子技能调用
9. ✅ 至少有 2 个测试用例
10. ✅ 有清晰的使用说明

## 风险和缓解措施

### 风险 1: 计划文件格式兼容性

**描述**: 用户可能使用不同的计划文件格式

**缓解措施**:
- 在文档中说明支持的计划格式
- 提供计划文件示例
- 支持常见的 Markdown 格式

### 风险 2: 批量执行失败

**描述**: 批量执行中某个任务可能失败

**缓解措施**:
- 提供详细的错误处理
- 支持从失败点恢复
- 提供手动恢复指南

### 风险 3: 子技能未就绪

**描述**: 依赖的子技能可能未正确移植

**缓解措施**:
- 确保子技能在 Phase 3 中移植
- 提供临时手动执行方式
- 在文档中说明依赖关系

## 时间估算

- **Step 1**: 5 分钟
- **Step 2**: 35 分钟
- **Step 3**: 15 分钟
- **Step 4**: 20 分钟
- **Step 5**: 10 分钟

**总计**: 约 85 分钟（1 小时 25 分钟）

## 文件清单

### 技能文件

- `skills/executing-plans/SKILL.md`
- `skills/executing-plans/examples/README.md`

### 测试文件

- `skills/executing-plans/tests/test-basic.ps1`

## 相关文档

- [Phase 3 Context](./03-CONTEXT.md)
- [Superpowers executing-plans 技能](../../../superpowers/skills/executing-plans/SKILL.md)
- [Phase 1 Context](../01-core-skills-tdd-debugging/01-CONTEXT.md)
- [Phase 2 Context](../02-core-skills-brainstorming-planning/02-CONTEXT.md)
- [using-git-worktrees 技能移植计划](./03-PLAN-USING-GIT-WORKTREES-SKILL.md)
- [finishing-a-development-branch 技能移植计划](./03-PLAN-FINISHING-A-DEVELOPMENT-BRANCH-SKILL.md)