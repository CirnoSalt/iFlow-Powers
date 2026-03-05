---
name: writing-plans
description: 在接触代码之前，当你有规范或需求用于多步骤任务时使用此技能
version: 1.0.0
author: iFlow CLI
category: Planning
tags: planning,implementation,tasks
---

# Writing Plans

## 概述

编写全面的实施计划，假设工程师对我们的代码库零上下文，品味存疑。文档化他们需要知道的一切：每个任务要触摸哪些文件、代码、测试、他们可能需要检查的文档、如何测试它。给他们整个计划作为小任务。DRY。YAGNI。TDD。频繁提交。

假设他们是有技能的开发人员，但几乎不了解我们的工具集或问题领域。假设他们不太了解好的测试设计。

**开始时宣布**："我正在使用 writing-plans 技能来创建实施计划。"

**上下文**：这应该在专用的工作树中运行（由 brainstorming 技能创建）。

**将计划保存到**：`docs/plans/YYYY-MM-DD-<feature-name>.md`

## 小任务粒度

**每个步骤是一个动作（2-5 分钟）：**
- "编写失败的测试" - 步骤
- "运行它以确保它失败" - 步骤
- "编写最少的代码以使测试通过" - 步骤
- "运行测试并确保它们通过" - 步骤
- "提交" - 步骤

## 计划文档头部

**每个计划必须以此头部开始：**

```markdown
# [功能名称] 实施计划

> **给 Claude 的：** 所需子技能：使用 writing-plans:executing-plans 来逐步实施此计划。

**目标：** [一句话描述此计划构建的内容]

**架构：** [关于方法的 2-3 句话]

**技术栈：** [关键技术/库]

---
```

## 任务结构

````markdown
### 任务 N: [组件名称]

**文件：**
- 创建：`exact/path/to/file.py`
- 修改：`exact/path/to/existing.py:123-145`
- 测试：`tests/exact/path/to/test.py`

**步骤 1：编写失败的测试**

```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```

**步骤 2：运行测试以验证它失败**

运行：`pytest tests/path/test.py::test_name -v`
预期：FAIL 并显示 "function not defined"

**步骤 3：编写最少的实现**

```python
def function(input):
    return expected
```

**步骤 4：运行测试以验证它通过**

运行：`pytest tests/path/test.py::test_name -v`
预期：PASS

**步骤 5：提交**

```powershell
# PowerShell
git add tests/path/test.py src/path/file.py
git commit -m "feat: add specific feature"

# 或者使用 Git Bash
git add "tests/path/test.py" "src/path/file.py"
git commit -m "feat: add specific feature"
```
````

## 记住

- 总是使用精确的文件路径
- 计划中的完整代码（不是"添加验证"）
- 带有预期输出的精确命令
- 使用 @ 语法引用相关技能
- DRY，YAGNI，TDD，频繁提交

## 执行交接

保存计划后，提供执行选择：

**"计划已完成并保存到 `docs/plans/<filename>.md`。两种执行选项：**

**1. 子代理驱动（此会话）** - 我为每个任务调度新的子代理，在任务之间审查，快速迭代

**2. 并行会话（单独）** - 在工作树中打开新会话，使用 executing-plans，使用检查点批量执行

**你选择哪种方式？"**

**如果选择子代理驱动：**
- **所需子技能：** 使用 writing-plans:subagent-driven-development
- 留在此会话中
- 每个任务使用新的子代理 + 代码审查

**如果选择并行会话：**
- 指导他们在工作树中打开新会话
- **所需子技能：** 新会话使用 writing-plans:executing-plans

## iFlow CLI 特定说明

### 工具调用

此技能使用以下 iFlow CLI 工具：

- `write_file` — 保存计划文档
- `Skill` — 调用 executing-plans 或 subagent-driven-development 技能

### Git 命令

在 Windows 上提交代码时，使用以下命令：

**PowerShell：**
```powershell
git add "tests/path/test.py" "src/path/file.py"
git commit -m "feat: add specific feature"
```

**Git Bash：**
```bash
git add "tests/path/test.py" "src/path/file.py"
git commit -m "feat: add specific feature"
```

### 文件路径

此技能使用 Unix 风格的路径（`/`），这在 Windows 上也受 Git 和大多数现代工具的支持。

### 子技能状态

**重要：** 以下子技能尚未移植到 iFlow CLI，将在后续阶段处理：

- `executing-plans`：批量执行计划
- `subagent-driven-development`：子代理驱动的开发流程

**临时执行方式：**

如果子技能不可用，可以手动执行计划：

1. 逐个阅读任务
2. 按照步骤执行每个任务
3. 在每个任务后验证结果
4. 继续下一个任务

## 示例

### 简单示例：添加新按钮

```markdown
# 联系我们按钮实施计划

> **给 Claude 的：** 所需子技能：使用 writing-plans:executing-plans 来逐步实施此计划。

**目标：** 在导航栏添加一个联系我们按钮，打开联系表单模态框。

**架构：** 使用现有的 Modal 组件和 Button 组件，创建新的 ContactForm 组件。

**技术栈：** React, TypeScript, Tailwind CSS

---

### 任务 1: 创建 ContactButton 组件

**文件：**
- 创建：`src/components/ContactButton.tsx`
- 测试：`src/components/__tests__/ContactButton.test.tsx`

**步骤 1：编写失败的测试**

```tsx
import { render, screen } from '@testing-library/react'
import { ContactButton } from '../ContactButton'

