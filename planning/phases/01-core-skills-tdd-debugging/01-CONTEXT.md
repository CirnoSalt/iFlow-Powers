# Phase 1 Context: Core Skills (TDD & Debugging)

## 锁定的实现决策

### 技能格式
- **决策**：使用 iFlow CLI 的技能格式（SKILL.md + YAML frontmatter）
- **理由**：确保与 iFlow CLI 完全兼容
- **实现**：每个技能必须包含以下字段：
  ```yaml
  ---
  name: skill-name
  description: Brief description
  version: 1.0.0
  author: iFlow CLI
  category: Development
  tags: testing,debugging
  ---
  ```

### 工具映射
- **决策**：创建 Superpowers 到 iFlow CLI 的工具映射表
- **理由**：确保技能中的工具调用正确
- **实现**：
  - `Read` → `read_file`
  - `Write` → `write_file`
  - `Edit` → `replace`（需要提供精确的 old_string 和 new_string）
  - `Bash` → `run_shell_command`
  - `Task` → `task`（需要指定 subagent_type）
  - `Skill` → `Skill`
  - `TodoWrite` → `todo_write`
  - `TodoRead` → `todo_read`

### 子代理适配
- **决策**：将 Superpowers 的自定义代理映射到 iFlow CLI 的预定义代理类型
- **理由**：iFlow CLI 不支持自定义代理定义
- **实现**：
  - `code-reviewer` → `general-purpose`（在 prompt 中明确角色）
  - `implementer` → `general-purpose`（在 prompt 中明确角色）
  - `spec-reviewer` → `plan-agent`（用于规范审查）
  - `code-quality-reviewer` → `general-purpose`（用于质量审查）

### 上下文管理
- **决策**：在技能文档中说明如何使用 iFlow CLI 的上下文机制
- **理由**：iFlow CLI 不支持 @file 语法
- **实现**：
  - 使用 `read_file` 工具手动加载文件
  - 在 prompt 中引用文件内容
  - 或者使用 `useContext: true` 参数传递上下文

### 测试策略
- **决策**：创建 iFlow CLI 专用的测试框架
- **理由**：Superpowers 的测试框架需要适配
- **实现**：
  - 使用 PowerShell 脚本（Windows 兼容）
  - 提供测试辅助函数
  - 创建基线测试和技能测试

## Claude 的自由裁量

以下领域允许 Claude 根据最佳实践做决策：

1. **技能内容的组织**：如何组织技能的各个部分（概述、使用方式、实现等）
2. **代码示例的选择**：选择适当的代码示例来演示技能的使用
3. **测试用例的设计**：设计适当的测试用例来验证技能的功能
4. **错误处理策略**：在技能中如何处理错误和异常情况
5. **性能优化**：优化技能的执行性能

## 延迟的想法

以下想法延迟到后续阶段考虑：

1. **完整测试框架**：Phase 1 创建基础测试框架，完整框架在 Phase 5
2. **技能触发机制**：Phase 1 使用手动触发，自动触发机制后续考虑
3. **钩子系统**：Phase 1 不实现钩子，后续阶段考虑
4. **高级功能**：如技能依赖管理、技能组合等
5. **性能优化**：如技能缓存、并行加载等

## Phase 1 的限制

- **时间限制**：每个技能的移植时间不超过 2 小时
- **复杂度限制**：每个技能不超过 500 行文档
- **依赖限制**：不依赖外部库或工具
- **测试限制**：每个技能至少有 2 个测试用例
- **文档限制**：每个技能必须有清晰的使用说明

## Phase 1 的成功标准

1. Test-Driven Development 技能在 iFlow CLI 中可用
2. Systematic Debugging 技能在 iFlow CLI 中可用
3. 两个技能遵循 iFlow CLI 的格式规范
4. 两个技能与 iFlow CLI 的工具集兼容
5. 每个技能至少有 2 个测试用例
6. 每个技能有清晰的使用说明
7. 工具映射表完整且准确
8. 子代理映射策略明确

## 相关文档

- [Superpowers vs iFlow CLI 技能系统对比分析](./01-RESEARCH.md)
- [项目愿景](../../PROJECT.md)
- [需求定义](../../REQUIREMENTS.md)
- [路线图](../../ROADMAP.md)
- [当前状态](../../STATE.md)