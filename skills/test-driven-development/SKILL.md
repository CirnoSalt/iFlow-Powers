---
name: test-driven-development
description: 强制执行 RED-GREEN-REFACTOR TDD 循环，确保代码生成包含测试
version: 1.0.0
author: iFlow CLI (port from Superpowers by obra)
category: Development
tags: testing,tdd,development,quality
---

# Test-Driven Development (TDD)

## 概述

先写测试。看着它失败。编写最小代码通过。

**核心原则：** 如果你没有看到测试失败，你就不知道它是否测试了正确的东西。

**违反规则的字面意思就是违反规则的精神。**

## 使用时机

**始终使用：**
- 新功能
- Bug 修复
- 重构
- 行为变更

**例外（需要询问你的合作伙伴）：**
- 一次性原型
- 生成的代码
- 配置文件

在想"这次跳过 TDD"？停下。那是合理化。

## 铁律

```
没有失败测试的生产代码
```

在测试之前写代码？删除它。重新开始。

**没有例外：**
- 不要保留它作为"参考"
- 不要在编写测试时"调整"它
- 不要看它
- 删除意味着删除

从测试开始重新实现。就是这样。

## RED-GREEN-REFACTOR 循环

```
RED (编写失败的测试)
    ↓
验证失败正确
    ↓
GREEN (最小代码)
    ↓
验证通过
    ↓
REFACTOR (清理)
    ↓
下一个测试
```

### RED - 编写失败的测试

编写一个显示应该发生什么的最小测试。

**好的例子：**
```typescript
test('重试失败操作 3 次', async () => {
  let attempts = 0;
  const operation = () => {
    attempts++;
    if (attempts < 3) throw new Error('fail');
    return 'success';
  };

  const result = await retryOperation(operation);

  expect(result).toBe('success');
  expect(attempts).toBe(3);
});
```
清晰的名称，测试真实行为，一件事

**不好的例子：**
```typescript
test('重试工作', async () => {
  const mock = jest.fn()
    .mockRejectedValueOnce(new Error())
    .mockRejectedValueOnce(new Error())
    .mockResolvedValueOnce('success');
  await retryOperation(mock);
  expect(mock).toHaveBeenCalledTimes(3);
});
```
模糊的名称，测试 mock 而不是代码

**要求：**
- 一个行为
- 清晰的名称
- 真实代码（除非不可避免，否则不使用 mock）

### 验证 RED - 看着它失败

**强制性。从不跳过。**

```bash
npm test path/to/test.test.ts
```
或使用 iFlow CLI：
```
run_shell_command: npm test path/to/test.test.ts
```

确认：
- 测试失败（不是错误）
- 失败消息是预期的
- 因为功能缺失而失败（不是拼写错误）

**测试通过？** 你在测试现有行为。修复测试。

**测试错误？** 修复错误，重新运行直到它正确失败。

### GREEN - 最小代码

编写最简单的代码来通过测试。

**好的例子：**
```typescript
async function retryOperation<T>(fn: () => Promise<T>): Promise<T> {
  for (let i = 0; i < 3; i++) {
    try {
      return await fn();
    } catch (e) {
      if (i === 2) throw e;
    }
  }
  throw new Error('unreachable');
}
```
刚好足够通过
</Good>

**不好的例子：**
```typescript
async function retryOperation<T>(
  fn: () => Promise<T>,
  options?: {
    maxRetries?: number;
    backoff?: 'linear' | 'exponential';
    onRetry?: (attempt: number) => void;
  }
): Promise<T> {
  // YAGNI (You Aren't Gonna Need It)
}
```
过度工程

不要添加功能、重构其他代码或在测试之外"改进"。

### 验证 GREEN - 看着它通过

**强制性。**

```bash
npm test path/to/test.test.ts
```
或使用 iFlow CLI：
```
run_shell_command: npm test path/to/test.test.ts
```

确认：
- 测试通过
- 其他测试仍然通过
- 输出干净（没有错误、警告）

**测试失败？** 修复代码，不是测试。

**其他测试失败？** 现在修复。

### REFACTOR - 清理

在绿色之后：
- 删除重复
- 改进名称
- 提取帮助函数

保持测试绿色。不要添加行为。

### 重复

下一个功能的下一个失败的测试。

## 好的测试

