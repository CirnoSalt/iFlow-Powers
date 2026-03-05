# iFlow-Powers

> 为 iFlow CLI 提供一套经过验证的软件开发工作流技能系统。

## 📋 目录

- [概述](#概述)
- [快速开始](#快速开始)
- [已移植的技能](#已移植的技能)
- [技术架构](#技术架构)
- [安装指南](#安装指南)
- [使用指南](#使用指南)
- [工具映射](#工具映射)
- [测试指南](#测试指南)
- [开发指南](#开发指南)
- [常见问题](#常见问题)
- [贡献指南](#贡献指南)
- [许可证](#许可证)

## 概述

Superpowers for iFlow CLI 是一个将 Superpowers 技能库系统移植到 iFlow CLI 平台的项目。Superpowers 是一个为 AI 代码助手提供完整软件开发工作流的技能库系统，通过可组合的"技能"（skills）和初始指令，确保 AI 代理遵循软件开发的最佳实践。

### 核心特性

- ✅ **经过验证的工作流程**：基于 Superpowers v4.3.1，已在多个平台验证
- ✅ **强制性的最佳实践**：通过硬性门禁和红色标志确保合规
- ✅ **完整的开发工作流**：从需求分析到代码审查的端到端流程
- ✅ **高质量文档**：每个技能都有详细的指南和示例
- ✅ **跨平台支持**：支持 Windows、Linux 和 macOS
- ✅ **可扩展架构**：易于添加新技能和平台

### 项目目标

- 🎯 将 Superpowers 的核心技能移植到 iFlow CLI
- 🎯 确保技能与 iFlow CLI 的工具集完全兼容
- 🎯 提供完整的技术文档和使用说明
- 🎯 创建可扩展的技能系统架构

## 快速开始

### 前置要求

- iFlow CLI v0.4.11 或更高版本
- 已完成身份验证
- 了解基本的斜杠命令使用

### 安装技能

1. **克隆项目**

```bash
git clone https://github.com/your-username/superpowers-iflow.git
cd superpowers-iflow
```

2. **复制技能到 iFlow CLI 技能目录**

```bash
# 全局安装
cp -r skills/* ~/.iflow/skills/

# 或项目安装
cp -r skills/* .iflow/skills/
```

3. **刷新技能列表**

```bash
/skills refresh
```

4. **验证安装**

```bash
/skills list
```

你应该看到已安装的技能：
- test-driven-development
- systematic-debugging

### 使用技能

```bash
# 调用 Test-Driven Development 技能
skill: "test-driven-development"

# 调用 Systematic Debugging 技能
skill: "systematic-debugging"
```

## 已移植的技能

### 1. Test-Driven Development (TDD)

**描述**: 强制执行 RED-GREEN-REFACTOR TDD 循环，确保代码生成包含测试。

**版本**: 1.0.0

**作者**: iFlow CLI (port from Superpowers by obra)

**核心原则**: 先写测试，看着它失败，编写最小代码通过。

**主要功能**:
- RED-GREEN-REFACTOR 循环
- 铁律：没有失败测试的生产代码
- 工具映射到 iFlow CLI
- 完整的使用示例

**文件位置**: `skills/test-driven-development/`

**使用场景**:
- 新功能开发
- Bug 修复
- 代码重构
- 行为变更

**详细文档**: [test-driven-development/README.md](skills/test-driven-development/README.md)

### 2. Systematic Debugging

**描述**: 四阶段根因分析调试流程，系统性地诊断和修复问题。

**版本**: 1.0.0

**作者**: iFlow CLI (port from Superpowers by obra)

**核心原则**: 在尝试修复之前始终找到根本原因。症状修复就是失败。

**主要功能**:
- 四阶段调试流程（根本原因调查、模式分析、假设测试、实现）
- 铁律：没有根本原因调查就不能修复
- 工具映射到 iFlow CLI
- 完整的使用示例

**文件位置**: `skills/systematic-debugging/`

**使用场景**:
- 测试失败
- 生产环境 Bug
- 意外行为
- 性能问题
- 构建失败
- 集成问题

**详细文档**: [systematic-debugging/README.md](skills/systematic-debugging/README.md)

## 技术架构

### 技能格式

每个技能遵循 iFlow CLI 的技能格式：

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

## 使用方式
[使用示例]

## 实现细节
[详细说明]

## 工具映射
[工具映射表]
```

### 目录结构

```
superpowers-iflow/
├── skills/                    # 技能目录
│   ├── test-driven-development/
│   │   ├── SKILL.md          # 技能主文件
│   │   ├── tests/            # 测试脚本
│   │   │   └── test-basic.ps1
│   │   └── examples/         # 使用示例
│   │       └── README.md
│   └── systematic-debugging/
│       ├── SKILL.md
│       ├── tests/
│       │   └── test-basic.ps1
│       └── examples/
│           └── README.md
├── planning/                  # 项目规划文档
│   ├── PROJECT.md            # 项目愿景
│   ├── REQUIREMENTS.md       # 需求定义
│   ├── ROADMAP.md            # 路线图
│   ├── STATE.md              # 当前状态
│   └── phases/               # 各阶段文档
│       └── 01-core-skills-tdd-debugging/
├── docs/                      # 技术文档
│   ├── ARCHITECTURE.md       # 架构设计
│   ├── INTEGRATION.md        # 集成指南
│   └── MIGRATION.md          # 迁移指南
└── README.md                  # 本文件
```

### 工具映射

Superpowers 工具映射到 iFlow CLI 工具：

| Superpowers | iFlow CLI | 说明 |
|-------------|-----------|------|
| `Read` | `read_file` | 读取文件内容 |
| `Write` | `write_file` | 写入文件内容 |
| `Edit` | `replace` | 替换文本（需要精确的 old_string 和 new_string） |
| `Bash` | `run_shell_command` | 执行命令 |
| `Task` | `task` | 派遣子代理（需要指定 subagent_type） |
| `Skill` | `Skill` | 调用技能 |

详细说明见 [工具映射](#工具映射)。

## 安装指南

### 全局安装

```bash
# 复制技能到全局技能目录
cp -r skills/* ~/.iflow/skills/

# 刷新技能列表
/skills refresh

# 验证安装
/skills list
```

### 项目安装

```bash
# 复制技能到项目技能目录
cp -r skills/* .iflow/skills/

# 刷新技能列表
/skills refresh

# 验证安装
/skills list
```

### Windows 系统

```powershell
# 复制技能到全局技能目录
Copy-Item -Recurse skills\* $env:USERPROFILE\.iflow\skills\

# 刷新技能列表
/skills refresh

# 验证安装
/skills list
```

## 使用指南

### 调用技能

```bash
# 方法 1: 使用 skill 命令
skill: "test-driven-development"

# 方法 2: 在提示中引用
使用 test-driven-development 技能来实现这个功能
```

### Test-Driven Development 技能使用

```bash
# 1. 调用技能
skill: "test-driven-development"

# 2. 遵循 RED-GREEN-REFACTOR 循环

# RED: 编写失败的测试
write_file({
  file_path: "/path/to/test.test.ts",
  content: "test('example', () => { expect(true).toBe(true); });"
});

# 验证 RED
run_shell_command({
  command: "npm test",
  description: "验证测试失败"
});

# GREEN: 编写最小代码
write_file({
  file_path: "/path/to/code.ts",
  content: "export function example() { return true; }"
});

# 验证 GREEN
run_shell_command({
  command: "npm test",
  description: "验证测试通过"
});

# REFACTOR: 清理代码（如果需要）
# 重复下一个测试
```

详细使用示例见 [test-driven-development/examples/README.md](skills/test-driven-development/examples/README.md)。

### Systematic Debugging 技能使用

```bash
# 1. 调用技能
skill: "systematic-debugging"

# 2. 遵循四个阶段

# Phase 1: 根本原因调查
read_file({ absolute_path: "/path/to/error.log" });
run_shell_command({ command: "npm test", description: "重现错误" });

# Phase 2: 模式分析
read_file({ absolute_path: "/path/to/working-example.ts" });
read_file({ absolute_path: "/path/to/broken-code.ts" });

# Phase 3: 假设和测试
# 形成假设，最小化测试

# Phase 4: 实现
# 使用 test-driven-development 技能创建失败的测试
# 实现修复
# 验证修复
```

详细使用示例见 [systematic-debugging/examples/README.md](skills/systematic-debugging/examples/README.md)。

## 工具映射

### 完整映射表

| Superpowers | iFlow CLI | 参数说明 | 使用示例 |
|-------------|-----------|----------|----------|
| `Read` | `read_file` | `absolute_path` | `read_file({ absolute_path: "/path/to/file.ts" })` |
| `Write` | `write_file` | `file_path`, `content` | `write_file({ file_path: "/path/to/file.ts", content: "// code" })` |
| `Edit` | `replace` | `file_path`, `instruction`, `old_string`, `new_string` | `replace({ file_path: "/path/to/file.ts", instruction: "fix", old_string: "old", new_string: "new" })` |
| `Bash` | `run_shell_command` | `command`, `description` | `run_shell_command({ command: "npm test", description: "run tests" })` |
| `Task` | `task` | `subagent_type`, `description`, `prompt` | `task({ subagent_type: "general-purpose", description: "task", prompt: "do this" })` |
| `Skill` | `Skill` | `skill` | `Skill({ skill: "test-driven-development" })` |

### 工具适配说明

#### Edit → replace

Superpowers 的 `Edit` 工具更灵活，支持多种编辑方式。iFlow CLI 的 `replace` 工具需要精确的 `old_string` 和 `new_string`。

**使用建议**：
- 确保 `old_string` 精确匹配要替换的文本
- 包含足够的上下文（至少 3 行）
- 使用 `read_file` 先查看文件内容

#### Task → task

Superpowers 支持自定义代理定义。iFlow CLI 使用预定义的代理类型：

- `general-purpose` - 通用代理
- `plan-agent` - 规划代理
- `explore-agent` - 探索代理
- `frontend-tester` - 前端测试代理

**使用建议**：
- 在 `prompt` 中明确指定代理的角色和任务
- 使用 `useContext: true` 传递上下文

## 测试指南

### 运行技能测试

每个技能都包含测试脚本：

```bash
# Test-Driven Development 技能测试
powershell.exe -ExecutionPolicy Bypass -File skills/test-driven-development/tests/test-basic.ps1

# Systematic Debugging 技能测试
powershell.exe -ExecutionPolicy Bypass -File skills/systematic-debugging/tests/test-basic.ps1
```

### 测试结果

所有测试应该通过：

- Test-Driven Development: 10/10 tests passed
- Systematic Debugging: 14/14 tests passed

### 编写新测试

遵循现有测试的结构：

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

## 开发指南

### 创建新技能

1. **创建技能目录结构**

```bash
mkdir skills/new-skill
mkdir skills/new-skill/tests
mkdir skills/new-skill/examples
```

2. **创建技能主文件**

```markdown
---
name: new-skill
description: Brief description
version: 1.0.0
author: iFlow CLI
category: Development
tags: tag1,tag2
---

# Skill Title

## 概述
[简短描述]

## 使用方式
[使用示例]

## 工具映射
[工具映射表]
```

3. **创建测试脚本**

```powershell
# skills/new-skill/tests/test-basic.ps1
$SkillPath = "R:\test2\iFlow-Powers\skills\new-skill"
# ... 测试代码
```

4. **创建使用示例**

```markdown
# skills/new-skill/examples/README.md
# ... 使用示例
```

5. **运行测试**

```bash
powershell.exe -ExecutionPolicy Bypass -File skills/new-skill/tests/test-basic.ps1
```

### 移植 Superpowers 技能

1. **读取原始技能**

```bash
read_file({ absolute_path: "/path/to/superpowers/skills/skill-name/SKILL.md" })
```

2. **分析技能结构**

识别需要适配的部分：
- YAML frontmatter
- 工具调用
- 子代理调用
- 上下文引用

3. **创建 iFlow CLI 版本**

遵循 iFlow CLI 的技能格式，添加工具映射。

4. **创建测试和示例**

确保技能可以正确使用。

5. **验证技能**

运行测试确保所有功能正常。

## 常见问题

### Q: 如何在 iFlow CLI 中调用技能？

A: 使用 `skill: "skill-name"` 命令或在提示中引用技能。

### Q: 技能之间可以组合使用吗？

A: 是的，技能可以组合使用。例如，Systematic Debugging 技能会建议使用 Test-Driven Development 技能创建失败的测试。

### Q: 如何解决编码问题？

A: 使用 UTF8 编码读取文件：

```powershell
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
```

### Q: 如何映射 Superpowers 的 Edit 工具？

A: 使用 iFlow CLI 的 `replace` 工具，确保 `old_string` 精确匹配。

### Q: 如何创建自定义代理？

A: iFlow CLI 不支持自定义代理定义。使用预定义的代理类型，在 `prompt` 中明确指定角色。

## 贡献指南

欢迎贡献！请遵循以下步骤：

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

### 贡献规范

- 遵循现有代码风格
- 添加测试用例
- 更新文档
- 提交清晰的提交信息

## 许可证

本项目采用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

## 致谢

- [Superpowers](https://github.com/obra/superpowers) - 原始项目
- [iFlow CLI](https://platform.iflow.cn) - 目标平台
- 所有贡献者

---

**版本**: 1.0.0
**最后更新**: 2026-03-05