# Writing Plans 技能使用示例

本文档提供了 Writing Plans 技能的使用示例。

## 基本用法

### 调用技能

在 iFlow CLI 中，你可以通过以下方式调用 Writing Plans 技能：

```
使用 writing-plans 技能来创建实施计划
```

或者：

```
skill: writing-plans
```

### 什么时候使用？

当你有规范或需求用于多步骤任务时，在接触代码之前使用此技能。

典型使用场景：
- 在 brainstorming 技能完成设计之后
- 在实施新功能之前
- 在重构代码之前
- 在修复复杂 bug 之前

## 完整工作流程示例

### 示例 1：从 Brainstorming 到 Writing Plans

**步骤 1：使用 Brainstorming 技能**

**用户**：
```
我想添加一个用户评论功能
```

**AI**（使用 brainstorming 技能）：
```
我正在使用 brainstorming 技能来创建设计。

让我先检查当前项目结构...
[探索项目上下文]

评论功能应该在哪些页面上可用？
```

[Brainstorming 技能继续...]

**步骤 2：Brainstorming 完成**

**AI**：
```
设计已完成并保存到 `docs/plans/2026-03-05-user-comments-design.md`。

现在让我调用 writing-plans 技能来创建实施计划...
[使用 Skill 调用 writing-plans 技能]
```

**步骤 3：使用 Writing Plans 技能**

**AI**（使用 writing-plans 技能）：
```
我正在使用 writing-plans 技能来创建实施计划。

让我阅读设计文档...
[使用 read_file 阅读设计文档]

好的，我现在创建实施计划...

[使用 write_file 编写计划到 docs/plans/2026-03-05-user-comments.md]

计划已完成并保存到 `docs/plans/2026-03-05-user-comments.md`。两种执行选项：

**1. 子代理驱动（此会话）** - 我为每个任务调度新的子代理，在任务之间审查，快速迭代

**2. 并行会话（单独）** - 在工作树中打开新会话，使用 executing-plans，使用检查点批量执行

你选择哪种方式？
```

## 计划文档示例

### 简单计划：联系我们按钮

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
git add "src/components/ContactButton.tsx" "src/components/__tests__/ContactButton.test.tsx"
git commit -m "feat: add ContactButton component"
```

[更多任务...]
```

### 复杂计划：用户认证系统

```markdown
# 用户认证系统实施计划

> **给 Claude 的：** 所需子技能：使用 writing-plans:executing-plans 来逐步实施此计划。

**目标：** 实现支持电子邮件/密码和社交登录（Google、GitHub）的用户认证系统。

**架构：** 使用 Firebase Authentication，创建认证服务、登录/注册页面和用户状态管理。

**技术栈：** React, TypeScript, Firebase, React Query

---

### 任务 1: 设置 Firebase

**文件：**
- 创建：`src/firebase/config.ts`
- 修改：`src/index.tsx:1-10`
- 测试：`src/firebase/__tests__/config.test.ts`

**步骤 1：编写失败的测试**

```ts
import { auth } from '../config'

describe('Firebase Config', () => {
  it('initializes auth', () => {
    expect(auth).toBeDefined()
  })
})
```

**步骤 2：运行测试以验证它失败**

运行：`npm test src/firebase/__tests__/config.test.ts`
预期：FAIL 并显示 "auth is not defined"

**步骤 3：编写最少的实现**

```ts
import { initializeApp } from 'firebase/app'
import { getAuth } from 'firebase/auth'

const firebaseConfig = {
  apiKey: process.env.REACT_APP_FIREBASE_API_KEY,
  authDomain: process.env.REACT_APP_FIREBASE_AUTH_DOMAIN,
  projectId: process.env.REACT_APP_FIREBASE_PROJECT_ID,
}

