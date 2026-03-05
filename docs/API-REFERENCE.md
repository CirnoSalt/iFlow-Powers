# API Reference

## 文档信息

- **版本**: 1.0.0
- **日期**: 2026-03-05
- **作者**: iFlow CLI
- **状态**: Completed

## 概述

本文档提供 Superpowers for iFlow CLI 的完整 API 参考，包括所有工具和子代理的详细说明。

## 目录

- [工具 API](#工具-api)
  - [文件操作](#文件操作)
  - [命令执行](#命令执行)
  - [子代理](#子代理)
  - [技能](#技能)
  - [任务管理](#任务管理)
  - [搜索工具](#搜索工具)
  - [用户交互](#用户交互)
  - [媒体处理](#媒体处理)
  - [网络操作](#网络操作)
- [子代理 API](#子代理-api)
  - [预定义代理类型](#预定义代理类型)
  - [代理能力](#代理能力)
- [工具映射](#工具映射)
- [使用示例](#使用示例)

## 工具 API

### 文件操作

#### read_file

读取文件内容。

**iFlow CLI 工具**: `read_file`

**Superpowers 映射**: `Read`

**参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| absolute_path | string | 是 | 文件的绝对路径 |
| offset | number | 否 | 起始行号（0-based）|
| limit | number | 否 | 读取的行数 |

**返回值**: 文件内容字符串

**示例**:

```javascript
// 读取整个文件
read_file({
  absolute_path: "/path/to/file.txt"
});

// 读取文件的前 100 行
read_file({
  absolute_path: "/path/to/file.txt",
  offset: 0,
  limit: 100
});
```

**注意事项**:
- 必须使用绝对路径
- 不支持相对路径
- offset 和 limit 必须同时使用

---

#### write_file

写入文件内容。

**iFlow CLI 工具**: `write_file`

**Superpowers 映射**: `Write`

**参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| file_path | string | 是 | 文件的绝对路径 |
| content | string | 是 | 要写入的内容 |

**返回值**: 无

**示例**:

```javascript
write_file({
  file_path: "/path/to/file.txt",
  content: "Hello, World!"
});
```

**注意事项**:
- 必须使用绝对路径
- 会覆盖现有文件
- 自动创建目录（如需要）

---

#### replace

替换文件中的文本。

**iFlow CLI 工具**: `replace`

**Superpowers 映射**: `Edit`

**参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| file_path | string | 是 | 文件的绝对路径 |
| instruction | string | 是 | 更改的详细说明 |
| old_string | string | 是 | 要替换的精确文本 |
| new_string | string | 是 | 替换后的文本 |

**返回值**: 无

**示例**:

```javascript
replace({
  file_path: "/path/to/file.js",
  instruction: "Update the function to use const instead of var",
  old_string: "function myFunction() {\n  var x = 10;\n}",
  new_string: "function myFunction() {\n  const x = 10;\n}"
});
```

**注意事项**:
- old_string 必须精确匹配（包括空格和缩进）
- 必须包含足够的上下文以确保唯一性
- 不会创建文件，只修改现有文件

---

### 命令执行

#### run_shell_command

执行 shell 命令。

**iFlow CLI 工具**: `run_shell_command`

**Superpowers 映射**: `Bash`

**参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| command | string | 是 | 要执行的命令 |
| description | string | 否 | 命令的简短描述 |
| dir_path | string | 否 | 执行命令的目录 |
| timeout | number | 否 | 超时时间（秒）|
| run_in_bg | boolean | 否 | 是否在后台运行 |

**返回值**: 命令输出对象

```javascript
{
  stdout: "命令输出",
  stderr: "错误输出",
  exitCode: 0,
  error: null
}
```

**示例**:

```javascript
// 运行测试
run_shell_command({
  command: "npm test",
  description: "Run tests"
});

// 在特定目录运行命令
run_shell_command({
  command: "npm install",
  description: "Install dependencies",
  dir_path: "/path/to/project"
});

// 在后台运行命令
run_shell_command({
  command: "npm run dev",
  description: "Start development server",
  run_in_bg: true
});
```

**注意事项**:
- 在 Windows 上使用 PowerShell 语法
- 使用分号（;）分隔命令，而不是 &&
- 路径使用反斜杠（\）或正斜杠（/）

---

### 子代理

#### task

启动子代理执行任务。

**iFlow CLI 工具**: `task`

**Superpowers 映射**: `Task`

**参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| subagent_type | string | 是 | 子代理类型 |
| description | string | 是 | 任务描述 |
| prompt | string | 是 | 任务提示 |
| useContext | boolean | 否 | 是否传递上下文 |
| outputFormat | string | 否 | 输出格式模板 |
| constraints | string | 否 | 约束条件 |

**返回值**: 子代理执行结果

**示例**:

```javascript
// 启动通用代理
task({
  subagent_type: "general-purpose",
  description: "Review code quality",
  prompt: "Review the following code for quality and best practices",
  useContext: true
});

// 启动规划代理
task({
  subagent_type: "plan-agent",
  description: "Create implementation plan",
  prompt: "Create a detailed plan for implementing this feature"
});

// 启动探索代理
task({
  subagent_type: "explore-agent",
  description: "Analyze codebase structure",
  prompt: "Analyze the codebase structure and identify patterns"
});
```

**注意事项**:
- 必须使用预定义的代理类型
- 不支持自定义代理定义
- useContext 自动传递主代理的上下文

---

### 技能

#### Skill

调用技能。

**iFlow CLI 工具**: `Skill`

**Superpowers 映射**: `Skill`

**参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| skill | string | 是 | 技能名称 |

**返回值**: 无

**示例**:

```javascript
Skill({ skill: "test-driven-development" });
Skill({ skill: "systematic-debugging" });
Skill({ skill: "brainstorming" });
```

**注意事项**:
- 技能名称必须已注册
- 大小写敏感
- 技能会自动加载并执行

---

### 任务管理

#### todo_write

写入待办事项。

**iFlow CLI 工具**: `todo_write`

**Superpowers 映射**: `TodoWrite`

**参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| todos | array | 是 | 待办事项数组 |

**待办事项结构**:

```javascript
{
  id: string,        // 唯一标识符
  task: string,      // 任务描述
  status: string,    // 状态: pending, in_progress, completed, failed
  priority: string   // 优先级: high, medium, low
}
```

**示例**:

```javascript
todo_write({
  todos: [
    {
      id: "1",
      task: "Write tests",
      status: "in_progress",
      priority: "high"
    },
    {
      id: "2",
      task: "Implement feature",
      status: "pending",
      priority: "high"
    }
  ]
});
```

**注意事项**:
- id 必须唯一
- 每次调用会完全替换待办列表

---

#### todo_read

读取待办事项。

**iFlow CLI 工具**: `todo_read`

**Superpowers 映射**: `TodoRead`

**参数**: 无

**返回值**: 待办事项数组

**示例**:

```javascript
const todos = todo_read();
console.log(todos);
```

---

### 搜索工具

#### glob

查找匹配模式的文件。

**iFlow CLI 工具**: `glob`

**Superpowers 映射**: `Glob`

**参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| pattern | string | 是 | Glob 模式 |
| path | string | 否 | 搜索路径 |
| case_sensitive | boolean | 否 | 是否区分大小写 |
| respect_git_ignore | boolean | 否 | 是否尊重 .gitignore |

**返回值**: 匹配的文件路径数组

**示例**:

```javascript
// 查找所有 JavaScript 文件
glob({
  pattern: "**/*.js"
});

// 在特定路径查找
glob({
  pattern: "**/*.md",
  path: "/path/to/docs"
});

// 查找测试文件
glob({
  pattern: "**/*.test.js"
});
```

**注意事项**:
- 使用 ** 匹配任意目录
- 使用 * 匹配任意文件名
- 支持常见的 Glob 模式

---

#### search_file_content

在文件内容中搜索模式。

**iFlow CLI 工具**: `search_file_content`

**Superpowers 映射**: `Search`

**参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| pattern | string | 是 | 正则表达式模式 |
| path | string | 否 | 搜索路径 |
| include | string | 否 | 文件过滤模式 |
| case_sensitive | boolean | 否 | 是否区分大小写 |
| context | number | 否 | 上下文行数 |
| before | number | 否 | 前置行数 |
| after | number | 否 | 后置行数 |

**返回值**: 匹配结果数组

**示例**:

```javascript
// 搜索函数定义
search_file_content({
  pattern: "function\\s+\\w+",
  include: "*.js"
});

// 搜索带上下文
search_file_content({
  pattern: "TODO",
  context: 2
});

// 在特定路径搜索
search_file_content({
  pattern: "import.*from",
  path: "/path/to/src"
});
```

**注意事项**:
- 使用正则表达式
- 默认不区分大小写
- 可以搜索目录或单个文件

---

### 用户交互

#### ask_user_question

向用户提问。

**iFlow CLI 工具**: `ask_user_question`

**Superpowers 映射**: `Ask`

**参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| questions | array | 是 | 问题数组 |

**问题结构**:

```javascript
{
  question: string,      // 问题文本
  header: string,        // 简短标签
  options: array,        // 选项数组
  multiSelect: boolean   // 是否允许多选
}
```

**选项结构**:

```javascript
{
  label: string,         // 显示文本
  description: string    // 选项说明
}
```

**示例**:

```javascript
ask_user_question({
  questions: [
    {
      question: "Which library should we use?",
      header: "Library",
      options: [
        {
          label: "React",
          description: "Popular UI library"
        },
        {
          label: "Vue",
          description: "Progressive framework"
        }
      ],
      multiSelect: false
    }
  ]
});
```

**注意事项**:
- 可以问 1-4 个问题
- 每个问题 2-4 个选项
- 用户可以选择 "Other" 提供自定义输入

---

### 媒体处理

#### image_read

读取和分析图像。

**iFlow CLI 工具**: `image_read`

**Superpowers 映射**: `ImageRead`

**参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| image_input | string | 是 | 图像输入（路径或 base64）|
| prompt | string | 是 | 分析提示 |
| input_type | string | 否 | 输入类型：file_path 或 base64 |
| mime_type | string | 否 | MIME 类型 |
| task_brief | string | 否 | 任务简述 |

**返回值**: 图像分析结果

**示例**:

```javascript
// 从文件读取
image_read({
  image_input: "/path/to/image.png",
  prompt: "Describe this image in detail",
  input_type: "file_path"
});

// 从 base64 读取
image_read({
  image_input: "data:image/png;base64,iVBORw0KG...",
  prompt: "Analyze the UI design",
  input_type: "base64"
});
```

**注意事项**:
- 支持 PNG, JPG, GIF, WEBP, SVG, BMP
- prompt 必须结构化且详细
- 返回详细的视觉分析

---

### 网络操作

#### web_fetch

获取网页内容。

**iFlow CLI 工具**: `web_fetch`

**Superpowers 映射**: `WebFetch`

**参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| url | string | 是 | URL |
| prompt | string | 是 | 处理提示 |

**返回值**: 处理后的网页内容

**示例**:

```javascript
web_fetch({
  url: "https://example.com/article",
  prompt: "Summarize the main points of this article"
});
```

**注意事项**:
- URL 必须以 http:// 或 https:// 开头
- 支持 localhost 和私有网络地址
- prompt 指定如何处理内容

---

#### web_search

网络搜索。

**iFlow CLI 工具**: `web_search`

**Superpowers 映射**: `WebSearch`

**参数**:

| 参数 | 类型 | 必需 | 说明 |
|------|------|------|------|
| query | string | 是 | 搜索查询 |
| intent | string | 是 | 搜索意图 |
| expected | string | 是 | 预期结果 |
| num | number | 否 | 结果数量 |
| tbs | string | 否 | 时间范围过滤器 |

**返回值**: 搜索结果数组

**示例**:

```javascript
web_search({
  query: "iFlow CLI documentation",
  intent: "Find official documentation",
  expected: "Results should include official docs and tutorials",
  num: 10
});
```

**注意事项**:
- query 必须包含明确的实体
- 不支持纯属性查询
- intent 和 expected 是必需的

---

## 子代理 API

### 预定义代理类型

#### general-purpose

**用途**: 通用任务

**工具集**:
- read_file, write_file, replace
- run_shell_command
- task, Skill
- glob, search_file_content
- list_directory
- web_fetch, web_search

**使用场景**:
- 代码生成
- 文件操作
- 任务执行
- 代码审查
- 实现

**示例**:

```javascript
task({
  subagent_type: "general-purpose",
  description: "Implement feature using TDD",
  prompt: "Implement this feature using test-driven development",
  useContext: true
});
```

---

#### plan-agent

**用途**: 规划和分析

**工具集**:
- read_file, glob
- save_memory
- todo_read, todo_write
- list_directory, search_file_content
- run_shell_command
- web_search, web_fetch

**使用场景**:
- 需求分析
- 架构设计
- 任务规划
- 规范审查

**示例**:

```javascript
task({
  subagent_type: "plan-agent",
  description: "Create implementation plan",
  prompt: "Create a detailed plan for implementing this feature"
});
```

---

#### explore-agent

**用途**: 探索和分析代码库

**工具集**:
- read_file, glob
- save_memory
- todo_read, todo_write
- list_directory, search_file_content
- run_shell_command
- web_search, web_fetch, task

**使用场景**:
- 代码分析
- 依赖追踪
- 模式识别
- 项目理解

**示例**:

```javascript
task({
  subagent_type: "explore-agent",
  description: "Analyze codebase structure",
  prompt: "Analyze the codebase and identify architectural patterns"
});
```

---

#### frontend-tester

**用途**: 前端测试和验证

**工具集**:
- image_read, ask_user_question
- replace, glob, list_directory
- todo_write, ReadCommandOutput
- todo_read, read_file
- search_file_content, web_fetch, web_search
- write_file, xml_escape
- run_shell_command

**使用场景**:
- UI 测试
- 组件验证
- 样式检查
- 前端审查

**示例**:

```javascript
task({
  subagent_type: "frontend-tester",
  description: "Test UI component",
  prompt: "Test the UI component for functionality and appearance"
});
```

---

### 代理能力

#### code-reviewer

**映射**: `general-purpose`

**角色**: 专业的代码审查员

**能力**:
- 代码审查
- 安全分析
- 最佳实践
- 测试覆盖率

**提示**:

```javascript
task({
  subagent_type: "general-purpose",
  description: "Review code",
  prompt: "You are a professional code reviewer. Review the following code for quality, security, and best practices",
  useContext: true
});
```

---

#### implementer

**映射**: `general-purpose`

**角色**: 专业的开发者

**能力**:
- 实现
- TDD
- 代码质量
- 测试

**提示**:

```javascript
task({
  subagent_type: "general-purpose",
  description: "Implement feature",
  prompt: "You are a professional developer. Implement this feature using TDD and ensure all tests pass",
  useContext: true
});
```

---

#### spec-reviewer

**映射**: `plan-agent`

**角色**: 专业的规范审查员

**能力**:
- 规范验证
- 需求检查
- 接口验证

**提示**:

```javascript
task({
  subagent_type: "plan-agent",
  description: "Review spec",
  prompt: "You are a professional spec reviewer. Verify that the code meets all specifications"
});
```

---

## 工具映射

### Superpowers → iFlow CLI 映射表

| Superpowers | iFlow CLI | 参数映射 |
|-------------|-----------|----------|
| Read | read_file | path → absolute_path |
| Write | write_file | path → file_path, contents → content |
| Edit | replace | path → file_path, oldText → old_string, newText → new_string |
| Bash | run_shell_command | command → command |
| Task | task | agent → subagent_type, prompt → prompt |
| Skill | Skill | name → skill |
| TodoWrite | todo_write | todos → todos |
| TodoRead | todo_read | - |
| Glob | glob | pattern → pattern, path → path |
| Search | search_file_content | pattern → pattern, path → path |
| Ask | ask_user_question | questions → questions |
| ImageRead | image_read | image → image_input, prompt → prompt |
| WebFetch | web_fetch | url → url, prompt → prompt |
| WebSearch | web_search | query → query, intent → intent, expected → expected |

---

## 使用示例

### 完整工作流示例

#### TDD 工作流

```javascript
// 1. 创建待办事项
todo_write({
  todos: [
    { id: "1", task: "Write failing test", status: "pending", priority: "high" },
    { id: "2", task: "Implement code", status: "pending", priority: "high" },
    { id: "3", task: "Refactor code", status: "pending", priority: "medium" }
  ]
});

// 2. 读取测试文件
read_file({ absolute_path: "/path/to/test.spec.js" });

// 3. 编写测试
write_file({
  file_path: "/path/to/test.spec.js",
  content: "test('should work', () => { expect(result).toBe(expected); });"
});

// 4. 运行测试
run_shell_command({
  command: "npm test",
  description: "Run tests"
});

// 5. 实现代码
write_file({
  file_path: "/path/to/code.js",
  content: "function result() { return expected; }"
});

// 6. 验证测试
run_shell_command({ command: "npm test", description: "Verify tests" });

// 7. 使用调试技能（如果需要）
Skill({ skill: "systematic-debugging" });
```

---

#### 代码审查工作流

```javascript
// 1. 查找所有代码文件
const files = glob({ pattern: "**/*.js" });

// 2. 搜索潜在问题
search_file_content({
  pattern: "console\\.(log|error|warn)",
  include: "*.js",
  context: 2
});

// 3. 启动代码审查
task({
  subagent_type: "general-purpose",
  description: "Review code for quality",
  prompt: `
    You are a professional code reviewer. Review the code for:
    - Code quality
    - Best practices
    - Security issues
    - Performance opportunities
  `,
  useContext: true
});
```

---

#### 文档生成工作流

```javascript
// 1. 查找所有 Markdown 文件
const docs = glob({ pattern: "**/*.md" });

// 2. 读取文档内容
docs.forEach(doc => {
  read_file({ absolute_path: doc });
});

// 3. 生成文档索引
write_file({
  file_path: "/path/to/INDEX.md",
  content: "# Documentation Index\n\n" + docs.map(d => `- ${d}`).join("\n")
});
```

---

## 最佳实践

### 1. 使用绝对路径

```javascript
// ✅ 正确
read_file({ absolute_path: "/path/to/file.txt" });

// ❌ 错误
read_file({ path: "./file.txt" });
```

### 2. 错误处理

```javascript
// ✅ 正确
try {
  run_shell_command({ command: "npm test" });
} catch (error) {
  console.error("Test failed:", error);
  Skill({ skill: "systematic-debugging" });
}
```

### 3. 使用上下文

```javascript
// ✅ 正确 - 传递上下文
task({
  subagent_type: "general-purpose",
  description: "Review code",
  prompt: "Review the code",
  useContext: true
});
```

### 4. 批量操作

```javascript
// ✅ 正确 - 使用 glob 批量处理
const files = glob({ pattern: "**/*.js" });
files.forEach(file => {
  read_file({ absolute_path: file });
});
```

---

## 参考资源

- [iFlow CLI 文档](https://iflow.cli/)
- [技能索引](../lib/SKILL-INDEX.md)
- [架构设计文档](ARCHITECTURE.md)
- [集成指南](INTEGRATION.md)

---

**文档版本**: 1.0.0
**最后更新**: 2026-03-05