describe('ContactButton', () => {
  it('renders correctly', () => {
    render(<ContactButton />)
    expect(screen.getByText('联系我们')).toBeInTheDocument()
  })
})
```

**步骤 2：运行测试以验证它失败**

运行：`npm test src/components/__tests__/ContactButton.test.tsx`
预期：FAIL 并显示 "ContactButton not found"

**步骤 3：编写最少的实现**

```tsx
import { Button } from './Button'

export function ContactButton() {
  return (
    <Button onClick={() => {}}>
      联系我们
    </Button>
  )
}
```

**步骤 4：运行测试以验证它通过**

运行：`npm test src/components/__tests__/ContactButton.test.tsx`
预期：PASS

**步骤 5：提交**

```powershell
# PowerShell
git add "src/components/ContactButton.tsx" "src/components/__tests__/ContactButton.test.tsx"
git commit -m "feat: add ContactButton component"

# 或者使用 Git Bash
git add "src/components/ContactButton.tsx" "src/components/__tests__/ContactButton.test.tsx"
git commit -m "feat: add ContactButton component"
```

### 任务 2: 创建 ContactForm 组件

**文件：**
- 创建：`src/components/ContactForm.tsx`
- 测试：`src/components/__tests__/ContactForm.test.tsx`

**步骤 1：编写失败的测试**

```tsx
import { render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { ContactForm } from '../ContactForm'

describe('ContactForm', () => {
  it('renders form fields', () => {
    render(<ContactForm />)
    expect(screen.getByLabelText('姓名')).toBeInTheDocument()
    expect(screen.getByLabelText('电子邮件')).toBeInTheDocument()
    expect(screen.getByLabelText('消息')).toBeInTheDocument()
  })
})
```

**步骤 2：运行测试以验证它失败**

运行：`npm test src/components/__tests__/ContactForm.test.tsx`
预期：FAIL 并显示 "ContactForm not found"

**步骤 3：编写最少的实现**

```tsx
export function ContactForm() {
  return (
    <form>
      <label>
        姓名
        <input name="name" type="text" required />
      </label>
      <label>
        电子邮件
        <input name="email" type="email" required />
      </label>
      <label>
        消息
        <textarea name="message" required />
      </label>
      <button type="submit">提交</button>
    </form>
  )
}
```

**步骤 4：运行测试以验证它通过**

运行：`npm test src/components/__tests__/ContactForm.test.tsx`
预期：PASS

**步骤 5：提交**

```powershell
# PowerShell
git add "src/components/ContactForm.tsx" "src/components/__tests__/ContactForm.test.tsx"
git commit -m "feat: add ContactForm component"

# 或者使用 Git Bash
git add "src/components/ContactForm.tsx" "src/components/__tests__/ContactForm.test.tsx"
git commit -m "feat: add ContactForm component"
```

### 任务 3: 在导航栏中集成 ContactButton

**文件：**
- 修改：`src/components/Navbar.tsx:45-50`

**步骤 1：编写失败的测试**

```tsx
import { render, screen } from '@testing-library/react'
import { Navbar } from '../Navbar'

describe('Navbar', () => {
  it('renders ContactButton', () => {
    render(<Navbar />)
    expect(screen.getByText('联系我们')).toBeInTheDocument()
  })
})
```

**步骤 2：运行测试以验证它失败**

运行：`npm test src/components/__tests__/Navbar.test.tsx`
预期：FAIL 并显示 "联系我们 not found"

**步骤 3：编写最少的实现**

在 Navbar.tsx 中，在 Login 按钮旁边添加：

```tsx
<ContactButton />
```

**步骤 4：运行测试以验证它通过**

运行：`npm test src/components/__tests__/Navbar.test.tsx`
预期：PASS

**步骤 5：提交**

```powershell
# PowerShell
git add "src/components/Navbar.tsx"
git commit -m "feat: integrate ContactButton in Navbar"

# 或者使用 Git Bash
git add "src/components/Navbar.tsx"
git commit -m "feat: integrate ContactButton in Navbar"
```
```

## 常见问题

### Q: 每个任务应该多长？

A: 每个步骤应该是 2-5 分钟的动作。如果一个任务需要更长时间，将其分解为更小的任务。

### Q: 我应该包含哪些信息？

A: 包括：
- 精确的文件路径
- 完整的代码（不是"添加验证"）
- 带有预期输出的精确命令
- 测试说明

### Q: 如何处理复杂的任务？

A: 将复杂任务分解为多个小任务。每个任务应该是一个清晰的动作。

### Q: 子技能何时可用？

A: executing-plans 和 subagent-driven-development 技能将在后续阶段移植。目前，可以使用手动执行方式。

### Q: 如何引用其他技能？

A: 使用 @ 语法：`@test-driven-development` 或 `@systematic-debugging`。

## 最佳实践

1. **保持小任务**：每个步骤 2-5 分钟
2. **精确路径**：总是使用精确的文件路径
3. **完整代码**：提供完整的代码示例
4. **预期输出**：说明每个命令的预期输出
5. **频繁提交**：每个任务后提交
6. **TDD 方法**：先写测试，再写实现
7. **YAGNI**：不要添加不必要的功能
8. **DRY**：不要重复代码