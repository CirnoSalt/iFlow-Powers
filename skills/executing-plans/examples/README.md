# Executing Plans - 使用示例

## 简单示例（执行简单计划）

假设您有一个简单的实施计划，包含 5 个任务。

### 步骤

1. **加载和审查计划**
   ```powershell
   # 读取计划文件
   $planContent = Get-Content "docs/plans/simple-plan.md" -Raw

   # 批判性审查
   # 检查计划是否清晰、完整、可行
   ```

   审查结果：计划清晰，没有顾虑

2. **创建 TodoWrite**
   ```powershell
   # 使用 todo_write 工具创建待办事项列表
   # 包含所有 5 个任务
   ```

3. **执行第一批（前 3 个任务）**

   任务 1：创建基础数据模型
   ```powershell
   # 标记为 in_progress
   # 执行任务步骤
   # 运行验证
   # 标记为 completed
   ```

   任务 2：实现 API 端点
   ```powershell
   # 标记为 in_progress
   # 执行任务步骤
   # 运行验证
   # 标记为 completed
   ```

   任务 3：添加单元测试
   ```powershell
   # 标记为 in_progress
   # 执行任务步骤
   # 运行验证
   # 标记为 completed
   ```

4. **报告**
   ```
   已实现：
   - 任务 1：创建基础数据模型（3 个模型类）
   - 任务 2：实现 API 端点（5 个端点）
   - 任务 3：添加单元测试（15 个测试）

   验证输出：
   - npm test: 15 tests passed, 0 failed

   准备好接受反馈。
   ```

5. **继续下一批次**

   任务 4：添加集成测试
   ```powershell
   # 标记为 in_progress
   # 执行任务步骤
   # 运行验证
   # 标记为 completed
   ```

   任务 5：更新文档
   ```powershell
   # 标记为 in_progress
   # 执行任务步骤
   # 运行验证
   # 标记为 completed
   ```

6. **完成开发**
   ```
   所有任务完成。
   使用 finishing-a-development-branch 技能来完成工作。
   ```

## 复杂示例（遇到阻塞）

假设您正在执行一个复杂的计划，遇到了阻塞。

### 步骤

1. **加载和审查计划**
   ```powershell
   # 读取计划文件
   $planContent = Get-Content "docs/plans/complex-plan.md" -Raw

   # 批判性审查
   # 发现潜在问题：缺少依赖信息
   ```

   向合作伙伴提出：
   ```
   我注意到计划中缺少关于所需依赖的信息。
   具体来说，任务 3 需要一个外部库，但没有指定版本。
   这可能导致兼容性问题。
   ```

2. **等待反馈**

   合作伙伴更新计划，添加依赖信息。

3. **重新审查计划**
   ```powershell
   # 重新阅读更新的计划
   $planContent = Get-Content "docs/plans/complex-plan.md" -Raw

   # 批判性审查
   # 现在计划清晰、完整、可行
   ```

4. **创建 TodoWrite**
   ```powershell
   # 使用 todo_write 工具创建待办事项列表
   # 包含所有 8 个任务
   ```

5. **执行第一批（前 3 个任务）**

   任务 1：设置项目结构
   ```powershell
   # 标记为 in_progress
   # 执行任务步骤
   # 运行验证
   # 标记为 completed
   ```

   任务 2：安装依赖
   ```powershell
   # 标记为 in_progress
   # 执行任务步骤
   # 运行验证
   # 标记为 completed
   ```

   任务 3：实现核心功能
   ```powershell
   # 标记为 in_progress
   # 执行任务步骤
   # 运行验证 - 失败！
   ```

   验证失败：
   ```
   测试失败：Test 3.2 - 核心功能未正确处理边界情况
   错误：Expected X, got Y
   ```

6. **停止并寻求帮助**
   ```
   在任务 3 中遇到阻塞：
   - 验证失败：核心功能未正确处理边界情况
   - 计划指令不够详细，无法确定正确的处理方式

   需要澄清：如何处理边界情况？
   ```

7. **等待反馈**

   合作伙伴提供详细的处理说明。

8. **继续执行任务 3**
   ```powershell
   # 根据反馈修复问题
   # 重新运行验证
   # 验证通过
   # 标记为 completed
   ```

