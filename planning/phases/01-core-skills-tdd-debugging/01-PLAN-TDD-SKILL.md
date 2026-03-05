---
phase: 01-core-skills-tdd-debugging
plan: 01
type: execute
wave: 1
depends_on: []
files_modified: []
autonomous: true
requirements: [CORE-01]
must_haves:
  truths:
    - "Test-Driven Development 技能在 iFlow CLI 中可用"
    - "技能遵循 iFlow CLI 的格式规范"
    - "技能与 iFlow CLI 的工具集兼容"
  artifacts:
    - path: "skills/test-driven-development/SKILL.md"
      provides: "Test-Driven Development 技能主文件"
    - path: "skills/test-driven-development/tests/test-basic.sh"
      provides: "基础测试脚本"
  key_links:
    - from: "skills/test-driven-development/SKILL.md"
      to: "iFlow CLI 技能系统"
      via: "Skill tool"
---

# Plan 01: 移植 Test-Driven Development 技能

<objective>
将 Superpowers 的 Test-Driven Development 技能移植到 iFlow CLI，确保技能遵循 iFlow CLI 的格式规范并与工具集兼容。

Purpose: TDD 是 Superpowers 的核心技能，强制执行 RED-GREEN-REFACTOR 循环，确保代码生成包含测试。这是第一个要移植的技能，将验证移植策略的可行性。

Output: 完整的 Test-Driven Development 技能包，包括技能主文件、测试脚本和使用示例。
</objective>

<context>
@.planning/PROJECT.md
@.planning/ROADMAP.md
@.planning/STATE.md
@.planning/phases/01-core-skills-tdd-debugging/01-CONTEXT.md
@.planning/phases/01-core-skills-tdd-debugging/01-RESEARCH.md
@R:\test2\superpowers\skills\test-driven-development\SKILL.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: 读取并分析 Superpowers 的 TDD 技能</name>
  <files>R:\test2\superpowers\skills\test-driven-development\SKILL.md</files>
  <action>使用 read_file 工具读取 Superpowers 的 TDD 技能文件，分析其结构和内容，识别需要适配的部分：
  1. YAML frontmatter（添加 version、author、category、tags 字段）
  2. 工具调用（Read → read_file, Write → write_file, Edit → replace, Bash → run_shell_command）
  3. 子代理调用（Task → task，指定 subagent_type）
  4. 上下文引用（@file 语法 → read_file 工具）
  5. 流程图（GraphViz DOT → 可选保留）
  提取关键内容和结构，准备进行适配。</action>
  <verify>成功读取文件并完成分析</verify>
  <done>完成分析报告，列出需要适配的部分</done>
</task>

<task type="auto">
  <name>Task 2: 创建 iFlow CLI 版本的 TDD 技能目录结构</name>
  <files>R:\test2\iFlow-Powers\skills\test-driven-development\</files>
  <action>创建技能目录结构：
  1. 创建主目录：R:\test2\iFlow-Powers\skills\test-driven-development\
  2. 创建子目录：
     - tests/ - 存放测试脚本
     - examples/ - 存放使用示例
  3. 创建文件：
     - SKILL.md - 技能主文件
     - LICENSE.txt - 许可证文件（MIT）
  确保目录结构符合 iFlow CLI 的规范。</action>
  <verify>目录创建成功，结构正确</verify>
  <done>目录结构完整，符合规范</done>
</task>

<task type="auto">
  <name>Task 3: 编写 iFlow CLI 版本的 TDD 技能主文件</name>
  <files>R:\test2\iFlow-Powers\skills\test-driven-development\SKILL.md</files>
  <action>编写 SKILL.md 文件，包含以下内容：
  1. YAML frontmatter：
     - name: test-driven-development
     - description: 强制执行 RED-GREEN-REFACTOR TDD 循环，确保代码生成包含测试
     - version: 1.0.0
     - author: iFlow CLI (port from Superpowers by obra)
     - category: Development
     - tags: testing,tdd,development
  2. 技能概述（1-2 句）
  3. 使用时机（决策流程或列表）
  4. RED-GREEN-REFACTOR 循环说明
  5. 快速参考（常用操作表格）
  6. 工具映射说明
  7. 使用示例
  8. 常见错误和修复
  9. 真实影响
  适配 Superpowers 的内容，但使用 iFlow CLI 的工具和术语。</action>
  <verify>文件创建成功，内容完整</verify>
  <done>SKILL.md 文件完整，包含所有必要部分</done>