| 质量 | 好的 | 不好的 |
|------|------|--------|
| **最小** | 一件事。名称中有"and"？拆分它。 | `test('验证电子邮件和域名和空白字符')` |
| **清晰** | 名称描述行为 | `test('test1')` |
| **显示意图** | 演示所需的 API | 模糊代码应该做什么 |

## 为什么顺序很重要

**"我会在之后写测试来验证它工作"**

之后编写的测试立即通过。立即通过证明不了什么：
- 可能测试错误的东西
- 可能测试实现，不是行为
- 可能错过你忘记的边缘情况
- 你从未看到它捕获 bug

测试前迫使你看到测试失败，证明它实际上测试了某些东西。

**"我已经手动测试了所有边缘情况"**

手动测试是临时的。你认为你测试了一切但是：
- 没有测试内容的记录
- 代码更改时无法重新运行
- 在压力下容易忘记情况
- "我尝试时它工作" ≠ 全面

自动化测试是系统性的。它们每次都运行相同的方式。

**"删除 X 小时的工作是浪费的"**

沉没成本谬误。时间已经过去了。你现在的选择：
- 删除并用 TDD 重写（X 更多小时，高信心）
- 保留并在之后添加测试（30 分钟，低信心，可能有 bug）

"浪费"是保留你无法信任的代码。没有真实测试的工作代码是技术债务。

**"TDD 是教条的，务实意味着适应"**

TDD 是务实的：
- 在提交之前发现 bug（比之后调试更快）
- 防止回归（测试立即捕获中断）
- 记录行为（测试显示如何使用代码）
- 启用重构（自由更改，测试捕获中断）

"务实"捷径 = 在生产中调试 = 更慢。

**"之后的测试实现相同的目标 - 是精神不是仪式"**

不。测试后回答"这个做什么？"测试前回答"应该做什么？"

测试后被你的实现偏置。你测试你构建的，不是要求的。你验证记住的边缘情况，不是发现的。

测试前强制在实现之前发现边缘情况。测试后验证你记住了一切（你没有）。

30 分钟的测试后 ≠ TDD。你获得覆盖，失去测试工作的证明。

## 常见合理化

| 借口 | 现实 |
|------|------|
| "太简单无法测试" | 简单代码会中断。测试需要 30 秒。 |
| "我会在之后测试" | 测试立即通过证明不了什么。 |
| "之后的测试实现相同的目标" | 测试后 = "这个做什么？"测试前 = "应该做什么？" |
| "已经手动测试" | 临时 ≠ 系统性。没有记录，无法重新运行。 |
| "删除 X 小时是浪费的" | 沉没成本谬误。保留未验证的代码是技术债务。 |
| "保留为参考，先写测试" | 你会调整它。那是测试后。删除意味着删除。 |
| "需要先探索" | 好的。丢弃探索，用 TDD 开始。 |
| "测试困难 = 设计不清楚" | 听测试。难以测试 = 难以使用。 |
| "TDD 会让我慢下来" | TDD 比调试更快。务实 = 测试前。 |
| "手动测试更快" | 手动不证明边缘情况。你将重新测试每个更改。 |
| "现有代码没有测试" | 你在改进它。为现有代码添加测试。 |

## 红色标志 - 停下并重新开始

- 测试前的代码
- 实现后的测试
- 测试立即通过
- 无法解释为什么测试失败
- 测试"稍后"添加
- 合理化"仅此一次"
- "我已经手动测试了它"
- "之后的测试实现相同的目的"
- "是精神不是仪式"
- "保留为参考"或"调整现有代码"
- "已经花了 X 小时，删除是浪费的"
- "TDD 是教条的，我是务实的"
- "这不同因为..."

**所有这些意味着：删除代码。用 TDD 重新开始。**

## 工具映射

在 iFlow CLI 中使用此技能时，将 Superpowers 工具映射到 iFlow CLI 工具：

| Superpowers | iFlow CLI | 说明 |
|-------------|-----------|------|
| `Read` | `read_file` | 读取文件内容 |
| `Write` | `write_file` | 写入文件内容 |
| `Edit` | `replace` | 替换文本（需要精确的 old_string 和 new_string） |
| `Bash` | `run_shell_command` | 执行命令 |
| `Task` | `task` | 派遣子代理（需要指定 subagent_type） |
| `Skill` | `Skill` | 调用技能 |

