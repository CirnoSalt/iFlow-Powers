# 最佳实践指南

本文档提供 Superpowers for iFlow CLI 的最佳实践，帮助你更好地使用技能并避免常见陷阱。

## 目录

- [通用最佳实践](#通用最佳实践)
- [TDD 最佳实践](#tdd-最佳实践)
- [Debugging 最佳实践](#debugging-最佳实践)
- [Brainstorming 最佳实践](#brainstorming-最佳实践)
- [Planning 最佳实践](#planning-最佳实践)
- [Git Worktrees 最佳实践](#git-worktrees-最佳实践)
- [子代理最佳实践](#子代理最佳实践)
- [团队协作最佳实践](#团队协作最佳实践)
- [常见陷阱](#常见陷阱)

---

## 通用最佳实践

### ✓ 始终使用绝对路径

**描述**: 在文件操作中使用绝对路径而不是相对路径

**使用场景**: 所有文件操作

**示例**:

```javascript
// ✅ 正确 - 使用绝对路径
read_file({
  absolute_path: "C:/path/to/file.txt"
});

// ❌ 错误 - 使用相对路径
read_file({
  absolute_path: "./file.txt"  // 不支持
});
```

**为什么有效**: 避免路径混淆和错误，确保操作正确的文件

---

### ✓ 验证工具调用结果

**描述**: 检查工具调用的返回值和错误

**使用场景**: 所有工具调用

**示例**:

```javascript
// ✅ 正确 - 检查结果
try {
  const result = run_shell_command({
    command: "npm test",
    description: "Run tests"
  });
  if (result.exitCode !== 0) {
    console.error("Tests failed");
  }
} catch (error) {
  console.error("Command failed:", error);
}

// ❌ 错误 - 不检查结果
run_shell_command({
  command: "npm test"
});
// 继续执行，不管测试是否通过
```

**为什么有效**: 及时发现和处理错误，避免问题积累

---

### ✓ 使用 todo_write 跟踪进度

**描述**: 使用待办事项列表跟踪任务进度

**使用场景**: 复杂任务和项目

**示例**:

```javascript
// ✅ 正确 - 使用待办事项
todo_write({
  todos: [
    { id: "1", task: "Write tests", status: "in_progress", priority: "high" },
    { id: "2", task: "Implement code", status: "pending", priority: "high" },
    { id: "3", task: "Refactor code", status: "pending", priority: "medium" }
  ]
});

// 完成任务
todo_write({
  todos: [
    { id: "1", task: "Write tests", status: "completed", priority: "high" },
    { id: "2", task: "Implement code", status: "in_progress", priority: "high" },
    { id: "3", task: "Refactor code", status: "pending", priority: "medium" }
  ]
});
```

**为什么有效**: 清晰跟踪进度，避免遗漏任务

---

### ✗ 忽略错误

**描述**: 不处理工具调用的错误

**问题**: 错误未被捕获，导致不可预期的行为

**如何避免**:
```javascript
// 使用 try-catch
try {
  run_shell_command({ command: "npm test" });
} catch (error) {
  console.error("Test failed:", error);
}

// 检查返回值
const result = run_shell_command({ command: "npm test" });
if (result.exitCode !== 0) {
  console.error("Tests failed");
}
```

---

## TDD 最佳实践

### ✓ 始终先写测试

**描述**: 在实现代码之前编写测试

**使用场景**: 所有新功能和 Bug 修复

**示例**:

```javascript
// ✅ 正确 - 先写测试
write_file({
  file_path: "/path/to/math.test.js",
  content: `
test('should add two numbers', () => {
  expect(add(2, 3)).toBe(5);
});
`
});

// 运行测试（应该失败）
run_shell_command({
  command: "npm test math.test.js",
  description: "Verify test fails"
});

// 然后实现代码
write_file({
  file_path: "/path/to/math.js",
  content: `
function add(a, b) {
  return a + b;
}
`
});

// 运行测试（应该通过）
run_shell_command({
  command: "npm test math.test.js",
  description: "Verify test passes"
});
```

**为什么有效**: 确保代码可测试，需求清晰，避免过度设计

---

### ✓ 保持测试小而专注

**描述**: 每个测试验证单个行为

**使用场景**: 所有测试

**示例**:

```javascript
// ✅ 正确 - 每个测试验证一个行为
test('should return 0 for empty cart', () => {
  expect(calculateTotal([])).toBe(0);
});

test('should calculate sum of items', () => {
  expect(calculateTotal([{price: 10}, {price: 20}])).toBe(30);
});

test('should apply discount', () => {
  expect(calculateTotal([{price: 100}], 0.1)).toBe(90);
});

// ❌ 错误 - 一个测试验证多个行为
test('should handle cart calculations', () => {
  expect(calculateTotal([])).toBe(0);
  expect(calculateTotal([{price: 10}])).toBe(10);
  expect(calculateTotal([{price: 10}, {price: 20}])).toBe(30);
  // ... 更多断言
});
```

**为什么有效**: 测试失败时更容易定位问题，测试意图清晰

---

### ✓ 遵循 RED-GREEN-REFACTOR 循环

**描述**: 严格按照 RED-GREEN-REFACTOR 顺序

**使用场景**: 所有 TDD 开发

**示例**:

```javascript
// RED - 写失败的测试
write_file({
  file_path: "/path/to/test.js",
  content: "test('should work', () => { expect(result).toBe(expected); });"
});

// 验证失败
run_shell_command({ command: "npm test", description: "RED - verify fails" });

// GREEN - 写最小代码
write_file({
  file_path: "/path/to/code.js",
  content: "const result = expected;"
});

// 验证通过
run_shell_command({ command: "npm test", description: "GREEN - verify passes" });

// REFACTOR - 重构代码（保持测试绿色）
replace({
  file_path: "/path/to/code.js",
  instruction: "Refactor for better design",
  old_string: "const result = expected;",
  new_string: "const getResult = () => expected;"
});

// 验证仍然通过
run_shell_command({ command: "npm test", description: "REFACTOR - verify still passes" });
```

**为什么有效**: 确保测试驱动开发，避免跳过测试或过度重构

---

### ✗ 跳过测试直接实现

**描述**: 不写测试直接实现代码

**问题**: 代码可能不可测试，需求不明确，容易引入 Bug

**如何避免**:
```javascript
// ❌ 错误 - 直接实现代码
write_file({
  file_path: "/path/to/code.js",
  content: "// 先实现代码"
});

// 然后写测试
write_file({
  file_path: "/path/to/test.js",
  content: "test('should work', () => { ... });"
});

// ✅ 正确 - 先写测试
write_file({
  file_path: "/path/to/test.js",
  content: "test('should work', () => { ... });"
});

// 然后实现代码
write_file({
  file_path: "/path/to/code.js",
  content: "// 实现代码"
});
```

---

### ✗ 测试太复杂

**描述**: 测试代码复杂，难以理解和维护

**问题**: 测试本身可能有 Bug，难以维护

**如何避免**:
```javascript
// ❌ 错误 - 测试太复杂
test('should handle complex scenario', () => {
  // 100 行设置代码
  const complexSetup = createComplexSetup();
  // 复杂的逻辑
  const result = complexOperation(complexSetup);
  // 多个断言
  expect(result).toBe(expected);
  expect(result.property).toBe(expectedProperty);
  expect(result.nested.property).toBe(expectedNestedProperty);
});

// ✅ 正确 - 简化测试
test('should handle simple scenario', () => {
  const input = simpleInput;
  expect(operation(input)).toBe(expected);
});

// 将复杂场景拆分为多个简单测试
```

---

## Debugging 最佳实践

### ✓ 遵循四阶段流程

**描述**: 严格按照四个阶段进行调试

**使用场景**: 所有调试任务

**示例**:

```javascript
// Phase 1: 根本原因调查
read_file({ absolute_path: "/path/to/error.log" });
read_file({ absolute_path: "/path/to/code.js" });
run_shell_command({ command: "npm test", description: "Reproduce issue" });

// Phase 2: 模式分析
read_file({ absolute_path: "/path/to/working-code.js" });
// 对比差异，识别模式

// Phase 3: 假设和测试
// 形成单一假设
// 最小化测试
run_shell_command({ command: "npm test", description: "Verify hypothesis" });

// Phase 4: 实现
// 使用 TDD 创建测试
// 实现修复
run_shell_command({ command: "npm test", description: "Verify fix" });
```

**为什么有效**: 系统化方法确保找到根本原因，不是症状

---

### ✓ 最小化测试

**描述**: 在实现修复前用最小改动验证假设

**使用场景**: 所有假设验证

**示例**:

```javascript
// ✅ 正确 - 最小化测试
replace({
  file_path: "/path/to/code.js",
  instruction: "添加日志验证假设",
  old_string: "function process(data) { return data.user; }",
  new_string: "function process(data) { console.log('Data:', data); return data.user; }"
});

run_shell_command({ command: "npm test", description: "Verify hypothesis" });

// ❌ 错误 - 一次修改多处
replace({
  file_path: "/path/to/code.js",
  instruction: "修复所有问题",
  old_string: "// 大段代码",
  new_string: "// 修改后的代码"
});

// 不知道哪个更改有效
```

**为什么有效**: 确认假设正确后再实现完整修复

---

### ✓ 复现问题

**描述**: 在修复前确保能够一致地重现问题

**使用场景**: 所有调试任务

**示例**:

```javascript
// ✅ 正确 - 确保可以重现
// 第一次运行
run_shell_command({ command: "npm test", description: "Reproduce issue 1" });
// 第二次运行
run_shell_command({ command: "npm test", description: "Reproduce issue 2" });
// 确认每次都失败

// 然后修复
// ...

// 验证修复
run_shell_command({ command: "npm test", description: "Verify fix" });

// ❌ 错误 - 不确认可以重现
// 看到一次失败，直接修复
// 可能问题只是暂时的
```

**为什么有效**: 避免修复不存在或间歇性的问题

---

### ✗ 跳过根本原因调查

**描述**: 不理解问题直接尝试修复

**问题**: 修复症状而非根本原因，问题可能再次出现

**如何避免**:
```javascript
// ❌ 错误 - 直接尝试修复
// 看到错误，立即修改代码
replace({
  file_path: "/path/to/code.js",
  instruction: "修复错误",
  old_string: "// 代码",
  new_string: "// 修改后的代码"
});

// ✅ 正确 - 先调查
// Phase 1: 根本原因调查
read_file({ absolute_path: "/path/to/error.log" });
read_file({ absolute_path: "/path/to/code.js" });
run_shell_command({ command: "npm test", description: "Reproduce issue" });

// 理解问题后再修复
```

---

### ✗ 多次修复失败继续尝试

**描述**: 多次修复失败后仍继续尝试

**问题**: 可能是架构问题，需要重新设计

**如何避免**:
```javascript
// ❌ 错误 - 多次失败继续尝试
// 尝试修复 1 - 失败
// 尝试修复 2 - 失败
// 尝试修复 3 - 失败
// 继续尝试修复 4...

// ✅ 正确 - 3 次失败后质疑架构
// 尝试修复 1 - 失败
// 尝试修复 2 - 失败
// 尝试修复 3 - 失败

// 停止！重新思考架构
Skill({ skill: "brainstorming" });
// 重新设计解决方案
```

---

## Brainstorming 最佳实践

### ✓ 一次问一个问题

**描述**: 一次只问一个澄清问题

**使用场景**: 所有 brainstorming 会话

**示例**:

```javascript
// ✅ 正确 - 一次一个问题
"按钮应该放在哪里？"
// [等待用户回答]

"它应该做什么？"
// [等待用户回答]

"需要什么样式？"
// [等待用户回答]

// ❌ 错误 - 一次问多个问题
"按钮应该放在哪里？它应该做什么？需要什么样式？"
// 用户可能只回答部分问题
```

**为什么有效**: 确保用户完整回答，避免误解

---

### ✓ 提出多种方法

**描述**: 总是提出 2-3 种方法及其权衡

**使用场景**: 所有设计决策

**示例**:

```javascript
// ✅ 正确 - 提出多种方法
"我提出以下两种方法：

**方法 1（推荐）：使用现有的模态框组件**
- 优点：代码复用，一致的用户体验
- 缺点：需要确认模态框组件支持表单

**方法 2：创建新的联系表单页面**
- 优点：SEO 友好，可以添加更多内容
- 缺点：需要创建新页面，增加导航复杂度

我推荐方法 1，因为它保持了单页应用的一致性。"

// ❌ 错误 - 只提出一种方法
"我建议使用现有的模态框组件。"
// 用户不知道其他选项
```

**为什么有效**: 提供选择，让用户参与决策

---

### ✓ 增量验证

**描述**: 每部分设计后获得用户批准

**使用场景**: 所有设计过程

**示例**:

```javascript
// ✅ 正确 - 增量验证
"让我展示组件设计...

**组件：**
- CommentList: 显示评论列表
- CommentForm: 提交评论
- CommentEditor: 编辑评论

这看起来正确吗？"
// [等待用户确认]

"好的，让我继续设计数据流...

**数据流：**
1. 用户提交评论
2. 验证数据
3. 保存到数据库
4. 更新评论列表

这看起来正确吗？"
// [等待用户确认]

// ❌ 错误 - 一次性展示所有设计
"让我展示完整设计...

[10 分钟的详细说明]

这看起来正确吗？"
// 用户可能已经走神或忘记前面部分
```

**为什么有效**: 确保用户理解并同意每个部分

---

### ✗ 跳过设计直接写代码

**描述**: 不探索需求直接开始编码

**问题**: 可能实现错误的功能，需要返工

**如何避免**:
```javascript
// ❌ 错误 - 直接写代码
"好的，让我实现这个功能..."
// 开始编写代码

// ✅ 正确 - 先设计
"让我先探索需求..."
// 询问问题
// 提出方案
// 展示设计
// 获得批准
// 编写设计文档
// 然后调用 writing-plans
```

---

## Planning 最佳实践

### ✓ 分解为小任务

**描述**: 将大任务分解为 2-5 分钟的小任务

**使用场景**: 所有规划

**示例**:

```javascript
// ✅ 正确 - 小任务
todo_write({
  todos: [
    { id: "1", task: "安装依赖", status: "pending", priority: "high" },
    { id: "2", task: "创建组件文件", status: "pending", "priority: "high" },
    { id: "3", task: "编写基础样式", status: "pending", priority: "high" },
    { id: "4", task: "实现核心逻辑", status: "pending", priority: "high" },
    { id: "5", task: "编写测试", status: "pending", priority: "high" }
  ]
});

// ❌ 错误 - 大任务
todo_write({
  todos: [
    { id: "1", task: "实现完整的评论功能", status: "pending", priority: "high" }
    // 这个任务太大了，无法在 2-5 分钟内完成
  ]
});
```

**为什么有效**: 小任务更容易跟踪和完成，提供快速反馈

---

### ✓ 设置优先级

**描述**: 为每个任务设置优先级

**使用场景**: 所有任务清单

**示例**:

```javascript
// ✅ 正确 - 设置优先级
todo_write({
  todos: [
    { id: "1", task: "编写测试", status: "pending", priority: "high" },
    { id: "2", task: "实现核心功能", status: "pending", priority: "high" },
    { id: "3", task: "添加样式", status: "pending", priority: "medium" },
    { id: "4", task: "编写文档", status: "pending", priority: "low" }
  ]
});

// 按优先级执行
// 先完成 high，然后 medium，最后 low

// ❌ 错误 - 不设置优先级
todo_write({
  todos: [
    { id: "1", task: "编写文档", status: "pending", priority: "medium" },
    { id: "2", task: "编写测试", status: "pending", priority: "medium" },
    { id: "3", task: "实现核心功能", status: "pending", priority: "medium" }
  ]
});

// 不知道先做哪个
```

**为什么有效**: 确保重要任务优先完成

---

### ✓ 设置验证标准

**描述**: 为每个任务设置清晰的验证标准

**使用场景**: 所有任务

**示例**:

```javascript
// ✅ 正确 - 设置验证标准
todo_write({
  todos: [
    {
      id: "1",
      task: "编写测试",
      status: "pending",
      priority: "high",
      verification: "所有测试通过，覆盖率 > 80%"
    },
    {
      id: "2",
      task: "实现核心功能",
      status: "pending",
      priority: "high",
      verification: "所有功能测试通过"
    }
  ]
});

// 完成任务后验证
run_shell_command({
  command: "npm test && npm run coverage",
  description: "验证任务完成"
});

// ❌ 错误 - 不设置验证标准
todo_write({
  todos: [
    { id: "1", task: "编写测试", status: "pending", priority: "high" }
    // 不知道如何验证完成
  ]
});
```

**为什么有效**: 明确完成标准，避免模糊

---

## Git Worktrees 最佳实践

### ✓ 为每个功能创建独立 worktree

**描述**: 每个功能使用独立的 worktree

**使用场景**: 并行开发多个功能

**示例**:

```javascript
// ✅ 正确 - 独立 worktree
run_shell_command({
  command: "git worktree add ../project-feature-a feature-a",
  description: "Create worktree for feature-a"
});

run_shell_command({
  command: "git worktree add ../project-feature-b feature-b",
  description: "Create worktree for feature-b"
});

// 在不同 worktree 中独立开发

// ❌ 错误 - 在同一个工作区切换分支
run_shell_command({
  command: "git checkout feature-a",
  description: "Switch to feature-a"
});
// 开发功能 A

run_shell_command({
  command: "git checkout feature-b",
  description: "Switch to feature-b"
});
// 开发功能 B
// 可能污染功能 A 的代码
```

**为什么有效**: 避免分支污染，真正的并行开发

---

### ✓ 完成后清理 worktree

**描述**: 功能完成后删除 worktree

**使用场景**: 所有 worktree

**示例**:

```javascript
// ✅ 正确 - 完成后清理
// 完成功能 A
run_shell_command({
  command: "git merge feature-a",
  description: "Merge feature-a"
});

// 删除 worktree
run_shell_command({
  command: "git worktree remove ../project-feature-a",
  description: "Remove feature-a worktree"
});

// 删除分支
run_shell_command({
  command: "git branch -d feature-a",
  description: "Delete feature-a branch"
});

// ❌ 错误 - 不清理 worktree
// worktree 越来越多
// 占用磁盘空间
// 容易混淆
```

**为什么有效**: 保持工作区整洁，节省磁盘空间

---

## 子代理最佳实践

### ✓ 使用预定义代理类型

**描述**: 使用 iFlow CLI 的预定义代理类型

**使用场景**: 所有子代理调用

**示例**:

```javascript
// ✅ 正确 - 使用预定义代理
task({
  subagent_type: "general-purpose",
  description: "Review code",
  prompt: "Review the code for quality and best practices"
});

task({
  subagent_type: "plan-agent",
  description: "Create plan",
  prompt: "Create a detailed implementation plan"
});

task({
  subagent_type: "explore-agent",
  description: "Analyze codebase",
  prompt: "Analyze the codebase structure"
});

// ❌ 错误 - 尝试自定义代理
task({
  subagent_type: "custom-agent",  // 不存在
  description: "Task",
  prompt: "Prompt"
});
```

**为什么有效**: 预定义代理经过优化，功能完整

---

### ✓ 在 prompt 中定义角色

**描述**: 在 prompt 中明确定义代理的角色

**使用场景**: 所有子代理调用

**示例**:

```javascript
// ✅ 正确 - 定义角色
task({
  subagent_type: "general-purpose",
  description: "Review code",
  prompt: `
    You are a professional code reviewer.
    Review the following code for:
    - Code quality
    - Best practices
    - Security issues
    - Performance opportunities

    Code: ${code}
  `
});

// ❌ 错误 - 不定义角色
task({
  subagent_type: "general-purpose",
  description: "Review code",
  prompt: "Review this code: ${code}"
  // 不知道用什么标准审查
});
```

**为什么有效**: 明确角色和期望，获得更好的结果

---

### ✓ 使用 useContext 传递上下文

**描述**: 使用 useContext 参数传递主代理的上下文

**使用场景**: 需要访问主代理上下文的任务

**示例**:

```javascript
// ✅ 正确 - 传递上下文
task({
  subagent_type: "general-purpose",
  description: "Review code",
  prompt: "Review the code",
  useContext: true  // 传递上下文
});

// ❌ 错误 - 不传递上下文
task({
  subagent_type: "general-purpose",
  description: "Review code",
  prompt: "Review the code"
  // 代理不知道之前的上下文
});
```

**为什么有效**: 子代理可以访问完整上下文，做出更好的决策

---

## 团队协作最佳实践

### ✓ 使用一致的技能组合

**描述**: 团队使用一致的技能组合和工作流

**使用场景**: 团队协作

**示例**:

```javascript
// ✅ 正确 - 一致的工作流
// 所有团队成员使用相同的工作流：
// 1. brainstorming - 探索需求
// 2. writing-plans - 创建计划
// 3. test-driven-development - 实现
// 4. systematic-debugging - 调试

// ❌ 错误 - 每个人用不同的方法
// 成员 A: 直接写代码
// 成员 B: 使用 TDD
// 成员 C: 使用瀑布模型
// 结果：代码质量不一致，难以维护
```

**为什么有效**: 一致性提高协作效率和代码质量

---

### ✓ 文档化工作流

**描述**: 记录团队使用的工作流和最佳实践

**使用场景**: 团队协作

**示例**:

```javascript
// ✅ 正确 - 文档化工作流
write_file({
  file_path: "/path/to/docs/workflow.md",
  content: `
# 团队工作流

## 功能开发流程
1. 使用 brainstorming 技能探索需求
2. 使用 writing-plans 技能创建计划
3. 使用 test-driven-development 技能实现
4. 使用 systematic-debugging 技能调试

## 代码审查标准
- 所有测试必须通过
- 代码覆盖率 > 80%
- 遵循项目编码规范
`
});

// ❌ 错误 - 不文档化
// 工作流只在口头上传递
// 新成员不知道流程
`
```

**为什么有效**: 新成员快速上手，减少沟通成本

---

## 常见陷阱

### 陷阱 1: 过度使用技能

**描述**: 在简单任务上使用技能，反而降低效率

**问题**: 浪费时间，增加复杂度

**如何避免**:
```javascript
// ❌ 错误 - 过度使用
// 简单的重命名操作
Skill({ skill: "brainstorming" });  // 不需要
Skill({ skill: "writing-plans" });  // 不需要

// ✅ 正确 - 直接操作
renameFile("old.js", "new.js");
```

**建议**: 简单任务直接操作，复杂任务使用技能

---

### 陷阱 2: 忽略技能输出

**描述**: 调用技能后不查看或使用输出

**问题**: 浪费技能价值，错过重要信息

**如何避免**:
```javascript
// ❌ 错误 - 忽略输出
Skill({ skill: "brainstorming" });
// 直接开始编码，不看设计文档

// ✅ 正确 - 使用输出
Skill({ skill: "brainstorming" });

// 读取设计文档
read_file({
  absolute_path: "/path/to/docs/design.md"
});

// 基于设计文档实现
```

**建议**: 始终阅读和使用技能的输出

---

### 陷阱 3: 混合使用技能和直接操作

**描述**: 在一个任务中混合使用技能和直接操作，导致不一致

**问题**: 流程混乱，难以跟踪

**如何避免**:
```javascript
// ❌ 错误 - 混合使用
Skill({ skill: "brainstorming" });  // 使用技能
write_file({ file_path: "code.js", content: "// 直接写代码" });  // 直接操作
Skill({ skill: "test-driven-development" });  // 使用技能

// ✅ 正确 - 一致使用
Skill({ skill: "brainstorming" });
Skill({ skill: "writing-plans" });
Skill({ skill: "test-driven-development" });
```

**建议**: 要么全部使用技能，要么全部直接操作，不要混合

---

### 陷阱 4: 不更新文档

**描述**: 代码更新后不更新文档

**问题**: 文档过时，误导用户

**如何避免**:
```javascript
// ❌ 错误 - 不更新文档
// 修改代码
replace({
  file_path: "/path/to/code.js",
  instruction: "Update function",
  old_string: "// 旧代码",
  new_string: "// 新代码"
});

// 不更新文档

// ✅ 正确 - 同步更新文档
// 修改代码
replace({
  file_path: "/path/to/code.js",
  instruction: "Update function",
  old_string: "// 旧代码",
  new_string: "// 新代码"
});

// 更新文档
replace({
  file_path: "/path/to/docs/api.md",
  instruction: "Update API documentation",
  old_string: "旧 API 说明",
  new_string: "新 API 说明"
});
```

**建议**: 代码和文档同步更新

---

## 总结

遵循这些最佳实践，你可以：

- ✅ 提高开发效率
- ✅ 改善代码质量
- ✅ 减少错误和返工
- ✅ 提高团队协作效率
- ✅ 避免常见陷阱

记住：最佳实践是经验的总结，根据你的项目需求进行调整。

---

**文档版本**: 1.0.0
**最后更新**: 2026-03-05