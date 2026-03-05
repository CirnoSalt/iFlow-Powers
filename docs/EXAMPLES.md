# 使用示例库

本文档提供了 Superpowers for iFlow CLI 技能的完整使用示例，帮助你快速上手并掌握各种使用场景。

## 目录

- [按技能分类](#按技能分类)
- [按难度分类](#按难度分类)
- [按使用场景分类](#按使用场景分类)
- [完整工作流示例](#完整工作流示例)
- [示例索引](#示例索引)

---

## 按技能分类

### Test-Driven Development (TDD)

#### 基础示例：创建加法函数

**场景**: 创建一个简单的加法函数

**步骤**:

1. **RED - 编写失败的测试**

```javascript
write_file({
  file_path: "/path/to/math.test.js",
  content: `
test('should add two numbers', () => {
  expect(add(2, 3)).toBe(5);
});
`
});
```

2. **验证失败**

```javascript
run_shell_command({
  command: "npm test math.test.js",
  description: "验证测试失败"
});
```

3. **GREEN - 实现代码**

```javascript
write_file({
  file_path: "/path/to/math.js",
  content: `
function add(a, b) {
  return a + b;
}
`
});
```

4. **验证通过**

```javascript
run_shell_command({
  command: "npm test math.test.js",
  description: "验证测试通过"
});
```

5. **REFACTOR - 重构（如果需要）**

```javascript
replace({
  file_path: "/path/to/math.js",
  instruction: "使用箭头函数重构",
  old_string: "function add(a, b) {\n  return a + b;\n}",
  new_string: "const add = (a, b) => a + b;"
});
```

---

#### 中级示例：重试功能

**场景**: 实现一个可以重试失败操作的函数

**步骤**:

1. **RED - 编写测试**

```javascript
write_file({
  file_path: "/path/to/retry.test.js",
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

2. **GREEN - 实现代码**

```javascript
write_file({
  file_path: "/path/to/retry.js",
  content: `
async function retryOperation(fn, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (e) {
      if (i === maxRetries - 1) throw e;
    }
  }
}
`
});
```

3. **REFACTOR - 添加日志功能**

```javascript
replace({
  file_path: "/path/to/retry.js",
  instruction: "添加重试日志功能",
  old_string: `async function retryOperation(fn, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (e) {
      if (i === maxRetries - 1) throw e;
    }
  }
}`,
  new_string: `async function retryOperation(fn, maxRetries = 3, onRetry) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (e) {
      const error = e;
      if (i === maxRetries - 1) throw error;
      onRetry?.(i + 1, error);
    }
  }
}`
});
```

---

#### Bug 修复示例：空电子邮件验证

**场景**: 修复空电子邮件被接受的 Bug

**步骤**:

1. **RED - 编写失败的测试**

```javascript
write_file({
  file_path: "/path/to/validator.test.js",
  content: `
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

2. **验证失败**

```javascript
run_shell_command({
  command: "npm test validator.test.js",
  description: "验证测试失败"
});
```

3. **GREEN - 修复代码**

```javascript
replace({
  file_path: "/path/to/validator.js",
  instruction: "添加空电子邮件验证",
  old_string: `function validateEmail(email) {
  if (!email) {
    return { valid: false, error: 'Email required' };
  }
}`,
  new_string: `function validateEmail(email) {
  if (!email?.trim()) {
    return { valid: false, error: 'Email required' };
  }
}`
});
```

4. **验证修复**

```javascript
run_shell_command({
  command: "npm test validator.test.js",
  description: "验证修复"
});
```

---

### Systematic Debugging

#### 基础示例：调试 API 错误

**场景**: 调试 API 返回 undefined 错误

**步骤**:

**Phase 1: 根本原因调查**

```javascript
// 读取错误日志
read_file({
  absolute_path: "/path/to/error.log"
});

// 读取失败的代码
read_file({
  absolute_path: "/path/to/api/user.js"
});

// 重现问题
run_shell_command({
  command: "npm test -- api/user.test.js",
  description: "重现 API 错误"
});

// 检查最近的更改
run_shell_command({
  command: "git diff HEAD~1 -- api/user.js",
  description: "检查最近的更改"
});
```

**Phase 2: 模式分析**

```javascript
// 读取工作示例
read_file({
  absolute_path: "/path/to/api/product.js"
});

// 对比差异
// product.ts 使用可选链（?.）
// user.ts 不使用可选链
```

**Phase 3: 假设和测试**

```javascript
// 形成假设："当 data 为 undefined 时，访问 `data.user` 导致错误"

// 添加日志验证假设
replace({
  file_path: "/path/to/api/user.js",
  instruction: "添加日志验证假设",
  old_string: `async function getUser(id) {
  const data = await fetchData(id);
  const user = data.user;
  return user;
}`,
  new_string: `async function getUser(id) {
  const data = await fetchData(id);
  console.log('Data:', data);
  const user = data.user;
  return user;
}`
});

// 验证假设
run_shell_command({
  command: "npm test -- api/user.test.js",
  description: "验证假设"
});
```

**Phase 4: 实现**

```javascript
// 使用 TDD 技能创建失败的测试
Skill({ skill: "test-driven-development" });

// 编写失败的测试
write_file({
  file_path: "/path/to/api/user.test.js",
  content: `
test('getUser should handle undefined data', async () => {
  const result = await getUser('nonexistent');
  expect(result).toBeNull();
});
`
});

// 实现修复
replace({
  file_path: "/path/to/api/user.js",
  instruction: "修复根本原因：使用可选链",
  old_string: `async function getUser(id) {
  const data = await fetchData(id);
  console.log('Data:', data);
  const user = data.user;
  return user;
}`,
  new_string: `async function getUser(id) {
  const data = await fetchData(id);
  return data?.user || null;
}`
});

// 验证修复
run_shell_command({
  command: "npm test -- api/user.test.js",
  description: "验证修复"
});
```

---

#### 测试失败调试

**场景**: 调试测试失败问题

**步骤**:

1. **读取错误信息**

```javascript
read_file({
  absolute_path: "/path/to/test-output.txt"
});
```

2. **对比工作示例**

```javascript
read_file({
  absolute_path: "/path/to/working-test.test.js"
});

read_file({
  absolute_path: "/path/to/failing-test.test.js"
});
```

3. **形成假设并测试**

```javascript
// 假设："测试环境配置不同"

// 添加日志验证
write_file({
  file_path: "/path/to/debug-test.js",
  content: `
console.log('Node version:', process.version);
console.log('Environment:', process.env.NODE_ENV);
console.log('Test file:', __filename);
`
});

run_shell_command({
  command: "node debug-test.js",
  description: "验证环境配置"
});
```

4. **修复并验证**

```javascript
// 修复配置
replace({
  file_path: "/path/to/.env",
  instruction: "修复环境配置",
  old_string: "NODE_ENV=development",
  new_string: "NODE_ENV=test"
});

// 验证修复
run_shell_command({
  command: "npm test",
  description: "验证修复"
});
```

---

### Brainstorming

#### 基础示例：添加评论功能

**场景**: 为网站添加用户评论功能

**对话流程**:

**用户**: 我想添加一个用户评论功能

**AI**:
```javascript
// 检查项目结构
read_file({
  absolute_path: "/path/to/package.json"
});

// 询问用户
"评论功能应该在哪些页面上可用？"
```

**用户**: 产品详情页面和博客文章页面

**AI**: "评论需要哪些功能？"

**用户**: 用户可以发布、编辑和删除自己的评论

**AI**: "需要评论审核吗？"

**用户**: 是的，管理员需要审核评论

**AI**: 提出方案：

```
**方法 1（推荐）：使用现有的评论库**
- 优点：快速实现，经过测试
- 缺点：依赖第三方库

**方法 2：从头构建自定义评论系统**
- 优点：完全控制，可定制
- 缺点：开发时间长，需要维护
```

**AI**: 展示设计：

```
**架构：**
- 使用评论库
- 组件：CommentList, CommentForm, CommentEditor
- 数据流：用户 → 评论 → 数据库 → 审核队列 → 已批准评论

**错误处理：**
- 验证错误
- 权限错误
- 网络错误

**测试：**
- 单元测试
- 集成测试
- E2E 测试
```

**AI**: 编写设计文档

```javascript
write_file({
  file_path: "/path/to/docs/plans/2026-03-05-user-comments-design.md",
  content: "# 用户评论功能设计\n\n[完整设计文档...]"
});
```

**AI**: 调用 writing-plans 技能

```javascript
Skill({ skill: "writing-plans" });
```

---

#### 重构示例：重构认证代码

**场景**: 重构用户认证代码

**对话流程**:

**用户**: 我想重构用户认证代码，使其更易于维护

**AI**:
```javascript
// 检查当前认证代码
read_file({
  absolute_path: "/path/to/auth.js"
});

// 询问问题
"当前代码存在哪些问题？"
```

**用户**: 代码重复，难以测试，缺少错误处理

**AI**: "重构的目标是什么？"

**用户**: 提高代码可维护性、可测试性和错误处理

**AI**: 提出方案：

```
**方法 1（推荐）：提取认证逻辑到单独的服务**
- 优点：关注点分离，易于测试
- 缺点：需要重构现有代码

**方法 2：使用现有的认证库**
- 优点：快速实现，经过测试
- 缺点：可能不完全符合需求

**方法 3：完全重写认证系统**
- 优点：完全控制
- 缺点：风险高，开发时间长
```

**AI**: 展示设计：

```
**架构：**
- AuthService: 认证逻辑
- AuthController: 请求处理
- LoginView, RegisterView: UI 组件

**数据流：**
用户 → 控制器 → 服务 → 数据库

**错误处理：**
- 统一的错误处理机制
- 错误码和消息

**测试：**
- 单元测试
- 集成测试
- E2E 测试
```

**AI**: 编写设计文档并调用 writing-plans

---

### Writing Plans

#### 基础示例：创建评论功能实施计划

**场景**: 为评论功能创建详细的实施计划

**步骤**:

1. **分析设计文档**

```javascript
read_file({
  absolute_path: "/path/to/docs/plans/2026-03-05-user-comments-design.md"
});
```

2. **创建任务清单**

```javascript
todo_write({
  todos: [
    {
      id: "1",
      task: "设置评论库",
      status: "pending",
      priority: "high"
    },
    {
      id: "2",
      task: "创建 CommentList 组件",
      status: "pending",
      priority: "high"
    },
    {
      id: "3",
      task: "创建 CommentForm 组件",
      status: "pending",
      priority: "high"
    },
    {
      id: "4",
      task: "创建 CommentEditor 组件",
      status: "pending",
      priority: "medium"
    },
    {
      id: "5",
      task: "实现审核功能",
      status: "pending",
      priority: "medium"
    },
    {
      id: "6",
      task: "编写测试",
      status: "pending",
      priority: "high"
    },
    {
      id: "7",
      task: "集成到产品页面",
      status: "pending",
      priority: "medium"
    },
    {
      id: "8",
      task: "集成到博客页面",
      status: "pending",
      priority: "medium"
    }
  ]
});
```

3. **编写实施计划文档**

```javascript
write_file({
  file_path: "/path/to/docs/plans/2026-03-05-user-comments-implementation.md",
  content: `
# 用户评论功能实施计划

## 阶段 1: 设置（预计 1 小时）
- [ ] 安装评论库
- [ ] 配置数据库
- [ ] 设置 API 路由

## 阶段 2: 核心组件（预计 3 小时）
- [ ] 创建 CommentList 组件
- [ ] 创建 CommentForm 组件
- [ ] 创建 CommentEditor 组件

## 阶段 3: 审核功能（预计 2 小时）
- [ ] 实现审核队列
- [ ] 创建管理员界面
- [ ] 添加审核通知

## 阶段 4: 测试（预计 2 小时）
- [ ] 编写单元测试
- [ ] 编写集成测试
- [ ] 编写 E2E 测试

## 阶段 5: 集成（预计 2 小时）
- [ ] 集成到产品页面
- [ ] 集成到博客页面
- [ ] 验证功能

## 总计：10 小时
`
});
```

---

### Using Git Worktrees

#### 基础示例：创建并行开发分支

**场景**: 同时开发两个功能而不互相干扰

**步骤**:

1. **创建 worktree**

```javascript
run_shell_command({
  command: "git worktree add ../project-feature-a feature-a",
  description: "创建 feature-a worktree"
});

run_shell_command({
  command: "git worktree add ../project-feature-b feature-b",
  description: "创建 feature-b worktree"
});
```

2. **在 worktree 中工作**

```javascript
// 在 feature-a worktree 中
run_shell_command({
  command: "cd ../project-feature-a && npm install",
  description: "安装 feature-a 依赖"
});

// 在 feature-b worktree 中
run_shell_command({
  command: "cd ../project-feature-b && npm install",
  description: "安装 feature-b 依赖"
});
```

3. **查看 worktree 列表**

```javascript
run_shell_command({
  command: "git worktree list",
  description: "查看所有 worktree"
});
```

4. **完成工作后清理**

```javascript
run_shell_command({
  command: "git worktree remove ../project-feature-a",
  description: "删除 feature-a worktree"
});

run_shell_command({
  command: "git worktree remove ../project-feature-b",
  description: "删除 feature-b worktree"
});
```

---

### Executing Plans

#### 基础示例：执行评论功能计划

**场景**: 按照计划执行评论功能的实施

**步骤**:

1. **读取实施计划**

```javascript
read_file({
  absolute_path: "/path/to/docs/plans/2026-03-05-user-comments-implementation.md"
});
```

2. **更新任务状态**

```javascript
todo_write({
  todos: [
    { id: "1", task: "设置评论库", status: "in_progress", priority: "high" },
    { id: "2", task: "创建 CommentList 组件", status: "pending", priority: "high" },
    // ... 其他任务
  ]
});
```

3. **执行第一个任务**

```javascript
run_shell_command({
  command: "npm install comment-library",
  description: "安装评论库"
});
```

4. **标记任务完成**

```javascript
todo_write({
  todos: [
    { id: "1", task: "设置评论库", status: "completed", priority: "high" },
    { id: "2", task: "创建 CommentList 组件", status: "in_progress", priority: "high" },
    // ... 其他任务
  ]
});
```

5. **继续执行下一个任务**

```javascript
write_file({
  file_path: "/path/to/src/components/CommentList.js",
  content: "// CommentList 组件实现"
});

// 标记完成，继续下一个任务
```

---

### Subagent-Driven Development

#### 基础示例：使用子代理开发功能

**场景**: 使用子代理独立开发不同的功能模块

**步骤**:

1. **创建任务清单**

```javascript
todo_write({
  todos: [
    { id: "1", task: "开发评论列表组件", status: "pending", priority: "high" },
    { id: "2", task: "开发评论表单组件", status: "pending", priority: "high" },
    { id: "3", task: "开发审核功能", status: "pending", priority: "medium" }
  ]
});
```

2. **派遣子代理开发组件**

```javascript
task({
  subagent_type: "general-purpose",
  description: "开发评论列表组件",
  prompt: `
    使用 test-driven-development 技能开发评论列表组件：
    - 显示评论列表
    - 支持分页
    - 支持排序
    - 使用 TDD 方法
  `,
  useContext: true
});
```

3. **派遣子代理审查代码**

```javascript
task({
  subagent_type: "general-purpose",
  description: "审查评论列表组件",
  prompt: `
    作为代码审查员，审查评论列表组件：
    - 代码质量
    - 最佳实践
    - 测试覆盖率
    - 性能优化
  `,
  useContext: true
});
```

4. **标记任务完成**

```javascript
todo_write({
  todos: [
    { id: "1", task: "开发评论列表组件", status: "completed", priority: "high" },
    { id: "2", task: "开发评论表单组件", status: "in_progress", priority: "high" },
    { id: "3", task: "开发审核功能", status: "pending", priority: "medium" }
  ]
});
```

---

## 按难度分类

### 初级示例

1. **TDD - 创建加法函数**
   - 技能: test-driven-development
   - 耗时: 5 分钟
   - 详见: [TDD 基础示例](#基础示例创建加法函数)

2. **Git Worktrees - 创建分支**
   - 技能: using-git-worktrees
   - 耗时: 3 分钟
   - 详见: [Git Worktrees 基础示例](#基础示例创建并行开发分支)

3. **Brainstorming - 添加简单功能**
   - 技能: brainstorming
   - 耗时: 10 分钟
   - 详见: [Brainstorming 添加评论功能](#基础示例添加评论功能)

---

### 中级示例

1. **TDD - 重试功能**
   - 技能: test-driven-development
   - 耗时: 15 分钟
   - 详见: [TDD 重试功能](#中级示例重试功能)

2. **Debugging - 调试 API 错误**
   - 技能: systematic-debugging
   - 耗时: 20 分钟
   - 详见: [Debugging API 错误](#基础示例调试-api-错误)

3. **Writing Plans - 创建实施计划**
   - 技能: writing-plans
   - 耗时: 15 分钟
   - 详见: [Writing Plans 实施计划](#基础示例创建评论功能实施计划)

---

### 高级示例

1. **TDD - Bug 修复**
   - 技能: test-driven-development
   - 耗时: 20 分钟
   - 详见: [TDD Bug 修复](#bug-修复示例空电子邮件验证)

2. **Debugging - 多组件调试**
   - 技能: systematic-debugging
   - 耗时: 30 分钟
   - 详见: [Debugging 测试失败](#测试失败调试)

3. **Subagent-Driven Development**
   - 技能: subagent-driven-development
   - 耗时: 1 小时
   - 详见: [Subagent 开发功能](#基础示例使用子代理开发功能)

---

## 按使用场景分类

### 日常开发

#### 功能开发工作流

```
1. brainstorming - 探索需求
   ↓
2. writing-plans - 创建详细计划
   ↓
3. test-driven-development - 使用 TDD 实现
   ↓
4. systematic-debugging - 审查和调试
```

**示例**: 添加用户评论功能

---

#### Bug 修复工作流

```
1. systematic-debugging - 诊断问题
   ↓
2. test-driven-development - 编写失败测试
   ↓
3. 实现修复
   ↓
4. 验证测试通过
```

**示例**: 修复空电子邮件验证 Bug

---

### 并行开发

#### 使用 Git Worktrees

```
1. 创建多个 worktree
   ↓
2. 在不同 worktree 中开发不同功能
   ↓
3. 合并代码
   ↓
4. 清理 worktree
```

**示例**: 同时开发两个功能

---

### 项目管理

#### 执行计划

```
1. 读取计划文档
   ↓
2. 更新任务状态
   ↓
3. 逐个执行任务
   ↓
4. 报告进度
```

**示例**: 执行评论功能实施计划

---

### 团队协作

#### Subagent-Driven Development

```
1. 创建任务清单
   ↓
2. 派遣子代理执行任务
   ↓
3. 子代理独立工作
   ↓
4. 审查和验证
```

**示例**: 多人协作开发

---

## 完整工作流示例

### 端到端：开发新功能

#### 场景：开发用户评论功能

**步骤**:

**1. Brainstorming 阶段**

```javascript
Skill({ skill: "brainstorming" });

// 探索需求
// 提出方案
// 编写设计文档
```

**2. Planning 阶段**

```javascript
Skill({ skill: "writing-plans" });

// 创建实施计划
// 分解任务
// 估算时间
```

**3. Execution 阶段**

```javascript
Skill({ skill: "test-driven-development" });

// 使用 TDD 实现
// RED-GREEN-REFACTOR
```

**4. Debugging 阶段**

```javascript
Skill({ skill: "systematic-debugging" });

// 审查代码
// 识别问题
// 修复问题
```

**5. Completion 阶段**

```javascript
Skill({ skill: "finishing-a-development-branch" });

// 清理代码
// 更新文档
// 提交代码
```

---

## 示例索引

| 技能 | 难度 | 场景 | 位置 |
|------|------|------|------|
| test-driven-development | 初级 | 创建加法函数 | [链接](#基础示例创建加法函数) |
| test-driven-development | 中级 | 重试功能 | [链接](#中级示例重试功能) |
| test-driven-development | 高级 | Bug 修复 | [链接](#bug-修复示例空电子邮件验证) |
| systematic-debugging | 中级 | 调试 API 错误 | [链接](#基础示例调试-api-错误) |
| systematic-debugging | 高级 | 测试失败调试 | [链接](#测试失败调试) |
| brainstorming | 初级 | 添加评论功能 | [链接](#基础示例添加评论功能) |
| brainstorming | 中级 | 重构认证代码 | [链接](#重构示例重构认证代码) |
| writing-plans | 中级 | 创建实施计划 | [链接](#基础示例创建评论功能实施计划) |
| using-git-worktrees | 初级 | 创建并行分支 | [链接](#基础示例创建并行开发分支) |
| executing-plans | 中级 | 执行计划 | [链接](#基础示例执行评论功能计划) |
| subagent-driven-development | 高级 | 子代理开发 | [链接](#基础示例使用子代理开发功能) |

---

## 提示

### 选择合适的示例

- **新手**: 从初级示例开始
- **有经验**: 尝试中级示例
- **专家**: 挑战高级示例

### 组合使用技能

- brainstorming + writing-plans: 完整的规划流程
- test-driven-development + systematic-debugging: 完整的开发和调试流程
- 所有技能: 端到端工作流

### 自定义示例

- 基于现有示例修改
- 适应你的项目需求
- 分享你的示例

---

## 资源

- [技能索引](../lib/SKILL-INDEX.md)
- [API 参考文档](API-REFERENCE.md)
- [最佳实践](BEST-PRACTICES.md)
- [故障排除](TROUBLESHOOTING.md)

---

**文档版本**: 1.0.0
**最后更新**: 2026-03-05