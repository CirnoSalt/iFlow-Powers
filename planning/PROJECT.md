# iFlow-Powers

## What This Is
为 iFlow CLI 提供一套经过验证的软件开发工作流技能系统，确保 AI 代理遵循最佳实践进行开发。

## Core Value
通过强制性的工作流程和可复用的技能系统，提升 iFlow CLI 代码生成和任务执行的质量与可靠性。

## Requirements
### Validated
- ✓ Superpowers 项目已下载到 R:\test2\superpowers
- ✓ iFlow CLI skill 制作文档已获取
- ✓ GSD 工作流程技能已加载

### Active
- [ ] 分析 Superpowers 和 iFlow CLI 的技能系统差异
- [ ] 设计移植架构
- [ ] 移植核心技能（TDD、调试、头脑风暴等）
- [ ] 适配子代理系统到 iFlow CLI
- [ ] 创建技能发现和加载机制
- [ ] 编写完整的技术文档
- [ ] 验证移植后的技能系统

### Out of Scope
- 修改 iFlow CLI 核心代码 — 超出范围
- 重新实现 Superpowers 的所有平台集成 — 仅关注 iFlow CLI
- 创建在线市场 — 本地技能库

## Context
Superpowers 是一个为 AI 代码助手提供完整软件开发工作流的技能库系统，通过可组合的"技能"和初始指令，确保 AI 代理遵循最佳实践。该项目已在 Claude Code、Cursor、OpenCode、Codex 等平台得到验证。

iFlow CLI 是一个强大的 CLI 工具，支持技能扩展系统，技能采用目录结构组织，支持资源文件、依赖管理和初始化脚本。

## Constraints
- **技术栈**: 必须使用 iFlow CLI 的技能格式（SKILL.md + YAML frontmatter）
- **兼容性**: 技能必须与 iFlow CLI 的工具集兼容
- **文档格式**: 必须遵循 iFlow CLI 的文档规范
- **架构**: 必须适配 iFlow CLI 的子代理系统
- **版本追踪**: 每个技能必须有明确的版本信息

## Key Decisions
| Decision | Rationale | Outcome |
|----------|-----------|---------|
| 采用 GSD 工作流程 | 复杂项目需要规范驱动开发 | 确保移植质量和可追踪性 |
| 先移植核心技能 | 核心技能提供最大价值 | 快速验证可行性 |
| 保持技能独立性 | 每个技能可独立使用 | 灵活的技能组合 |
| 适配而非重写 | Superpowers 已经验证 | 降低风险，加速开发 |