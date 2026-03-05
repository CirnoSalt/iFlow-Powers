# Phase 5 Plan 02: 使用指南编写

## 文档信息

- **版本**: 1.0.0
- **日期**: 2026-03-05
- **作者**: iFlow CLI
- **状态**: Pending
- **对应需求**: DOC-02, DOC-03

## 概述

### 目标

编写实用的使用指南，帮助用户快速上手并充分利用 Superpowers 技能。

### 工作范围

1. 创建快速开始指南
2. 收集和整理技能使用示例
3. 编写最佳实践指南
4. 创建常见问题解答

### 成功标准

- [ ] 快速开始指南可在 5 分钟内完成
- [ ] 所有示例都可运行
- [ ] 最佳实践可操作
- [ ] 覆盖所有技能
- [ ] 覆盖所有常见场景

## 任务分解

### 任务 2.1: 创建快速开始指南

**优先级**: 高
**预计时间**: 30 分钟

**目标**: 创建一个简洁的快速开始指南，帮助用户在 5 分钟内上手

**步骤**:

1. **确定快速开始的内容**
   - [ ] 前置要求
   - [ ] 安装步骤
   - [ ] 第一个示例
   - [ ] 下一步

2. **编写快速开始指南**
   - [ ] 使用简洁的语言
   - [ ] 提供可复制粘贴的命令
   - [ ] 提供预期的输出
   - [ ] 添加提示和警告

3. **测试快速开始指南**
   - [ ] 按照指南执行
   - [ ] 验证每个步骤
   - [ ] 修正问题

**验收标准**:
- 可以在 5 分钟内完成
- 所有步骤都可行
- 不会遇到阻碍

**交付物**:
- `docs/QUICKSTART.md`

---

### 任务 2.2: 收集和整理技能使用示例

**优先级**: 高
**预计时间**: 1 小时

**目标**: 收集和整理所有技能的使用示例，形成示例库

**步骤**:

1. **收集现有示例**
   - [ ] 从 `skills/test-driven-development/examples/README.md` 收集
   - [ ] 从 `skills/systematic-debugging/examples/README.md` 收集
   - [ ] 从 `skills/brainstorming/examples/README.md` 收集
   - [ ] 从 `skills/writing-plans/examples/README.md` 收集
   - [ ] 从 `skills/using-git-worktrees/examples/README.md` 收集
   - [ ] 从 `skills/finishing-a-development-branch/examples/README.md` 收集
   - [ ] 从 `skills/executing-plans/examples/README.md` 收集
   - [ ] 从 `skills/subagent-driven-development/examples/README.md` 收集
   - [ ] 从验证文档收集
   - [ ] 从测试用例收集

2. **组织示例**
   - [ ] 按技能组织
   - [ ] 按难度分级（初级、中级、高级）
   - [ ] 按使用场景分类（日常开发、调试、规划、协作）

3. **增强示例**
   - [ ] 添加详细说明
   - [ ] 添加预期结果
   - [ ] 添加变体示例
   - [ ] 添加常见陷阱

4. **创建示例索引**
   - [ ] 按技能名称索引
   - [ ] 按使用场景索引
   - [ ] 按难度索引

5. **格式化文档**
   - [ ] 使用一致的格式
   - [ ] 添加目录
   - [ ] 添加交叉引用
   - [ ] 添加搜索关键词

**验收标准**:
- 每个技能都有示例
- 每个示例都可运行
- 示例索引完整

**交付物**:
- `docs/EXAMPLES.md`

---

### 任务 2.3: 编写最佳实践指南

**优先级**: 高
**预计时间**: 1 小时

**目标**: 编写最佳实践指南，帮助用户更好地使用技能

**步骤**:

1. **收集最佳实践**
   - [ ] 从 ARCHITECTURE.md 收集最佳实践
   - [ ] 从 INTEGRATION.md 收集最佳实践
   - [ ] 从测试经验总结
   - [ ] 从用户反馈收集

2. **组织最佳实践**
   - [ ] 按技能组织
   - [ ] 按使用场景组织
   - [ ] 按重要性排序（关键、重要、推荐）