</task>

<task type="auto">
  <name>Task 4: 创建 TDD 技能的测试脚本</name>
  <files>R:\test2\iFlow-Powers\skills\test-driven-development\tests\test-basic.sh</files>
  <action>创建测试脚本，验证技能的基本功能：
  1. 创建测试脚本（PowerShell 格式，Windows 兼容）：
     - 检查 SKILL.md 文件是否存在
     - 验证 YAML frontmatter 的完整性
     - 验证技能内容的完整性
  2. 创建辅助函数：
     - Assert-FileExists - 验证文件存在
     - Assert-Contains - 验证文件包含指定内容
     - Assert-YamlField - 验证 YAML 字段存在
  3. 编写测试用例：
     - 测试技能文件存在
     - 测试 YAML frontmatter 完整性
     - 测试核心内容存在
  4. 添加执行权限和运行说明
  确保测试脚本可以验证技能的正确性。</action>
  <verify>测试脚本创建成功，可以执行</verify>
  <done>测试脚本完整，包含所有必要的测试用例</done>
</task>

<task type="auto">
  <name>Task 5: 创建 TDD 技能的使用示例</name>
  <files>R:\test2\iFlow-Powers\skills\test-driven-development\examples\README.md</files>
  <action>创建使用示例文档，展示如何在 iFlow CLI 中使用 TDD 技能：
  1. 基础使用：
     - 如何调用技能
     - 简单的代码生成示例
  2. 完整流程：
     - RED: 编写失败的测试
     - GREEN: 编写最小代码通过测试
     - REFACTOR: 重构代码
  3. 工具映射示例：
     - 展示如何将 Superpowers 工具映射到 iFlow CLI 工具
  4. 常见场景：
     - 添加新功能
     - 修复 Bug
     - 重构代码
  提供清晰的代码示例和说明。</action>
  <verify>示例文档创建成功，内容清晰</verify>
  <done>使用示例完整，涵盖常见场景</done>
</task>

<task type="auto">
  <name>Task 6: 运行测试并验证技能</name>
  <files>R:\test2\iFlow-Powers\skills\test-driven-development\tests\test-basic.sh</files>
  <action>运行测试脚本，验证技能的正确性：
  1. 使用 run_shell_command 工具执行测试脚本
  2. 检查测试结果，确保所有测试通过
  3. 如果有测试失败，分析原因并修复
  4. 记录测试结果和发现的问题
  确保技能满足 Phase 1 的成功标准。</action>
  <verify>测试全部通过，技能符合规范</verify>
  <done>技能测试通过，可以投入使用</done>
</task>

</tasks>

<verification>
- [ ] 技能文件 SKILL.md 存在且完整
- [ ] YAML frontmatter 包含所有必需字段
- [ ] 技能内容遵循 iFlow CLI 的格式规范
- [ ] 工具映射正确且完整
- [ ] 测试脚本可以执行且所有测试通过
- [ ] 使用示例清晰且有用
- [ ] 技能与 iFlow CLI 工具集兼容
</verification>

<success_criteria>
- 所有 6 个任务完成
- 所有验证检查通过
- 没有引入错误或警告
- 技能可以在 iFlow CLI 中正常使用
</success_criteria>

<output>
After completion, create `.planning/phases/01-core-skills-tdd-debugging/01-PLAN-TDD-SKILL-SUMMARY.md` containing:
1. 执行摘要（完成的任务和结果）
2. 测试结果
3. 发现的问题和解决方案
4. 遗留的问题（如果有）
5. 后续建议
</output>