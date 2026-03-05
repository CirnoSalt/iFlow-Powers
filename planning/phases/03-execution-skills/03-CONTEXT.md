# Phase 3 Context: Execution Skills

## 锁定的实现决策

### 技能格式（延续 Phase 1 & 2）
- **决策**：使用 iFlow CLI 的技能格式（SKILL.md + YAML frontmatter）
- **理由**：确保与 iFlow CLI 完全兼容，与 Phase 1 和 2 保持一致
- **实现**：每个技能必须包含以下字段：
  ```yaml
  ---
  name: skill-name
  description: Brief description
  version: 1.0.0
  author: iFlow CLI
  category: Execution
  tags: git,workflow,planning
  ---
  ```

### 工具映射（延续 Phase 1 & 2）
- **决策**：使用 Phase 1 和 2 创建的工具映射表
- **理由**：保持一致性，确保工具调用正确
- **实现**：
  - `Read` → `read_file`
  - `Write` → `write_file`
  - `Edit` → `replace`
  - `Bash` → `run_shell_command`
  - `Task` → `task`（需要指定 subagent_type）
  - `Skill` → `Skill`
  - `TodoWrite` → `todo_write`
  - `TodoRead` → `todo_read`

### 子代理适配（延续 Phase 1 & 2）
- **决策**：将 Superpowers 的自定义代理映射到 iFlow CLI 的预定义代理类型
- **理由**：iFlow CLI 不支持自定义代理定义
- **实现**：
  - `implementer` → `general-purpose`（在 prompt 中明确角色）
  - `spec-reviewer` → `plan-agent`（用于规范审查）
  - `code-quality-reviewer` → `general-purpose`（用于质量审查）
  - `code-reviewer` → `general-purpose`（用于代码审查）

### 上下文管理（延续 Phase 1 & 2）
- **决策**：在技能文档中说明如何使用 iFlow CLI 的上下文机制
- **理由**：iFlow CLI 不支持 @file 语法
- **实现**：
  - 使用 `read_file` 工具手动加载文件
  - 在 prompt 中引用文件内容
  - 或者使用 `useContext: true` 参数传递上下文

### 测试策略（延续 Phase 1 & 2）
- **决策**：使用 Phase 1 和 2 创建的测试框架
- **理由**：保持一致性，确保测试质量
- **实现**：
  - 使用 PowerShell 脚本（Windows 兼容）
  - 提供测试辅助函数
  - 创建基线测试和技能测试

### Git 命令处理（延续 Phase 1 & 2）
- **决策**：提供 PowerShell 和 Git Bash 两种版本
- **理由**：确保在不同环境中的兼容性，给用户更多选择
- **实现**：
  - 在技能文档中提供两种版本的命令
  - 使用 `git` 命令（跨平台）
  - 避免使用平台特定的命令

### 文件路径格式（延续 Phase 1 & 2）
- **决策**：使用 Unix 风格路径（`/`）
- **理由**：Git 和大多数现代工具都支持 Unix 风格路径，跨平台兼容性更好
- **实现**：
  - 在技能文档中使用 Unix 风格路径
  - 在示例代码中使用 Unix 风格路径
  - 在测试中使用 Unix 风格路径

### using-git-worktrees 技能特殊考虑
- **决策**：保留 Superpowers 的目录选择优先级和安全性验证
- **理由**：这些是 using-git-worktrees 的核心功能
- **实现**：
  - 按优先级检查现有目录（`.worktrees` > `worktrees`）
  - 检查 CLAUDE.md 中的偏好设置
  - 验证目录是否被 git ignore
  - 提供两种位置选项（项目本地 vs 全局）
  - 自动检测并运行项目设置

### finishing-a-development-branch 技能特殊考虑
- **决策**：保留 Superpowers 的 4 个选项结构
- **理由**：这提供了清晰的工作流选择
- **实现**：
  - 验证测试通过后再提供选项
  - 提供精确的 4 个选项（合并本地、创建 PR、保持、丢弃）
  - 对于选项 4 需要明确的确认
  - 正确处理 worktree 清理

### executing-plans 技能特殊考虑
- **决策**：保留 Superpowers 的批量执行和检查点机制
- **理由**：这是 executing-plans 的核心价值
- **实现**：
  - 批量执行任务（默认 3 个）
  - 在批次之间报告并等待反馈
  - 严格遵循计划步骤
  - 不跳过验证步骤
  - 在遇到阻塞时停止并询问

### subagent-driven-development 技能特殊考虑
- **决策**：保留 Superpowers 的两阶段审查机制
- **理由**：这确保了代码质量和规范合规性
- **实现**：
  - 每个任务使用新的子代理
  - 两阶段审查：规范合规性 → 代码质量
  - 审查循环直到通过
  - 使用 task 工具分发子代理
  - 提供完整的任务文本和上下文

## Claude 的自由裁量

以下领域允许 Claude 根据最佳实践做决策：

1. **子代理 prompt 设计**：如何设计 implementer、spec-reviewer、code-quality-reviewer 的 prompt
2. **审查循环策略**：如何处理审查失败的情况
3. **批量大小**：executing-plans 的批量大小是否需要调整
4. **错误处理**：在技能中如何处理错误和异常情况
5. **测试用例的设计**：设计适当的测试用例来验证技能的功能
6. **性能优化**：优化技能的执行性能（特别是子代理调用）
7. **用户体验**：如何优化用户交互流程