3. **为每个最佳实践提供**
   - [ ] 实践描述（是什么）
   - [ ] 使用场景（什么时候用）
   - [ ] 示例代码（怎么用）
   - [ ] 反面示例（不该怎么做）
   - [ ] 为什么有效（原理）

4. **添加常见陷阱**
   - [ ] 描述常见错误
   - [ ] 提供避免方法
   - [ ] 提供修复方法

5. **格式化文档**
   - [ ] 使用清晰的标题
   - [ ] 添加图标或标记（✓、✗、⚠）
   - [ ] 添加目录
   - [ ] 添加交叉引用

**验收标准**:
- 覆盖所有重要场景
- 每个实践都有示例
- 陷阱描述清晰

**交付物**:
- `docs/BEST-PRACTICES.md`

---

### 任务 2.4: 创建常见问题解答

**优先级**: 中
**预计时间**: 30 分钟

**目标**: 创建一个 FAQ 文档，回答用户常见问题

**步骤**:

1. **收集常见问题**
   - [ ] 从 TROUBLESHOOTING.md 收集
   - [ ] 从用户反馈收集
   - [ ] 从测试经验收集
   - [ ] 从 Stack Overflow 等平台收集

2. **组织问题**
   - [ ] 按类别组织（安装、使用、集成、故障排除）
   - [ ] 按频率排序（高频、中频、低频）
   - [ ] 按难度排序（简单、中等、复杂）

3. **为每个问题提供**
   - [ ] 问题描述
   - [ ] 简短回答（一句话）
   - [ ] 详细说明（详细步骤）
   - [ ] 示例代码（如适用）
   - [ ] 相关资源（相关文档或链接）

4. **添加索引**
   - [ ] 按关键词索引
   - [ ] 按类别索引

5. **格式化文档**
   - [ ] 使用问答格式
   - [ ] 添加目录
   - [ ] 添加搜索功能提示
   - [ ] 添加"未找到答案？"部分

**验收标准**:
- 覆盖所有常见问题
- 回答准确清晰
- 索引完整

**交付物**:
- `docs/FAQ.md`

---

## 文档模板

### 快速开始指南模板