9. **报告**
   ```
   已实现：
   - 任务 1：设置项目结构
   - 任务 2：安装依赖
   - 任务 3：实现核心功能（已修复边界情况）

   验证输出：
   - npm test: 25 tests passed, 0 failed

   准备好接受反馈。
   ```

## 特殊场景示例（使用子技能）

假设计划要求使用其他技能。

### 步骤

1. **加载和审查计划**
   ```powershell
   # 读取计划文件
   $planContent = Get-Content "docs/plans/advanced-plan.md" -Raw

   # 批判性审查
   # 计划要求使用 test-driven-development 技能
   ```

2. **创建 TodoWrite**
   ```powershell
   # 使用 todo_write 工具创建待办事项列表
   # 包含所有 6 个任务
   ```

3. **执行任务 1：使用 TDD 实现功能**
   ```powershell
   # 标记为 in_progress

   # 计划指令要求使用 test-driven-development 技能
   # 使用 Skill 工具调用该技能
   Skill("test-driven-development")

   # 按照 TDD 技能的流程执行
   # RED: 编写失败的测试
   # GREEN: 编写最简单的代码使测试通过
   # REFACTOR: 重构代码

   # 运行验证
   # 标记为 completed
   ```

4. **执行后续任务**
   ```powershell
   # 继续执行其他任务
   # ...
   ```

5. **完成开发**
   ```
   所有任务完成。
   使用 Skill 工具调用 finishing-a-development-branch 技能。
   ```

## 最佳实践

1. **批判性审查计划** - 在开始前识别问题
2. **严格按照计划步骤** - 不要跳过或修改步骤
3. **不要跳过验证** - 每个任务后验证
4. **批次之间报告** - 等待反馈后再继续
5. **阻塞时停止** - 不要猜测，寻求帮助
6. **引用技能** - 计划说明时使用 Skill 工具
7. **不要在 main/master 上开始** - 除非有明确的用户同意

## 常见问题

### Q: 如果计划不清晰怎么办？

A: 在 Step 1 中批判性审查计划，识别问题并向合作伙伴提出。不要开始实现直到计划清晰。

### Q: 如果验证失败怎么办？

A: 停止并寻求帮助。不要尝试猜测修复方法。向合作伙伴描述失败情况并寻求指导。

### Q: 如果计划引用了不存在的技能怎么办？

A: 在 Step 1 中识别此问题，向合作伙伴提出。可能需要使用替代方法或移植缺失的技能。

### Q: 批次大小应该是多少？

A: 默认是前 3 个任务。这个数量提供了足够的进度，同时允许频繁的反馈循环。

## 与其他技能的集成

### 与 using-git-worktrees 配合

```powershell
# 1. 使用 using-git-worktrees 创建隔离环境
# （已在开始前完成）

# 2. 加载并审查计划
# 3. 执行批次
# 4. 完成开发后使用 finishing-a-development-branch
```

### 与 finishing-a-development-branch 配合

```powershell
# 1. 执行计划
# 2. 所有任务完成后
# 3. 使用 Skill 工具调用 finishing-a-development-branch
# Skill("finishing-a-development-branch")
```

### 与 writing-plans 配合

```powershell
# 1. 使用 writing-plans 创建计划
# 2. 在单独的会话中使用 executing-plans 执行计划
# 3. 完成开发
```

## 工具映射

| Superpowers 工具 | iFlow CLI 工具 | 用途 |
|------------------|----------------|------|
| `Read` | `read_file` | 读取计划文件 |
| `TodoWrite` | `todo_write` | 创建/更新待办事项列表 |
| `TodoRead` | `todo_read` | 读取待办事项列表 |
| `Skill` | `Skill` | 调用子技能 |

## 注意事项

1. **不要在 main/master 分支上开始实现**，除非有明确的用户同意
2. **严格遵循计划步骤**，不要跳过或修改
3. **每个任务后运行验证**，确保实现正确
4. **批次之间报告并等待反馈**，不要自动继续
5. **遇到阻塞时停止**，不要猜测，寻求帮助
6. **使用 Skill 工具调用子技能**，而不是手动执行