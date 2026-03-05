# Test-Driven Development Skill 使用示例

本文档展示了如何在 iFlow CLI 中使用 Test-Driven Development 技能。

## 基础使用

### 调用技能

在 iFlow CLI 中调用 TDD 技能：

```bash
skill: "test-driven-development"
```

### 简单示例：创建加法函数

#### RED - 编写失败的测试

首先，使用 `write_file` 工具编写测试：

```javascript
write_file({
  file_path: "/path/to/math.test.ts",
  content: `
import { add } from './math';

test('add two numbers', () => {
  expect(add(2, 3)).toBe(5);
});
`
});
```

#### 验证 RED

使用 `run_shell_command` 运行测试，确认失败：

```javascript
run_shell_command({
  command: "npm test math.test.ts",
  description: "验证测试失败（函数未实现）"
});
```

预期输出：
```
FAIL  math.test.ts
  ✕ add two numbers (5 ms)

  ● add two numbers

    ReferenceError: add is not defined
```

#### GREEN - 编写最小代码

使用 `write_file` 工具编写最小实现：

```javascript
write_file({
  file_path: "/path/to/math.ts",
  content: `
export function add(a: number, b: number): number {
  return a + b;
}
`
});
```

#### 验证 GREEN

再次运行测试，确认通过：

```javascript
run_shell_command({
  command: "npm test math.test.ts",
  description: "验证测试通过"
});
```

预期输出：
```
PASS  math.test.ts
  ✓ add two numbers (2 ms)
```

#### REFACTOR - 清理代码（如果需要）

如果代码需要清理，使用 `replace` 工具重构，同时保持测试绿色。

#### 重复

添加下一个测试：

```javascript
write_file({
  file_path: "/path/to/math.test.ts",
  content: `
import { add } from './math';

test('add two numbers', () => {
  expect(add(2, 3)).toBe(5);
});

test('add negative numbers', () => {
  expect(add(-2, -3)).toBe(-5);
});
`
});
```

## 完整流程示例：重试功能

### RED - 编写失败的测试