```markdown
# Quick Start

Welcome to Superpowers for iFlow CLI! This guide will help you get started in 5 minutes.

## Prerequisites

Before you begin, make sure you have:

- iFlow CLI installed (version 0.4.11 or higher)
- Python 3.x installed
- Git installed

Check your versions:

```bash
iflow --version
python --version
git --version
```

## Installation

### Step 1: Download Superpowers

Clone the repository:

```bash
git clone https://github.com/your-username/superpowers-iflow.git
cd superpowers-iflow
```

### Step 2: Install Skills

Copy skills to your iFlow CLI skills directory:

```bash
# Global installation
cp -r skills/* ~/.iflow/skills/

# Or project-specific installation
cp -r skills/* .iflow/skills/
```

### Step 3: Refresh Skills

Refresh the skills list:

```bash
/skills refresh
```

Expected output:

```
Skills refreshed. 8 skills found.
```

## Your First Skill

Let's try the test-driven-development skill:

```
skill: "test-driven-development"
```

The skill will guide you through the TDD process:

1. Write a failing test
2. Implement the code
3. Refactor the code
4. Repeat

## Next Steps

- Read the [Architecture Documentation](ARCHITECTURE.md)
- Explore [Examples](EXAMPLES.md)
- Check [Best Practices](BEST-PRACTICES.md)
```

### 使用示例库模板

```markdown
# Examples

This document provides a collection of examples for using Superpowers skills.

## Examples by Skill

### Test-Driven Development

#### Basic Example

Create a new test file:

```javascript
test('should return the sum of two numbers', () => {
  expect(add(2, 3)).toBe(5);
});
```

Run the test (should fail):

```bash
npm test
```

Implement the function:

```javascript
function add(a, b) {
  return a + b;
}
```

Run the test again (should pass):

```bash
npm test
```

**Expected Output**:

```
PASS  test/add.test.js
  ✓ should return the sum of two numbers (2 ms)

Test Suites: 1 passed, 1 total
Tests:       1 passed, 1 total
```

#### Advanced Example

[... more advanced example ...]

### Systematic Debugging

#### Example 1: Debugging a Failing Test

[... example ...]

## Examples by Scenario

### Daily Development

#### Feature Development Workflow

Use brainstorming + planning + TDD + debugging:

```
1. skill: "brainstorming"
   - Explore requirements
   - Design the feature

2. skill: "writing-plans"
   - Create implementation plan
   - Break down into tasks

3. skill: "test-driven-development"
   - Write tests
   - Implement code
   - Verify tests

4. skill: "systematic-debugging"
   - Review code quality
   - Identify potential issues
```

## Examples by Difficulty

### Beginner

- TDD Basic Example
- Debugging a Failing Test

### Intermediate

- TDD Advanced Example
- Git Worktrees Workflow

### Advanced

- Subagent-Driven Development
- Multi-Skill Collaboration

## Index

| Skill | Difficulty | Scenario |
|-------|-----------|----------|
| test-driven-development | Beginner | Feature Development |
| systematic-debugging | Beginner | Bug Fixing |
| brainstorming | Intermediate | Planning |
| writing-plans | Intermediate | Planning |
| using-git-worktrees | Intermediate | Parallel Development |
| executing-plans | Advanced | Project Management |
| subagent-driven-development | Advanced | Complex Projects |
```

### 最佳实践指南模板

```markdown
# Best Practices

This guide provides best practices for using Superpowers skills effectively.

## TDD Best Practices

### ✓ Always Write Tests First

**Description**: Always write tests before implementing code.

**When to use**: When implementing new features or fixing bugs.

**Example**:

```javascript
// Good: Write test first
test('should calculate total with tax', () => {
  const result = calculateTotal(100, 0.1);
  expect(result).toBe(110);
});

function calculateTotal(amount, taxRate) {
  return amount * (1 + taxRate);
}
```

**Anti-pattern**:

```javascript
// Bad: Implement code first, then write tests
function calculateTotal(amount, taxRate) {
  return amount * (1 + taxRate);
}

test('should calculate total with tax', () => {
  // ...
});
```

**Why it works**: Writing tests first ensures that the code is testable and that requirements are clear.

### ✓ Keep Tests Small and Focused

**Description**: Each test should verify a single behavior.

**When to use**: Always.

**Example**:

```javascript
// Good: Focused test
test('should return 0 for empty cart', () => {
  expect(calculateTotal([])).toBe(0);
});

test('should calculate sum of items', () => {
  expect(calculateTotal([{price: 10}, {price: 20}])).toBe(30);
});
```

**Anti-pattern**:

```javascript
// Bad: Test does too much
test('should handle cart calculations', () => {
  expect(calculateTotal([])).toBe(0);
  expect(calculateTotal([{price: 10}])).toBe(10);
  expect(calculateTotal([{price: 10}, {price: 20}])).toBe(30);
  // ... more assertions
});
```

## Common Pitfalls

### ✗ Skipping the Refactor Step

**Description**: After tests pass, skipping the refactoring step.

**Problem**: Code becomes messy and hard to maintain.

**How to avoid**: Always review and refactor code after tests pass.

**Fix**: Review the code for improvements and apply refactoring.

## Debugging Best Practices

### ✓ Isolate the Problem

**Description**: Create a minimal test case that reproduces the issue.

**When to use**: When debugging a complex issue.

**Example**:

```javascript
// Instead of debugging the entire application,
// create a minimal test case:

test('should handle edge case', () => {
  // Minimal reproduction
  const result = functionUnderTest(edgeCaseInput);
  expect(result).toBe(expected);
});
```

## Integration Best Practices

### ✓ Use Skills in Combination

**Description**: Combine multiple skills for better results.

**When to use**: When working on complex projects.

**Example**:

```
skill: "brainstorming" → explore requirements
skill: "writing-plans" → create detailed plan
skill: "test-driven-development" → implement with TDD
skill: "systematic-debugging" → review and debug
```

**Why it works**: Each skill complements the others, creating a complete workflow.
```

### 常见问题解答模板

```markdown
# Frequently Asked Questions

This document answers common questions about Superpowers for iFlow CLI.

## Installation

### Q: How do I install Superpowers skills?

**A**: Follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/superpowers-iflow.git
   cd superpowers-iflow
   ```

2. Copy skills to your iFlow CLI skills directory:
   ```bash
   cp -r skills/* ~/.iflow/skills/
   ```

3. Refresh the skills list:
   ```bash
   /skills refresh
   ```

See the [Quick Start Guide](QUICKSTART.md) for more details.

---

### Q: What are the prerequisites?

**A**: You need:

- iFlow CLI (version 0.4.11 or higher)
- Python 3.x
- Git

Check versions:

```bash
iflow --version
python --version
git --version
```

---

## Usage

### Q: How do I call a skill?

**A**: Use the `skill:` command followed by the skill name:

```
skill: "test-driven-development"
```

Or mention the skill in your prompt:

```
Please use the test-driven-development skill to implement this feature.
```

### Q: Can I combine multiple skills?

**A**: Yes! You can use multiple skills in sequence. For example:

```
1. skill: "brainstorming" - explore requirements
2. skill: "writing-plans" - create implementation plan
3. skill: "test-driven-development" - implement with TDD
```

See the [Examples](EXAMPLES.md) for more examples of skill combinations.

---

## Troubleshooting

### Q: Why can't I call a skill?

**A**: Check the following:

1. Skill is installed:
   ```bash
   /skills list
   ```

2. Skill list is refreshed:
   ```bash
   /skills refresh
   ```

3. Skill name is correct (case-sensitive)

See the [Troubleshooting Guide](TROUBLESHOOTING.md) for more help.

---

### Q: Why is my test failing?

**A**: Common reasons:

1. Test implementation is incorrect
2. Code has a bug
3. Test environment issue

Use the `systematic-debugging` skill to diagnose the issue:

```
skill: "systematic-debugging"
```

---

## Advanced

### Q: How do I integrate with CI/CD?

**A**: See the [Integration Guide](INTEGRATION.md) for detailed instructions on integrating with:

- GitHub Actions
- GitLab CI
- Jenkins

---

## Index

| Category | Questions |
|----------|-----------|
| Installation | 2 questions |
| Usage | 2 questions |
| Troubleshooting | 2 questions |
| Advanced | 1 question |

## Can't find your answer?

If you can't find the answer you're looking for:

1. Check the [Troubleshooting Guide](TROUBLESHOOTING.md)
2. Read the [Documentation](ARCHITECTURE.md)
3. Ask on [GitHub Discussions](https://github.com/your-username/superpowers-iflow/discussions)
4. Open an [issue](https://github.com/your-username/superpowers-iflow/issues)
```

## 验证计划

### 使用指南验证

1. **实用性验证**
   - [ ] 快速开始指南可在 5 分钟内完成
   - [ ] 所有示例都可运行
   - [ ] 最佳实践可操作

2. **完整性验证**
   - [ ] 覆盖所有技能
   - [ ] 覆盖所有常见场景
   - [ ] 覆盖所有常见问题

3. **可访问性验证**
   - [ ] 新手可快速上手
   - [ ] 高级用户可深入理解
   - [ ] 索引完整有效

### 验证方法

1. **用户测试**
   - 让新用户尝试快速开始指南
   - 收集反馈
   - 根据反馈改进

2. **示例测试**
   - 运行所有示例
   - 验证输出
   - 修复问题

3. **同行审查**
   - 让同事审查文档
   - 收集反馈
   - 根据反馈改进

## 风险和缓解

### 风险 1: 示例不完整

**影响**: 用户无法找到所需的示例

**缓解措施**:
- 从多个来源收集示例
- 组织示例并创建索引
- 定期更新示例

### 风险 2: 最佳实践不实用

**影响**: 用户无法应用最佳实践

**缓解措施**:
- 从实际经验中收集最佳实践
- 提供具体的示例
- 提供反例说明

### 风险 3: FAQ 不全面

**影响**: 用户找不到答案

**缓解措施**:
- 从多个渠道收集问题
- 按类别和频率组织
- 提供其他资源的链接

## 成功指标

1. **快速开始成功率**: 90% 的用户可以在 5 分钟内完成快速开始
2. **示例可用性**: 100% 的示例可运行
3. **问题覆盖度**: 覆盖 80% 的常见问题

## 下一步

完成 Plan 02 后，继续执行 [Phase 6: Verification & Testing](../06-verification-testing/)。

---

**文档版本**: 1.0.0
**最后更新**: 2026-03-05