# Superpowers for iFlow CLI - 架构设计文档

## 文档信息

- **版本**: 1.0.0
- **日期**: 2026-03-05
- **作者**: iFlow CLI
- **状态**: 已完成

## 目录

- [概述](#概述)
- [系统架构](#系统架构)
- [技能系统](#技能系统)
- [工具映射](#工具映射)
- [子代理系统](#子代理系统)
- [上下文管理](#上下文管理)
- [测试系统](#测试系统)
- [部署架构](#部署架构)
- [扩展机制](#扩展机制)
- [性能优化](#性能优化)
- [安全考虑](#安全考虑)

## 概述

### 设计目标

Superpowers for iFlow CLI 的架构设计旨在：

1. **兼容性**: 与 iFlow CLI 的技能系统完全兼容
2. **可扩展性**: 易于添加新技能和功能
3. **可维护性**: 清晰的代码结构和文档
4. **高性能**: 快速加载和执行技能
5. **跨平台**: 支持 Windows、Linux 和 macOS

### 设计原则

1. **简单性**: 保持系统简单，避免过度设计
2. **一致性**: 遵循 iFlow CLI 的设计模式
3. **可测试性**: 每个组件都可以独立测试
4. **文档化**: 每个组件都有清晰的文档
5. **用户友好**: 提供清晰的使用说明和示例

## 系统架构

### 整体架构

```
┌─────────────────────────────────────────────────────────┐
│                      用户界面                            │
│                  (iFlow CLI 命令行)                      │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│                   技能调用接口                            │
│              (Skill tool invocation)                     │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│                    技能解析器                             │
│              (YAML frontmatter + Markdown)               │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│                   工具映射层                              │
│           (Superpowers → iFlow CLI)                     │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│                   iFlow CLI 工具                          │
│         (read_file, write_file, replace, etc.)           │
└─────────────────────────────────────────────────────────┘
```

### 组件说明

#### 1. 用户界面
- **功能**: 提供命令行界面，允许用户调用技能
- **实现**: iFlow CLI 的命令行系统
- **接口**: `skill: "skill-name"` 或在提示中引用

#### 2. 技能调用接口
- **功能**: 接收技能调用请求，加载技能文件
- **实现**: iFlow CLI 的 Skill tool
- **输入**: 技能名称、参数
- **输出**: 技能内容、执行结果

#### 3. 技能解析器
- **功能**: 解析技能文件，提取元数据和内容
- **实现**: YAML frontmatter 解析 + Markdown 处理
- **输入**: SKILL.md 文件
- **输出**: 技能元数据、技能内容

#### 4. 工具映射层
- **功能**: 将 Superpowers 工具映射到 iFlow CLI 工具
- **实现**: 工具映射表、工具适配器
- **输入**: Superpowers 工具调用
- **输出**: iFlow CLI 工具调用

#### 5. iFlow CLI 工具
- **功能**: 提供文件操作、命令执行、子代理调用等功能
- **实现**: iFlow CLI 的工具系统
- **工具列表**: read_file, write_file, replace, run_shell_command, task, Skill

## 技能系统

### 技能格式

```markdown
---
name: skill-name
description: Brief description
version: 1.0.0
author: iFlow CLI (port from Superpowers by obra)
category: Development
tags: tag1,tag2
---

# Skill Title

## 概述
[简短描述]

## 使用时机
[使用场景列表]

## 核心模式
[核心工作流程]

## 快速参考
[常用操作表格]

## 工具映射
[工具映射表]

## 使用示例
[代码示例]

## 常见错误
[问题和修复]

## 真实影响
[具体结果]
```

### 技能元数据

| 字段 | 类型 | 必需 | 说明 |
|------|------|------|------|
| `name` | string | 是 | 技能名称（唯一标识符） |
| `description` | string | 是 | 技能描述 |
| `version` | string | 是 | 技能版本（语义化版本） |
| `author` | string | 是 | 技能作者 |
| `category` | string | 是 | 技能分类 |
| `tags` | string | 否 | 技能标签（逗号分隔） |

### 技能发现机制

iFlow CLI 自动发现技能：

1. **扫描技能目录**
   - 全局技能目录: `~/.iflow/skills/`
   - 项目技能目录: `{project}/.iflow/skills/`

2. **识别技能文件**
   - 查找 `SKILL.md` 文件
   - 解析 YAML frontmatter

3. **注册技能**
   - 添加到技能注册表
   - 可通过 `/skills list` 查看

### 技能优先级

技能优先级从高到低：

1. 项目级技能
2. 全局级技能
3. Superpowers 技能（如果已安装）

## 工具映射

### 映射表

| Superpowers | iFlow CLI | 参数映射 | 返回值映射 |
|-------------|-----------|----------|------------|
| `Read` | `read_file` | `path` → `absolute_path` | 内容 → 内容 |
| `Write` | `write_file` | `path` → `file_path`, `contents` → `content` | 无 → 无 |
| `Edit` | `replace` | `path` → `file_path`, `oldText` → `old_string`, `newText` → `new_string` | 无 → 无 |
| `Bash` | `bash` | `command` → `command` | 输出 → 输出 |
| `Task` | `task` | `agent` → `subagent_type`, `prompt` → `prompt` | 结果 → 结果 |
| `Skill` | `Skill` | `name` → `skill` | 无 → 无 |

### 工具适配器

#### Read 适配器

```javascript
function adaptRead(readTool) {
  return (path) => {
    return read_file({
      absolute_path: path
    });
  };
}
```

#### Write 适配器

```javascript
function adaptWrite(writeTool) {
  return (path, contents) => {
    return write_file({
      file_path: path,
      content: contents
    });
  };
}
```

#### Edit 适配器

```javascript
function adaptEdit(replaceTool) {
  return (path, oldText, newText, instruction) => {
    return replace({
      file_path: path,
      instruction: instruction || "Edit content",
      old_string: oldText,
      new_string: newText
    });
  };
}
```

## 子代理系统

### 预定义代理类型

iFlow CLI 支持以下预定义代理类型：

1. **general-purpose**
   - 用途: 通用任务
   - 工具: read_file, write_file, replace, run_shell_command, task, Skill, glob, search_file_content, list_directory, web_fetch, web_search
   - 使用场景: 代码生成、文件操作、任务执行

2. **plan-agent**
   - 用途: 规划和分析
   - 工具: read_file, glob, save_memory, todo_read, todo_write, list_directory, search_file_content, run_shell_command, web_search, web_fetch
   - 使用场景: 需求分析、架构设计、任务规划

3. **explore-agent**
   - 用途: 探索和分析代码库
   - 工具: read_file, glob, save_memory, todo_read, todo_write, list_directory, search_file_content, run_shell_command, web_search, web_fetch, task
   - 使用场景: 代码分析、依赖追踪、模式识别

4. **frontend-tester**
   - 用途: 前端测试和验证
   - 工具: image_read, ask_user_question, replace, glob, list_directory, todo_write, ReadCommandOutput, todo_read, read_file, read_many_files, search_file_content, web_fetch, web_search, write_file, xml_escape, run_shell_command
   - 使用场景: UI 测试、组件验证、样式检查

### 代理映射策略

Superpowers 自定义代理映射到 iFlow CLI 预定义代理：

| Superpowers 代理 | iFlow CLI 代理 | 映射理由 |
|-----------------|----------------|----------|
| `code-reviewer` | `general-purpose` | 需要代码审查功能 |
| `implementer` | `general-purpose` | 需要代码生成功能 |
| `spec-reviewer` | `plan-agent` | 需要规范审查功能 |
| `code-quality-reviewer` | `general-purpose` | 需要质量检查功能 |

### 代理调用示例

```javascript
// 调用 code-reviewer 代理
task({
  subagent_type: "general-purpose",
  description: "Review code for quality and compliance",
  prompt: `
    You are a code reviewer. Review the following code for:
    - Code quality
    - Best practices
    - Potential bugs
    - Security issues

    Code: ${code}
  `,
  useContext: true
});
```

## 上下文管理

### 上下文引用方式

Superpowers 支持 `@file` 语法引用文件：

```markdown
<context>
@PROJECT.md
@ROADMAP.md
@STATE.md
</context>
```

iFlow CLI 不支持 `@file` 语法，使用 `useContext` 参数：

```javascript
task({
  subagent_type: "general-purpose",
  description: "Task description",
  prompt: "Task prompt",
  useContext: true  // 传递主代理的上下文
});
```

### 上下文加载策略

1. **自动传递**: 使用 `useContext: true` 自动传递上下文
2. **手动加载**: 使用 `read_file` 手动加载文件内容
3. **混合模式**: 结合使用自动传递和手动加载

### 上下文管理最佳实践

1. **优先使用 `useContext`**: 简单且高效
2. **限制上下文大小**: 避免传递过多内容
3. **按需加载**: 只加载必要的文件
4. **缓存上下文**: 避免重复加载

## 测试系统

### 测试框架

技能测试使用 PowerShell 脚本：

```powershell
# Helper function
function Test-Content {
    param(
        [string]$Path,
        [string]$Content,
        [string]$Description
    )
    
    $script:TotalTests++
    if (Test-Path $Path) {
        $fileContent = [System.IO.File]::ReadAllText($Path, [System.Text.Encoding]::UTF8)
        if ($fileContent -match $Content) {
            Write-Host "[PASS] $Description" -ForegroundColor Green
            $script:TestsPassed++
        } else {
            Write-Host "[FAIL] $Description" -ForegroundColor Red
            $script:TestsFailed++
        }
    } else {
        Write-Host "[FAIL] $Description" -ForegroundColor Red
        $script:TestsFailed++
    }
}

# Test
Test-Content -Path "path/to/file.md" -Content "content" -Description "Test description"
```

### 测试类型

1. **文件存在性测试**: 验证文件是否存在
2. **内容验证测试**: 验证文件包含特定内容
3. **YAML frontmatter 测试**: 验证元数据字段
4. **功能测试**: 验证技能功能正常

### 测试结果

所有技能测试结果：

- Test-Driven Development: 10/10 tests passed
- Systematic Debugging: 14/14 tests passed
- 总计: 24/24 tests passed (100%)

## 部署架构

### 目录结构

```
superpowers-iflow/
├── skills/                    # 技能目录
│   ├── test-driven-development/
│   │   ├── SKILL.md
│   │   ├── tests/
│   │   │   └── test-basic.ps1
│   │   └── examples/
│   │       └── README.md
│   └── systematic-debugging/
│       ├── SKILL.md
│       ├── tests/
│       │   └── test-basic.ps1
│       └── examples/
│           └── README.md
├── planning/                  # 项目规划文档
│   ├── PROJECT.md
│   ├── REQUIREMENTS.md
│   ├── ROADMAP.md
│   ├── STATE.md
│   └── phases/
│       └── 01-core-skills-tdd-debugging/
├── docs/                      # 技术文档
│   ├── ARCHITECTURE.md
│   ├── INTEGRATION.md
│   └── MIGRATION.md
└── README.md
```

### 部署方式

#### 1. 全局部署

```bash
cp -r skills/* ~/.iflow/skills/
/skills refresh
```

#### 2. 项目部署

```bash
cp -r skills/* .iflow/skills/
/skills refresh
```

#### 3. Git Submodule

```bash
git submodule add https://github.com/your-username/superpowers-iflow.git .iflow/skills/superpowers
/skills refresh
```

## 扩展机制

### 添加新技能

1. **创建技能目录**
   ```bash
   mkdir skills/new-skill
   mkdir skills/new-skill/tests
   mkdir skills/new-skill/examples
   ```

2. **创建技能文件**
   - SKILL.md: 技能主文件
   - tests/test-basic.ps1: 测试脚本
   - examples/README.md: 使用示例

3. **注册技能**
   - 自动注册（刷新技能列表）
   - 或手动注册（编辑技能配置）

### 添加新工具

1. **定义工具映射**
   ```javascript
   const toolMapping = {
     "NewTool": "new-tool"
   };
   ```

2. **创建工具适配器**
   ```javascript
   function adaptNewTool(newTool) {
     return (param1, param2) => {
       return newTool({
         param1: param1,
         param2: param2
       });
     };
   }
   ```

3. **更新文档**
   - 更新工具映射表
   - 添加使用示例

### 添加新代理

iFlow CLI 不支持自定义代理定义。使用预定义代理类型：

```javascript
task({
  subagent_type: "general-purpose",
  description: "Task description",
  prompt: "You are a custom agent...",
  useContext: true
});
```

## 性能优化

### 加载优化

1. **延迟加载**: 只在需要时加载技能
2. **缓存机制**: 缓存已加载的技能
3. **并行加载**: 并行加载多个技能

### 执行优化

1. **工具复用**: 复用已创建的工具实例
2. **上下文共享**: 共享上下文避免重复加载
3. **批处理操作**: 批量处理文件操作

### 存储优化

1. **压缩存储**: 压缩技能文件
2. **增量更新**: 只更新更改的部分
3. **清理机制**: 清理未使用的技能

## 安全考虑

### 输入验证

1. **路径验证**: 验证文件路径安全性
2. **命令验证**: 验证命令参数安全性
3. **内容验证**: 验证内容格式正确性

### 权限控制

1. **读写权限**: 控制文件读写权限
2. **执行权限**: 控制命令执行权限
3. **访问控制**: 控制技能访问权限

### 错误处理

1. **异常捕获**: 捕获所有异常
2. **错误日志**: 记录错误日志
3. **恢复机制**: 提供恢复机制

## 总结

Superpowers for iFlow CLI 的架构设计基于以下原则：

1. **简单性**: 保持系统简单，避免过度设计
2. **兼容性**: 与 iFlow CLI 完全兼容
3. **可扩展性**: 易于添加新技能和功能
4. **可维护性**: 清晰的代码结构和文档
5. **性能**: 快速加载和执行技能

该架构为 Superpowers 技能的移植和使用提供了坚实的基础，并为未来的扩展和优化提供了良好的框架。

---

**文档版本**: 1.0.0
**最后更新**: 2026-03-05