## 示例：Bug 修复

**Bug：** 接受空电子邮件

**RED**
```typescript
test('拒绝空电子邮件', async () => {
  const result = await submitForm({ email: '' });
  expect(result.error).toBe('Email required');
});
```

**验证 RED**
```bash
$ npm test
FAIL: expected 'Email required', got undefined
```
或使用 iFlow CLI：
```
run_shell_command: npm test
```

**GREEN**
```typescript
function submitForm(data: FormData) {
  if (!data.email?.trim()) {
    return { error: 'Email required' };
  }
  // ...
}
```

**验证 GREEN**
```bash
$ npm test
PASS
```

**REFACTOR**
如果需要，为多个字段提取验证。

## 验证检查清单

在标记工作完成之前：

- [ ] 每个新函数/方法都有测试
- [ ] 在实现之前看到每个测试失败
- [ ] 每个测试因预期原因失败（功能缺失，不是拼写错误）
- [ ] 编写最小代码来通过每个测试
- [ ] 所有测试通过
- [ ] 输出干净（没有错误、警告）
- [ ] 测试使用真实代码（仅不可避免时使用 mock）
- [ ] 覆盖边缘情况和错误

无法检查所有框？你跳过了 TDD。重新开始。

## 遇到困难时

| 问题 | 解决方案 |
|------|----------|
| 不知道如何测试 | 编写期望的 API。先编写断言。询问你的合作伙伴。 |
| 测试太复杂 | 设计太复杂。简化接口。 |
| 必须模拟所有内容 | 代码太耦合。使用依赖注入。 |
| 测试设置巨大 | 提取帮助函数。仍然复杂？简化设计。 |

## 调试集成

发现 bug？编写失败的测试重现它。遵循 TDD 循环。测试证明修复并防止回归。

永远不要在没有测试的情况下修复 bug。

## 测试反模式

添加 mock 或测试工具时，阅读 `testing-anti-patterns.md` 以避免常见陷阱：
- 测试 mock 行为而不是真实行为
- 向生产类添加仅测试方法
- 在不理解依赖关系的情况下模拟

## 最终规则

```
生产代码 → 测试存在并且先失败
否则 → 不是 TDD
```

没有你合作伙伴的许可，没有例外。

## 在 iFlow CLI 中使用

要在 iFlow CLI 中使用此技能：

```bash
# 调用技能
skill: "test-driven-development"
```

然后遵循 RED-GREEN-REFACTOR 循环：

1. **RED**：使用 `write_file` 编写失败的测试
2. **验证 RED**：使用 `run_shell_command` 运行测试并确认失败
3. **GREEN**：使用 `write_file` 或 `replace` 编写最小代码
4. **验证 GREEN**：使用 `run_shell_command` 运行测试并确认通过
5. **REFACTOR**：使用 `replace` 清理代码
6. **重复**：下一个测试

## 完整示例

```javascript
// 1. RED: 编写失败的测试
write_file({
  file_path: "/path/to/test.test.ts",
  content: `
test('重试失败操作 3 次', async () => {
  let attempts = 0;
  const operation = () => {
    attempts++;
    if (attempts < 3) throw new Error('fail');
    return 'success';
  };

  const result = await retryOperation(operation);

  expect(result).toBe('success');
  expect(attempts).toBe(3);
});
`
});

// 2. 验证 RED
run_shell_command({
  command: "npm test test.test.ts",
  description: "验证测试失败"
});

// 3. GREEN: 编写最小代码
write_file({
  file_path: "/path/to/retry.ts",
  content: `
async function retryOperation<T>(fn: () => Promise<T>): Promise<T> {
  for (let i = 0; i < 3; i++) {
    try {
      return await fn();
    } catch (e) {
      if (i === 2) throw e;
    }
  }
  throw new Error('unreachable');
}
`
});

// 4. 验证 GREEN
run_shell_command({
  command: "npm test test.test.ts",
  description: "验证测试通过"
});

// 5. REFACTOR: 清理代码（如果需要）
// 6. 重复下一个测试
```

## 参考资源

- Superpowers 原始技能：https://github.com/obra/superpowers
- TDD 最佳实践
- 测试驱动开发指南