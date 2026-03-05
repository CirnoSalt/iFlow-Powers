# Subagent-Driven Development - 使用示例

## 简单示例（简单任务）

假设您有一个简单的实施计划，包含 3 个独立任务。

### 步骤

1. **读取计划并提取任务**
   ```powershell
   # 读取计划文件
   $planContent = Get-Content "docs/plans/simple-plan.md" -Raw

   # 提取所有任务
   # 任务 1：实现用户认证
   # 任务 2：实现用户配置文件
   # 任务 3：实现用户设置

   # 创建 TodoWrite
   # 使用 todo_write 工具创建待办事项列表
   ```

2. **执行任务 1：实现用户认证**

   a. 分发实现者子代理
   ```powershell
   # 使用 task 工具分发 general-purpose 子代理
   # 提供 task 描述和上下文
   ```

   b. 实现者子代理实现、测试、提交、自我审查
   ```
   实现完成：
   - 实现了什么：用户认证功能（登录、注册、登出）
   - 测试结果：5 tests passed, 0 failed
   - 自我审查发现：所有测试通过，代码质量良好
   - 提交的更改：feat: implement user authentication
   ```

   c. 分发规范审查者子代理
   ```powershell
   # 使用 task 工具分发 plan-agent 子代理
   # 提供规范/要求和实现摘要
   ```

   d. 规范审查者审查
   ```
   ✅ 规范合规 - 所有要求已满足，没有额外内容
   ```

   e. 分发代码质量审查者子代理
   ```powershell
   # 使用 task 工具分发 general-purpose 子代理
   # 提供实现摘要和测试结果
   ```

   f. 代码质量审查者审查
   ```
   优势：清晰的架构、真实的测试
   问题：无
   评估：批准
   ```

   g. 标记任务 1 完成
   ```powershell
   # 使用 todo_write 工具标记任务为 completed
   ```

3. **执行任务 2 和 3**

   重复步骤 2 的过程，为任务 2 和 3。

4. **最终代码审查**

   分发最终的代码审查者子代理进行整个实现的审查。

5. **完成开发**

   使用 Skill 工具调用 finishing-a-development-branch。

## 复杂示例（需要审查循环）

假设您正在执行一个复杂的计划，需要审查循环。

### 步骤

1. **读取计划并提取任务**

   （同简单示例）

2. **执行任务 1：实现搜索功能**

   a. 分发实现者子代理
   ```
   实现完成：
   - 实现了什么：搜索功能（基础搜索、过滤、排序）
   - 测试结果：8 tests passed, 0 failed
   - 自我审查发现：所有测试通过，代码质量良好
   - 提交的更改：feat: implement search functionality
   ```

   b. 分发规范审查者子代理
   ```
   ❌ 问题：
   - 缺少：规范要求报告进度每 100 项，但实现没有此功能
   - 多余：添加了 --json 标志，但规范未要求
   ```

   c. 实现者子代理修复问题
   ```
   修复完成：
   - 移除了 --json 标志
   - 添加了进度报告功能
   - 测试结果：9 tests passed, 0 failed
   - 提交的更改：fix: remove json flag, add progress reporting
   ```

   d. 规范审查者再次审查
   ```
   ✅ 规范合规 - 所有要求已满足，没有额外内容
   ```

   e. 分发代码质量审查者子代理
   ```
   优势：清晰的架构、真实的测试
   问题：
   - 重要：魔法数字（100）应该提取为常量
   评估：未批准
   ```

   f. 实现者子代理修复问题
   ```
   修复完成：
   - 提取了 PROGRESS_INTERVAL 常量
   - 测试结果：9 tests passed, 0 failed
   - 提交的更改：refactor: extract PROGRESS_INTERVAL constant
   ```

   g. 代码质量审查者再次审查
   ```
   优势：清晰的架构、真实的测试、良好的常量提取
   问题：无
   评估：批准
   ```

   h. 标记任务 1 完成

3. **执行剩余任务**

   重复类似的过程，为任务 2 和 3。

4. **最终代码审查**

5. **完成开发**

## 最佳实践

1. **提供完整的任务文本和上下文**：不要让子代理读取计划文件
2. **使用正确的子代理类型**：
   - 实现者：`general-purpose`
   - 规范审查者：`plan-agent`
   - 代码质量审查者：`general-purpose`
3. **遵循审查顺序**：先规范合规性，后代码质量
4. **不要跳过审查循环**：如果审查者发现问题，实现者必须修复并重新审查
5. **回答子代理问题**：在让他们继续之前，清晰完整地回答
6. **不要并行分发多个实现子代理**：避免冲突

## 工具映射

| Superpowers 工具 | iFlow CLI 工具 | 用途 |
|------------------|----------------|------|
| `Read` | `read_file` | 读取计划文件 |
| `TodoWrite` | `todo_write` | 创建/更新待办事项列表 |
| `TodoRead` | `todo_read` | 读取待办事项列表 |
| `Task` | `task` | 分发子代理 |
| `Skill` | `Skill` | 调用子技能 |

## 子代理类型映射

| Superpowers 子代理 | iFlow CLI 子代理类型 |
|-------------------|---------------------|
| `implementer` | `general-purpose` |
| `spec-reviewer` | `plan-agent` |
| `code-quality-reviewer` | `general-purpose` |
| `code-reviewer` | `general-purpose` |

## 注意事项

1. **不要在 main/master 分支上开始实现**，除非有明确的用户同意
2. **使用正确的子代理类型**：确保使用 iFlow CLI 支持的子代理类型
3. **提供完整的上下文**：不要让子代理读取计划文件
4. **遵循审查顺序**：先规范合规性，后代码质量
5. **不要跳过审查循环**：如果审查者发现问题，必须修复并重新审查
6. **回答子代理问题**：在让他们继续之前，清晰完整地回答