```javascript
write_file({
  file_path: "/path/to/retry.test.ts",
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

test('重试 3 次后抛出错误', async () => {
  const operation = () => {
    throw new Error('always fail');
  };

  await expect(retryOperation(operation, 3))
    .rejects.toThrow('always fail');
});
`
});
```

### 验证 RED

```javascript
run_shell_command({
  command: "npm test retry.test.ts",
  description: "验证测试失败（函数未实现）"
});
```

### GREEN - 编写最小代码

```javascript
write_file({
  file_path: "/path/to/retry.ts",
  content: `
export async function retryOperation<T>(
  fn: () => Promise<T>,
  maxRetries: number = 3
): Promise<T> {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (e) {
      if (i === maxRetries - 1) throw e;
    }
  }
  throw new Error('unreachable');
}
`
});
```

### 验证 GREEN

```javascript
run_shell_command({
  command: "npm test retry.test.ts",
  description: "验证测试通过"
});
```

### REFACTOR - 添加日志（可选）

如果需要，使用 `replace` 工具添加日志功能：

```javascript
replace({
  file_path: "/path/to/retry.ts",
  instruction: "添加重试日志功能",
  old_string: `export async function retryOperation<T>(
  fn: () => Promise<T>,
  maxRetries: number = 3
): Promise<T> {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (e) {
      if (i === maxRetries - 1) throw e;
    }
  }
  throw new Error('unreachable');
}`,
  new_string: `export async function retryOperation<T>(
  fn: () => Promise<T>,
  maxRetries: number = 3,
  onRetry?: (attempt: number, error: Error) => void
): Promise<T> {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (e) {
      const error = e as Error;
      if (i === maxRetries - 1) throw error;
      onRetry?.(i + 1, error);
    }
  }
  throw new Error('unreachable');
}`
});
```

重新运行测试确认重构没有破坏功能：

```javascript
run_shell_command({
  command: "npm test retry.test.ts",
  description: "验证重构后测试仍然通过"
});
```

## Bug 修复示例

### 场景：空电子邮件被接受

#### RED - 编写失败的测试

```javascript
write_file({
  file_path: "/path/to/validator.test.ts",
  content: `
import { validateEmail } from './validator';

test('拒绝空电子邮件', () => {
  const result = validateEmail('');
  expect(result.valid).toBe(false);
  expect(result.error).toBe('Email required');
});

test('拒绝仅空白字符的电子邮件', () => {
  const result = validateEmail('   ');
  expect(result.valid).toBe(false);
  expect(result.error).toBe('Email required');
});
`
});
```

#### 验证 RED

```javascript
run_shell_command({
  command: "npm test validator.test.ts",
  description: "验证测试失败（空电子邮件未被拒绝）"
});
```

#### GREEN - 修复代码

首先读取现有代码：

```javascript
read_file({
  absolute_path: "/path/to/validator.ts"
});
```

然后使用 `replace` 工具修复：

```javascript
replace({
  file_path: "/path/to/validator.ts",
  instruction: "添加空电子邮件验证",
  old_string: `export function validateEmail(email: string): ValidationResult {
  if (!email) {
    return { valid: false, error: 'Email required' };
  }
  // ... 其他验证
}`,
  new_string: `export function validateEmail(email: string): ValidationResult {
  if (!email?.trim()) {
    return { valid: false, error: 'Email required' };
  }
  // ... 其他验证
}`
});
```

#### 验证 GREEN

```javascript
run_shell_command({
  command: "npm test validator.test.ts",
  description: "验证修复后测试通过"
});
```

## 常见场景

### 1. 添加新功能

遵循 TDD 循环：
1. 编写新功能的测试
2. 观察测试失败
3. 编写最小实现
4. 观察测试通过
5. 重构（如果需要）

### 2. 修复 Bug

1. 编写失败的测试重现 bug
2. 观察测试失败
3. 修复代码
4. 观察测试通过
5. 检查其他测试

### 3. 重构代码

1. 确保所有测试通过
2. 重构代码
3. 确保所有测试仍然通过
4. 重复

### 4. 添加边缘情况

1. 为边缘情况编写测试
2. 观察测试失败（或通过，说明已有实现）
3. 实现边缘情况处理
4. 观察测试通过

## 工具使用最佳实践

### 读取文件

```javascript
read_file({
  absolute_path: "/path/to/file.ts"
});
```

### 写入新文件

```javascript
write_file({
  file_path: "/path/to/new-file.ts",
  content: "// 文件内容"
});
```

### 替换文本

```javascript
replace({
  file_path: "/path/to/file.ts",
  instruction: "描述要进行的更改",
  old_string: "要替换的文本（必须精确匹配）",
  new_string: "新文本"
});
```

### 运行命令

```javascript
run_shell_command({
  command: "npm test",
  description: "运行测试"
});
```

## 遇到困难时

### 不知道如何测试

1. 编写你希望的 API 调用
2. 先编写断言
3. 询问合作伙伴

### 测试太复杂

1. 简化接口设计
2. 将复杂测试拆分为多个小测试
3. 考虑是否需要重构设计

### 必须模拟所有内容

1. 使用依赖注入
2. 简化代码耦合
3. 考虑是否需要重构设计

### 测试设置巨大

1. 提取辅助函数
2. 使用测试夹具
3. 如果仍然复杂，简化设计

## 验证检查清单

在标记工作完成之前，确保：

- [ ] 每个新函数/方法都有测试
- [ ] 在实现之前看到每个测试失败
- [ ] 每个测试因预期原因失败（功能缺失，不是拼写错误）
- [ ] 编写最小代码来通过每个测试
- [ ] 所有测试通过
- [ ] 输出干净（没有错误、警告）
- [ ] 测试使用真实代码（仅不可避免时使用 mock）
- [ ] 覆盖边缘情况和错误

## 参考资源

- [Test-Driven Development Skill](../SKILL.md)
- [Superpowers 原始技能](https://github.com/obra/superpowers)
- [TDD 最佳实践](https://github.com/obra/superpowers)

## 总结

遵循 RED-GREEN-REFACTOR 循环：
1. **RED**：先写测试，看着它失败
2. **GREEN**：写最小代码通过测试
3. **REFACTOR**：清理代码，保持测试绿色
4. **重复**：下一个测试

记住：没有失败测试的生产代码不是 TDD！