const app = initializeApp(firebaseConfig)
export const auth = getAuth(app)
```

**步骤 4：运行测试以验证它通过**

运行：`npm test src/firebase/__tests__/config.test.ts`
预期：PASS

**步骤 5：提交**

```powershell
git add "src/firebase/config.ts" "src/firebase/__tests__/config.test.ts"
git commit -m "feat: initialize Firebase auth"
```

[更多任务...]
```

## 执行选项

### 选项 1：子代理驱动（此会话）

**工作流程：**
1. AI 阅读第一个任务
2. AI 调度子代理执行任务
3. AI 审查子代理的结果
4. AI 提供反馈或批准
5. 重复下一个任务

**优点：**
- 快速迭代
- 实时反馈
- AI 可以在任务之间调整

**缺点：**
- 需要在同一会话中
- 可能需要更多上下文切换

**示例：**

**AI**：
```
让我开始执行计划...

**任务 1: 创建 ContactButton 组件**

我将调度一个子代理来执行此任务...
[使用 task 工具调用 general-purpose 子代理]

子代理完成了任务。让我审查结果...

看起来不错！让我继续下一个任务...

**任务 2: 创建 ContactForm 组件**

...
```

### 选项 2：并行会话（单独）

**工作流程：**
1. 用户打开新会话
2. 用户加载计划文档
3. 用户请求执行计划
4. AI 逐步执行计划
5. 用户在检查点审查进度

**优点：**
- 独立的执行环境
- 可以暂停和恢复
- 更清晰的进度追踪

**缺点：**
- 需要打开新会话
- 需要手动管理进度

**示例：**

**AI**：
```
计划已完成并保存到 `docs/plans/2026-03-05-user-comments.md`。

要在单独的会话中执行此计划，请：

1. 在工作树中打开新会话
2. 使用以下命令：
   ```
   skill: writing-plans:executing-plans
   计划文档：docs/plans/2026-03-05-user-comments.md
   ```
3. AI 将逐步执行计划

你选择哪种方式？
```

## 关键要点

1. **小任务粒度**：每个步骤应该是 2-5 分钟的动作
2. **精确路径**：总是使用精确的文件路径
3. **完整代码**：提供完整的代码示例
4. **预期输出**：说明每个命令的预期输出
5. **TDD 方法**：先写测试，再写实现
6. **频繁提交**：每个任务后提交
7. **引用技能**：使用 @ 语法引用相关技能

## 常见错误

### 错误 1：任务太大

**错误示例：**
```
### 任务 1: 创建评论系统

**步骤：**
1. 创建数据库模型
2. 创建 API 端点
3. 创建前端组件
4. 编写测试
5. 部署
```

**正确做法：**
```
### 任务 1: 创建评论数据库模型

**步骤：**
1. 编写迁移文件
2. 运行迁移
3. 验证表创建

### 任务 2: 创建评论 API 端点

**步骤：**
1. 编写失败的测试
2. 创建端点
3. 运行测试
```

### 错误 2：不完整的代码

**错误示例：**
```
**步骤 3：添加验证**

添加表单验证逻辑。
```

**正确做法：**
```
**步骤 3：添加验证**

```tsx
function validateForm(data: FormData): ValidationResult {
  if (!data.name || data.name.length < 2) {
    return { valid: false, error: '姓名至少需要 2 个字符' }
  }
  if (!data.email || !isValidEmail(data.email)) {
    return { valid: false, error: '无效的电子邮件地址' }
  }
  return { valid: true }
}
```
```

### 错误 3：缺少预期输出

**错误示例：**
```
**步骤 2：运行测试**

运行：`npm test`
```

**正确做法：**
```
**步骤 2：运行测试**

运行：`npm test src/components/__tests__/ContactButton.test.tsx`
预期：FAIL 并显示 "ContactButton not found"
```

## 资源

- [Writing Plans 技能主文件](../SKILL.md)
- [Brainstorming 技能](../brainstorming/SKILL.md)
- [项目文档](../../../docs/)
- [TDD 技能](../test-driven-development/SKILL.md)