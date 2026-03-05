# Systematic Debugging Skill 使用示例

本文档展示了如何在 iFlow CLI 中使用 Systematic Debugging 技能。

## 基础使用

### 调用技能

在 iFlow CLI 中调用 Systematic Debugging 技能：

```bash
skill: "systematic-debugging"
```

### 完整示例：调试 API 错误

#### Phase 1: 根本原因调查

首先，使用 `read_file` 工具读取错误消息和代码：

```javascript
// 读取错误日志
read_file({
  absolute_path: "/path/to/error.log"
});
```

```javascript
// 读取失败的代码
read_file({
  absolute_path: "/path/to/api/user.ts"
});
```

然后，使用 `run_shell_command` 重现问题：

```javascript
run_shell_command({
  command: "npm test -- api/user.test.ts",
  description: "重现 API 错误"
});
```

预期输出：
```
FAIL  api/user.test.ts
  ● getUser should return user data

    TypeError: Cannot read property 'id' of undefined
```

检查最近的更改：

```javascript
run_shell_command({
  command: "git diff HEAD~1 -- api/user.ts",
  description: "检查最近的更改"
});
```

#### Phase 2: 模式分析

读取工作示例：

```javascript
read_file({
  absolute_path: "/path/to/api/product.ts"
});
```

对比差异：
- 正常工作的 `product.ts` 使用可选链（`?.`）
- 失败的 `user.ts` 不使用可选链

识别差异：
```javascript
// product.ts (工作)
const user = data?.user;

// user.ts (失败)
const user = data.user;  // ❌ data 可能是 undefined
```

#### Phase 3: 假设和测试

形成假设："当 data 为 undefined 时，访问 `data.user` 导致错误"

最小化测试：

```javascript
replace({
  file_path: "/path/to/api/user.ts",
  instruction: "添加日志验证假设",
  old_string: `export async function getUser(id: string) {
  const data = await fetchData(id);
  const user = data.user;
  return user;
}`,
  new_string: `export async function getUser(id: string) {
  const data = await fetchData(id);
  console.log('Data:', data);  // 添加日志
  const user = data.user;
  return user;
}`
});
```

验证假设：

```javascript
run_shell_command({
  command: "npm test -- api/user.test.ts",
  description: "验证假设"
});
```

预期输出：
```
Data: undefined
TypeError: Cannot read property 'id' of undefined
```

假设确认：data 确实是 undefined。

#### Phase 4: 实现

首先，使用 `test-driven-development` 技能创建失败的测试：

```bash
skill: "test-driven-development"
```

编写失败的测试：

```javascript
write_file({
  file_path: "/path/to/api/user.test.ts",
  content: `
test('getUser should handle undefined data', async () => {
  const result = await getUser('nonexistent');
  expect(result).toBeNull();
});
`
});
```

验证失败：

```javascript
run_shell_command({
  command: "npm test -- api/user.test.ts",
  description: "验证测试失败"
});
```

实现修复：

```javascript
replace({
  file_path: "/path/to/api/user.ts",
  instruction: "修复根本原因：使用可选链",
  old_string: `export async function getUser(id: string) {
  const data = await fetchData(id);
  console.log('Data:', data);
  const user = data.user;
  return user;
}`,
  new_string: `export async function getUser(id: string) {
  const data = await fetchData(id);
  return data?.user || null;
}`
});
```

验证修复：

```javascript
run_shell_command({
  command: "npm test -- api/user.test.ts",
  description: "验证修复"
});
```

预期输出：
```
PASS  api/user.test.ts
  ✓ getUser should return user data
  ✓ getUser should handle undefined data
```

## 常见场景

### 1. 测试失败

```javascript
// Phase 1: 读取错误
read_file({ absolute_path: "/path/to/test-output.txt" });

// Phase 2: 模式分析
read_file({ absolute_path: "/path/to/working-test.test.ts" });
read_file({ absolute_path: "/path/to/failing-test.test.ts" });

// Phase 3: 假设和测试
// 形成假设，最小化更改

// Phase 4: 实现
// 创建测试，修复，验证
```

