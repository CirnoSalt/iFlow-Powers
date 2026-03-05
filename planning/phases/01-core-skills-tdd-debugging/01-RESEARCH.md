# Superpowers vs iFlow CLI 技能系统对比分析

## 1. 技能格式对比

### Superpowers 技能格式
```markdown
---
name: test-driven-development
description: Use when implementing features
---

# Test-Driven Development

## 使用时机
[决策流程图]

## 核心模式
[前后代码对比]

## 快速参考
[操作表格]

## 实现
[代码或链接]

## 常见错误
[问题和修复]

## 真实影响
[具体结果]
```

**特点**：
- 使用 YAML frontmatter 存储元数据
- Markdown 格式的主内容
- 包含流程图和代码示例
- 强调使用时机和常见错误

### iFlow CLI 技能格式
```markdown
---
name: skill-name
description: Brief description
version: 1.0.0
author: Author Name
category: Category
tags: tag1,tag2
---

# Skill Title

## 概述
[简短描述]

## 使用方式
[使用示例]

## 实现细节
[详细说明]

## 配置选项
[配置说明]
```

**特点**：
- 使用 YAML frontmatter 存储更多元数据（version、author、category、tags）
- Markdown 格式的主内容
- 支持配置选项
- 支持资源文件和脚本

**差异总结**：
| 特性 | Superpowers | iFlow CLI | 兼容性 |
|------|-------------|-----------|--------|
| YAML frontmatter | ✓ | ✓ | 完全兼容 |
| Markdown 内容 | ✓ | ✓ | 完全兼容 |
| 元数据字段 | name, description | name, description, version, author, category, tags | 需要添加额外字段 |
| 流程图支持 | GraphViz DOT | 未明确 | 可选功能 |
| 资源文件 | ✓ | ✓ | 完全兼容 |
| 脚本支持 | Shell | Shell/Python | 需要适配 |

## 2. 工具集对比

### Superpowers 工具集
基于 Claude Code 的工具集：
- `Read` - 读取文件
- `Write` - 写入文件
- `Edit` - 编辑文件
- `Bash` - 执行命令
- `Task` - 派遣子代理
- `Skill` - 调用技能
- `TodoWrite` - 管理 todo 列表
- `TodoRead` - 读取 todo 列表

### iFlow CLI 工具集
基于 iFlow CLI 的工具集：
- `read_file` - 读取文件
- `write_file` - 写入文件
- `replace` - 替换文本
- `run_shell_command` - 执行命令
- `task` - 派遣子代理
- `Skill` - 调用技能
- `todo_write` - 管理 todo 列表
- `todo_read` - 读取 todo 列表
- `glob` - 查找文件
- `search_file_content` - 搜索文件内容
- `list_directory` - 列出目录
- `image_read` - 读取图像
- `web_fetch` - 获取网页内容
- `web_search` - 网页搜索

**工具映射表**：
| Superpowers | iFlow CLI | 映射方式 | 兼容性 |
|-------------|-----------|----------|--------|
| `Read` | `read_file` | 直接映射 | 完全兼容 |
| `Write` | `write_file` | 直接映射 | 完全兼容 |
| `Edit` | `replace` | 需要适配 | 功能略有差异 |
| `Bash` | `run_shell_command` | 直接映射 | 完全兼容 |
| `Task` | `task` | 直接映射 | 完全兼容 |
| `Skill` | `Skill` | 直接映射 | 完全兼容 |
| `TodoWrite` | `todo_write` | 直接映射 | 完全兼容 |
| `TodoRead` | `todo_read` | 直接映射 | 完全兼容 |
| N/A | `glob` | 新增功能 | iFlow CLI 优势 |
| N/A | `search_file_content` | 新增功能 | iFlow CLI 优势 |
| N/A | `web_fetch` | 新增功能 | iFlow CLI 优势 |

**关键差异**：
1. `Edit` vs `replace`：Superpowers 的 Edit 工具更灵活，支持多种编辑方式；iFlow CLI 的 replace 需要精确的 old_string 和 new_string
2. iFlow CLI 提供了更多工具（glob、search、web 等），可以增强 Superpowers 技能的功能

## 3. 子代理系统对比

### Superpowers 子代理系统
```markdown
---
name: code-reviewer
description: Review code for quality and compliance
tools: Read, Write, Bash
color: red
---

<role>
You are a code reviewer...
</role>

<process>
1. Review the code
2. Identify issues
3. Suggest fixes
</process>
```