## 延迟的想法

以下想法延迟到后续阶段考虑：

1. **技能组合**：多个执行技能的组合使用
2. **自动化触发**：基于上下文自动触发执行技能
3. **结果持久化**：将执行结果保存到文件系统
4. **进度跟踪**：对执行进度进行可视化和跟踪
5. **高级功能**：如任务优先级、依赖管理等
6. **性能优化**：如子代理缓存、并行优化等

## Phase 3 的限制

- **时间限制**：每个技能的移植时间不超过 2 小时
- **复杂度限制**：每个技能不超过 500 行文档
- **依赖限制**：不依赖外部库或工具
- **测试限制**：每个技能至少有 2 个测试用例
- **文档限制**：每个技能必须有清晰的使用说明
- **子代理限制**：subagent-driven-development 的子代理调用不超过每个任务 3 个（implementer + 2 reviewers）

## Phase 3 的成功标准

1. using-git-worktrees 技能在 iFlow CLI 中可用
2. finishing-a-development-branch 技能在 iFlow CLI 中可用
3. executing-plans 技能在 iFlow CLI 中可用
4. subagent-driven-development 技能在 iFlow CLI 中可用
5. 所有技能遵循 iFlow CLI 的格式规范
6. 所有技能与 iFlow CLI 的工具集兼容
7. using-git-worktrees 技能支持目录选择和安全性验证
8. finishing-a-development-branch 技能支持 4 个选项
9. executing-plans 技能支持批量执行和检查点
10. subagent-driven-development 技能支持两阶段审查
11. 每个技能至少有 2 个测试用例
12. 每个技能有清晰的使用说明
13. 工具映射表完整且准确
14. 子代理映射策略明确

## Phase 3 的特殊挑战

### using-git-worktrees 技能的挑战
1. **目录选择逻辑**：如何正确实现目录选择优先级
2. **安全性验证**：如何正确验证 git ignore
3. **跨平台兼容**：如何在 Windows 上正确处理路径
4. **项目设置检测**：如何自动检测并运行项目设置

### finishing-a-development-branch 技能的挑战
1. **测试验证**：如何正确运行项目的测试套件
2. **分支检测**：如何正确检测基础分支
3. **选项执行**：如何正确执行 4 个选项
4. **Worktree 清理**：如何正确清理 worktree

### executing-plans 技能的挑战
1. **计划加载**：如何正确加载和解析计划文件
2. **批量执行**：如何正确实现批量执行机制
3. **检查点报告**：如何正确报告和等待反馈
4. **阻塞处理**：如何正确处理阻塞情况

### subagent-driven-development 技能的挑战
1. **子代理分发**：如何正确分发和调用子代理
2. **两阶段审查**：如何正确实现两阶段审查机制
3. **审查循环**：如何正确处理审查失败和循环
4. **上下文传递**：如何正确传递完整的任务文本和上下文

## 相关文档

- [Superpowers vs iFlow CLI 技能系统对比分析](../01-core-skills-tdd-debugging/01-RESEARCH.md)
- [项目愿景](../../PROJECT.md)
- [需求定义](../../REQUIREMENTS.md)
- [路线图](../../ROADMAP.md)
- [当前状态](../../STATE.md)
- [Phase 1 Context](../01-core-skills-tdd-debugging/01-CONTEXT.md)
- [Phase 2 Context](../02-core-skills-brainstorming-planning/02-CONTEXT.md)
- [Phase 1 Verification](../01-core-skills-tdd-debugging/01-VERIFICATION.md)
- [Phase 2 Verification](../02-core-skills-brainstorming-planning/02-VERIFICATION.md)

## 技能依赖关系

### using-git-worktrees
- **被调用者**：brainstorming, subagent-driven-development, executing-plans
- **依赖**：无
- **优先级**：高（其他技能依赖它）

### finishing-a-development-branch
- **被调用者**：subagent-driven-development, executing-plans
- **依赖**：using-git-worktrees（清理 worktree）
- **优先级**：高（其他技能依赖它）

### executing-plans
- **被调用者**：writing-plans（子技能）
- **依赖**：using-git-worktrees, finishing-a-development-branch
- **优先级**：中（可选执行方式）

### subagent-driven-development
- **被调用者**：writing-plans（子技能）
- **依赖**：using-git-worktrees, finishing-a-development-branch
- **优先级**：中（可选执行方式）

## 移植顺序

基于依赖关系，建议按以下顺序移植：

1. **using-git-worktrees**（优先级最高，无依赖）
2. **finishing-a-development-branch**（依赖 using-git-worktrees）
3. **executing-plans**（依赖 using-git-worktrees 和 finishing-a-development-branch）
4. **subagent-driven-development**（依赖 using-git-worktrees 和 finishing-a-development-branch）

## 备注

- Phase 3 将完成 Superpowers 的核心执行技能的移植
- 这些技能将形成完整的开发工作流
- Phase 4 将专注于集成基础设施和文档
- Phase 5 将专注于验证和优化