### 2. 运行时错误

```javascript
// Phase 1: 重现错误
run_shell_command({ command: "npm start" });

// Phase 2: 追踪堆栈
read_file({ absolute_path: "/path/to/source/file.ts" });

// Phase 3: 测试假设
// 最小化更改

// Phase 4: 修复
// 使用 TDD 技能创建测试
```

### 3. 性能问题

```javascript
// Phase 1: 收集证据
run_shell_command({ command: "npm run benchmark" });

// Phase 2: 分析模式
read_file({ absolute_path: "/path/to/optimized-code.ts" });

// Phase 3: 测试优化
// 最小化优化

// Phase 4: 验证改进
run_shell_command({ command: "npm run benchmark" });
```

### 4. 集成问题

```javascript
// Phase 1: 追踪数据流
// 添加日志到每个组件边界

// Phase 2: 比对接口
read_file({ absolute_path: "/path/to/service-a/api.ts" });
read_file({ absolute_path: "/path/to/service-b/api.ts" });

// Phase 3: 测试接口
// 最小化接口调整

// Phase 4: 验证集成
run_shell_command({ command: "npm run integration-test" });
```

## 多组件系统调试

### 示例：CI/CD 流水线失败

```javascript
// Phase 1: 收集证据

// 添加诊断到工作流
write_file({
  file_path: "/path/to/.github/workflows/ci.yml",
  content: `
- name: Debug Environment
  run: |
    echo "=== Node Version ==="
    node --version
    echo "=== Environment Variables ==="
    env | grep -E "(NODE|PATH)" || echo "No match"
    echo "=== Current Directory ==="
    pwd
    ls -la
`
});

// Phase 2: 模式分析

// 检查正常工作的工作流
read_file({ absolute_path: "/path/to/.github/workflows/workflow-old.yml" });

// 对比差异
// 识别配置更改

// Phase 3: 假设和测试

// 形成假设："Node 版本不兼容"

// 最小化测试：更改 Node 版本
replace({
  file_path: "/path/to/.github/workflows/ci.yml",
  instruction: "测试 Node 版本",
  old_string: "node-version: '20'",
  new_string: "node-version: '18'"
});

// Phase 4: 实现

// 如果假设正确，更新配置
// 添加验证测试
```

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

### 调用技能

```javascript
Skill({
  skill: "test-driven-development"
});
```

## 四阶段检查清单

### Phase 1: 根本原因调查
- [ ] 仔细阅读错误消息
- [ ] 一致地重现问题
- [ ] 检查最近的更改
- [ ] 在多组件系统中收集证据
- [ ] 追踪数据流（如果需要）

### Phase 2: 模式分析
- [ ] 找到工作示例
- [ ] 与参考对比
- [ ] 识别差异
- [ ] 理解依赖

### Phase 3: 假设和测试
- [ ] 形成单一假设
- [ ] 最小化测试
- [ ] 在继续之前验证
- [ ] 当不知道时寻求帮助

### Phase 4: 实现
- [ ] 创建失败的测试用例
- [ ] 实现单一修复
- [ ] 验证修复
- [ ] 如果 3+ 次修复失败，质疑架构

## 红色标志

如果你发现自己在做以下事情，停下并返回 Phase 1：

- "现在快速修复，稍后调查"
- "只是尝试改变 X 看看是否有效"
- "添加多个更改，运行测试"
- "跳过测试，我会手动验证"
- "可能是 X，让我修复它"
- "我不完全理解但这可能有效"
- "再来一次修复尝试"（当已经尝试 2+ 次）

## 参考资源

- [Systematic Debugging Skill](../SKILL.md)
- [Superpowers 原始技能](https://github.com/obra/superpowers)
- [系统性调试最佳实践](https://github.com/obra/superpowers)

## 总结

遵循四个阶段：
1. **Phase 1: 根本原因调查** - 理解什么和为什么
2. **Phase 2: 模式分析** - 识别差异
3. **Phase 3: 假设和测试** - 确认或新假设
4. **Phase 4: 实现** - 修复根本原因，不是症状

记住：没有根本原因调查就不能修复！