**特点**：
- 使用 `.md` 文件定义代理
- 支持工具列表
- 支持角色定义和流程定义
- 通过 `Task` 工具调用

### iFlow CLI 子代理系统
```javascript
task({
  subagent_type: "code-reviewer",
  description: "Review code",
  prompt: "Review the following code...",
  useContext: true
})
```

**特点**：
- 预定义的子代理类型（general-purpose、plan-agent、explore-agent、frontend-tester）
- 通过 `task` 工具调用
- 支持上下文传递
- 返回结果给主代理

**差异总结**：
| 特性 | Superpowers | iFlow CLI | 兼容性 |
|------|-------------|-----------|--------|
| 代理定义方式 | .md 文件 | 预定义类型 | 需要适配 |
| 自定义代理 | ✓ | ✗ | 限制 |
| 工具列表 | 可配置 | 预定义 | 需要映射 |
| 上下文传递 | ✓ | ✓ | 完全兼容 |
| 结果返回 | ✓ | ✓ | 完全兼容 |

**适配策略**：
1. 将 Superpowers 的自定义代理映射到 iFlow CLI 的预定义代理类型
2. 对于无法映射的代理，使用 general-purpose 代理
3. 通过 prompt 明确指定代理的角色和任务

## 4. 钩子系统对比

### Superpowers 钩子系统
```json
{
  "SessionStart": {
    "hook": "run-hook.cmd",
    "script": "hooks/session-start.sh",
    "blocking": true
  }
}
```

**特点**：
- 基于事件的钩子（SessionStart、SessionEnd）
- 使用 Shell 脚本
- 支持阻塞和非阻塞模式
- 注入上下文到系统提示

### iFlow CLI 钩子系统
iFlow CLI 的钩子系统通过技能的初始化脚本实现：
```json
{
  "name": "skill-name",
  "scripts": {
    "install": "scripts/install.sh",
    "uninstall": "scripts/uninstall.sh"
  }
}
```

**特点**：
- 基于生命周期事件的钩子（install、uninstall）
- 使用 Shell 脚本
- 自动执行设置脚本
- 支持资源文件管理

**差异总结**：
| 特性 | Superpowers | iFlow CLI | 兼容性 |
|------|-------------|-----------|--------|
| 钩子类型 | SessionStart、SessionEnd | install、uninstall | 不同的事件模型 |
| 脚本支持 | Shell | Shell/Python | 完全兼容 |
| 阻塞模式 | ✓ | ✗ | 需要适配 |
| 上下文注入 | ✓ | ✗ | 需要适配 |

**适配策略**：
1. SessionStart 钩子映射到技能初始化
2. 通过技能文档说明如何手动注入上下文
3. 或者在技能调用时动态注入上下文

## 5. 上下文管理对比

### Superpowers 上下文管理
```markdown
<context>
@PROJECT.md
@ROADMAP.md
@src/components/Button.tsx
</context>
```

**特点**：
- 使用 `@file` 语法引用文件
- 支持相对路径
- 自动解析和加载
- 嵌入到技能提示中

### iFlow CLI 上下文管理
通过 `useContext` 参数传递上下文：
```javascript
task({
  subagent_type: "general-purpose",
  description: "Task description",
  prompt: "Task prompt",
  useContext: true
})
```

**特点**：
- 通过参数传递上下文
- 支持布尔值（true/false）
- 自动包含主代理的上下文
- 不支持文件引用语法

**差异总结**：
| 特性 | Superpowers | iFlow CLI | 兼容性 |
|------|-------------|-----------|--------|
| 上下文引用 | @file 语法 | useContext 参数 | 不同方式 |
| 文件支持 | ✓ | ✗ | 需要适配 |
| 自动解析 | ✓ | ✓ | 完全兼容 |

**适配策略**：
1. 在技能文档中说明如何使用 iFlow CLI 的上下文机制
2. 提供手动引用文件的说明
3. 或者通过 read_file 工具手动加载文件

## 6. 技能发现机制对比

### Superpowers 技能发现
```javascript
// skills-core.js
function findSkillsInDir(dir, sourceType, maxDepth = 3) {
  // 递归查找 SKILL.md 文件
  // 返回技能列表
}
```

**特点**：
- 使用 JavaScript 实现的技能发现
- 递归查找 SKILL.md 文件
- 支持优先级（项目 > 个人 > superpowers）
- 提取 YAML frontmatter

### iFlow CLI 技能发现
```bash
iflow skill list
iflow skills refresh
```

**特点**：
- 命令行工具
- 自动扫描技能目录
- 支持项目级和全局级技能
- 支持版本追踪

