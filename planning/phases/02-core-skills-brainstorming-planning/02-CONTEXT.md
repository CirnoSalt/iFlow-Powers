# Phase 2 Context: Core Skills (Brainstorming & Planning)

## 锁定的实现决策

### 技能格式（延续 Phase 1）
- **决策**：使用 iFlow CLI 的技能格式（SKILL.md + YAML frontmatter）
- **理由**：确保与 iFlow CLI 完全兼容，与 Phase 1 保持一致
- **实现**：每个技能必须包含以下字段：
  ```yaml
  ---
  name: skill-name
  description: Brief description
  version: 1.0.0
  author: iFlow CLI
  category: Planning
  tags: brainstorming,writing
  ---
  ```

### 工具映射（延续 Phase 1）
- **决策**：使用 Phase 1 创建的工具映射表
- **理由**：保持一致性，确保工具调用正确
- **实现**：
  - `Read` → `read_file`
  - `Write` → `write_file`
  - `Edit` → `replace`（需要提供精确的 old_string 和 new_string）
  - `Bash` → `run_shell_command`
  - `Task` → `task`（需要指定 subagent_type）
  - `Skill` → `Skill`
  - `TodoWrite` → `todo_write`
  - `TodoRead` → `todo_read`

### 子代理适配（延续 Phase 1）
- **决策**：将 Superpowers 的自定义代理映射到 iFlow CLI 的预定义代理类型
- **理由**：iFlow CLI 不支持自定义代理定义
- **实现**：
  - `code-reviewer` → `general-purpose`（在 prompt 中明确角色）
  - `implementer` → `general-purpose`（在 prompt 中明确角色）
  - `spec-reviewer` → `plan-agent`（用于规范审查）
  - `code-quality-reviewer` → `general-purpose`（用于质量审查）

### 上下文管理（延续 Phase 1）
- **决策**：在技能文档中说明如何使用 iFlow CLI 的上下文机制
- **理由**：iFlow CLI 不支持 @file 语法
- **实现**：
  - 使用 `read_file` 工具手动加载文件
  - 在 prompt 中引用文件内容
  - 或者使用 `useContext: true` 参数传递上下文

### 测试策略（延续 Phase 1）
- **决策**：使用 Phase 1 创建的测试框架
- **理由**：保持一致性，确保测试质量
- **实现**：
  - 使用 PowerShell 脚本（Windows 兼容）
  - 提供测试辅助函数
  - 创建基线测试和技能测试

### Brainstorming 技能特殊考虑
- **决策**：保留 Superpowers 的多子代理并行执行模式
- **理由**：Brainstorming 的核心价值是并行生成多个方案
- **实现**：
  - 使用 `task` 工具并行启动多个 `general-purpose` 子代理
  - 每个子代理独立生成一个方案
  - 主代理收集并评估所有方案
  - 提供明确的评估标准和选择流程

### Writing Plans 技能特殊考虑
- **决策**：保留 Superpowers 的结构化计划格式
- **理由**：结构化计划是 Writing Plans 的核心输出
- **实现**：
  - 使用标准的 Markdown 格式
  - 包含明确的步骤和验证标准
  - 支持计划的修订和迭代
  - 提供计划模板和示例

## Claude 的自由裁量

以下领域允许 Claude 根据最佳实践做决策：

1. **Brainstorming 的方案生成策略**：如何设计 prompt 以确保生成多样化的方案
2. **方案评估标准**：如何设计评估标准以确保方案质量
3. **Writing Plans 的计划结构**：如何组织计划的结构和内容
4. **计划的验证方式**：如何验证计划的可行性和完整性
5. **测试用例的设计**：设计适当的测试用例来验证技能的功能
6. **错误处理策略**：在技能中如何处理错误和异常情况
7. **性能优化**：优化技能的执行性能（特别是并行执行）

## 延迟的想法

以下想法延迟到后续阶段考虑：

1. **技能组合**：Brainstorming 和 Writing Plans 的组合使用
2. **自动化触发**：基于上下文自动触发 Brainstorming 技能
3. **方案持久化**：将生成的方案保存到文件系统
4. **计划版本管理**：对计划进行版本控制和追踪
5. **高级功能**：如方案的投票机制、计划的依赖管理等
6. **性能优化**：如方案缓存、并行优化等

## Phase 2 的限制

- **时间限制**：每个技能的移植时间不超过 2 小时
- **复杂度限制**：每个技能不超过 500 行文档
- **依赖限制**：不依赖外部库或工具
- **测试限制**：每个技能至少有 2 个测试用例
- **文档限制**：每个技能必须有清晰的使用说明
- **并行限制**：Brainstorming 技能的并行子代理数量不超过 5 个

## Phase 2 的成功标准

1. Brainstorming 技能在 iFlow CLI 中可用
2. Writing Plans 技能在 iFlow CLI 中可用
3. 两个技能遵循 iFlow CLI 的格式规范
4. 两个技能与 iFlow CLI 的工具集兼容
5. Brainstorming 技能支持并行生成多个方案
6. Writing Plans 技能支持结构化计划格式
7. 每个技能至少有 2 个测试用例
8. 每个技能有清晰的使用说明
9. 工具映射表完整且准确
10. 子代理映射策略明确

## Phase 2 的特殊挑战

### Brainstorming 技能的挑战
1. **并行执行**：如何在 iFlow CLI 中实现并行子代理执行
2. **方案多样性**：如何确保生成的方案具有足够的多样性
3. **方案评估**：如何设计客观的评估标准
4. **结果整合**：如何有效地整合和呈现多个方案

### Writing Plans 技能的挑战
1. **计划结构**：如何设计灵活且结构化的计划格式
2. **计划验证**：如何验证计划的可行性和完整性
3. **计划迭代**：如何支持计划的修订和迭代
4. **模板设计**：如何设计有用的计划模板和示例

## 相关文档

- [Superpowers vs iFlow CLI 技能系统对比分析](../01-core-skills-tdd-debugging/01-RESEARCH.md)
- [项目愿景](../../PROJECT.md)
- [需求定义](../../REQUIREMENTS.md)
- [路线图](../../ROADMAP.md)
- [当前状态](../../STATE.md)
- [Phase 1 Context](../01-core-skills-tdd-debugging/01-CONTEXT.md)