**差异总结**：
| 特性 | Superpowers | iFlow CLI | 兼容性 |
|------|-------------|-----------|--------|
| 发现方式 | JavaScript API | 命令行 | 不同实现 |
| 递归查找 | ✓ | ✓ | 完全兼容 |
| 优先级支持 | ✓ | ✓ | 完全兼容 |
| 元数据提取 | ✓ | ✓ | 完全兼容 |

**适配策略**：
1. 使用 iFlow CLI 的技能发现机制
2. 保持 SKILL.md 格式
3. 添加必要的元数据字段（version、author、category、tags）

## 7. 技能触发机制对比

### Superpowers 技能触发
```javascript
// 通过钩子自动触发
SessionStart 钩子 → 注入 using-superpowers 技能
技能自动触发 → AI 检查相关技能 → 应用技能
```

**特点**：
- 通过钩子自动注入
- AI 自动检测相关技能
- 强制性触发（使用 using-superpowers 技能）

### iFlow CLI 技能触发
```bash
# 手动调用
skill: "skill-name"
> task: task-name

# 或者在提示中引用
使用 test-driven-development 技能来实现这个功能
```

**特点**：
- 手动调用
- 支持斜杠命令
- 可选的技能引用

**差异总结**：
| 特性 | Superpowers | iFlow CLI | 兼容性 |
|------|-------------|-----------|--------|
| 触发方式 | 自动 | 手动 | 不同模式 |
| 强制性 | ✓ | ✗ | 需要适配 |
| 钩子支持 | ✓ | ✗ | 需要适配 |

**适配策略**：
1. 在技能文档中说明使用方式
2. 提供示例代码展示如何调用技能
3. 鼓励用户主动使用技能

## 8. 测试方法论对比

### Superpowers 测试方法
```bash
# 运行技能测试
./run-skill-tests.sh

# 三层测试
1. 技能触发测试
2. 集成测试
3. 端到端测试
```

**特点**：
- 完整的测试框架
- 三层测试（触发、集成、端到端）
- 基线测试（无技能 vs 有技能）
- 测试辅助函数

### iFlow CLI 测试方法
iFlow CLI 没有内置的技能测试框架。

**特点**：
- 依赖用户手动测试
- 没有自动化测试框架
- 需要自行构建测试

**差异总结**：
| 特性 | Superpowers | iFlow CLI | 兼容性 |
|------|-------------|-----------|--------|
| 测试框架 | ✓ | ✗ | 需要实现 |
| 自动化测试 | ✓ | ✗ | 需要实现 |
| 基线测试 | ✓ | ✗ | 需要实现 |

**适配策略**：
1. 为 iFlow CLI 创建测试框架
2. 提供 Superpowers 风格的测试辅助函数
3. 在文档中说明如何测试技能

## 9. 总结和建议

### 主要差异
1. **技能格式**：iFlow CLI 需要更多元数据字段
2. **工具集**：大部分工具兼容，Edit 工具需要适配
3. **子代理系统**：Superpowers 支持自定义代理，iFlow CLI 使用预定义类型
4. **钩子系统**：事件模型不同，需要适配
5. **上下文管理**：Superpowers 支持 @file 语法，iFlow CLI 不支持
6. **技能触发**：Superpowers 自动触发，iFlow CLI 手动触发
7. **测试框架**：Superpowers 有完整测试框架，iFlow CLI 没有

### 兼容性评估
- **高兼容性**：技能格式、工具集、技能发现
- **中等兼容性**：子代理系统、钩子系统、上下文管理
- **低兼容性**：技能触发机制、测试框架

### 移植建议
1. **保持技能格式**：使用 iFlow CLI 的格式，添加额外字段
2. **创建工具映射表**：提供 Superpowers 到 iFlow CLI 的工具映射
3. **适配子代理**：将自定义代理映射到预定义代理类型
4. **简化钩子**：通过初始化脚本实现 SessionStart 功能
5. **适配上下文**：在技能文档中说明如何手动加载上下文
6. **实现测试框架**：为 iFlow CLI 创建简单的测试框架
7. **强调手动触发**：在文档中强调需要手动调用技能

### 移植优先级
1. **高优先级**：技能格式、工具集、子代理系统
2. **中优先级**：钩子系统、上下文管理、技能发现
3. **低优先级**：测试框架、技能触发机制

## 10. 下一步行动
1. 完成 Phase 1 的 CONTEXT.md 文档
2. 规划 Phase 1 的实施计划（2 个计划）
3. 开始移植核心技能（TDD 和 Debugging）