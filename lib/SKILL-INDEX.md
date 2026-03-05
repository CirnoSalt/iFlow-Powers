# Superpowers Port - 技能索引

## 技能发现机制

技能发现机制使用 Glob 工具自动发现项目中的所有技能。

### 发现模式

- **技能文件**：`skills/*/SKILL.md`
- **示例文件**：`skills/*/examples/README.md`
- **测试文件**：`skills/*/tests/test-basic.ps1`

### 使用方法

```javascript
// 使用 Glob 工具发现所有技能
const skillFiles = glob({
  pattern: "skills/*/SKILL.md",
  path: "R:/test2/iFlow-Powers"
});
```

## 已移植技能

### Phase 1: Core Skills (TDD & Debugging)

1. **test-driven-development**
   - 路径：`skills/test-driven-development/SKILL.md`
   - 类别：Development
   - 标签：tdd,testing,development
   - 描述：使用测试驱动开发方法确保代码质量

2. **systematic-debugging**
   - 路径：`skills/systematic-debugging/SKILL.md`
   - 类别：Debugging
   - 标签：debugging,troubleshooting,analysis
   - 描述：系统化的调试方法，快速定位和修复问题

### Phase 2: Core Skills (Planning & Brainstorming)

3. **brainstorming**
   - 路径：`skills/brainstorming/SKILL.md`
   - 类别：Planning
   - 标签：brainstorming,ideation,planning
   - 描述：在编码前探索需求和设计，避免过早实现

4. **writing-plans**
   - 路径：`skills/writing-plans/SKILL.md`
   - 类别：Planning
   - 标签：planning,documentation,development
   - 描述：创建详细的实施计划，分解为可管理的步骤

### Phase 3: Execution Skills

5. **using-git-worktrees**
   - 路径：`skills/using-git-worktrees/SKILL.md`
   - 类别：Execution
   - 标签：git,workflow,isolation
   - 描述：创建隔离的 git worktree，支持并行开发

6. **finishing-a-development-branch**
   - 路径：`skills/finishing-a-development-branch/SKILL.md`
   - 类别：Execution
   - 标签：git,workflow,completion
   - 描述：完成开发分支的清理和合并工作

7. **executing-plans**
   - 路径：`skills/executing-plans/SKILL.md`
   - 类别：Execution
   - 标签：planning,execution,workflow
   - 描述：执行已制定的实施计划，分批执行并报告进度

8. **subagent-driven-development**
   - 路径：`skills/subagent-driven-development/SKILL.md`
   - 类别：Execution
   - 标签：subagent,execution,workflow
   - 描述：使用子代理驱动开发，每个任务独立执行并审查

## 技能元数据

每个技能包含以下元数据：

```yaml
---
name: skill-name
description: Brief description
version: 1.0.0
author: iFlow CLI
category: Development
tags: development,coding
---
```

## 技能查询

### 按名称查询

```javascript
// 查找特定技能
const skill = findSkillByName("test-driven-development");
```

### 按类别查询

```javascript
// 查找所有开发类技能
const developmentSkills = findSkillsByCategory("Development");
```

### 按标签查询

```javascript
// 查找所有与 tdd 相关的技能
const tddSkills = findSkillsByTag("tdd");
```

## 技能统计

- **总技能数**：8
- **类别数**：4
- **平均测试通过率**：100%

## 技能依赖关系

### 工作流链

1. **规划工作流**：
   - brainstorming → writing-plans

2. **开发工作流**：
   - using-git-worktrees → test-driven-development → systematic-debugging

3. **执行工作流**：
   - writing-plans → executing-plans / subagent-driven-development → finishing-a-development-branch

### 技能依赖

- **executing-plans** 依赖：
  - using-git-worktrees
  - writing-plans
  - finishing-a-development-branch

- **subagent-driven-development** 依赖：
  - using-git-worktrees
  - writing-plans
  - finishing-a-development-branch

## 工具映射

### 基础工具

| Superpowers | iFlow CLI | 说明 |
|-------------|-----------|------|
| Read | read_file | 读取文件内容 |
| Write | write_file | 写入文件内容 |
| Edit | replace | 替换文件内容 |
| Bash | run_shell_command | 执行 shell 命令 |
| Task | task | 启动子代理 |
| Skill | Skill | 调用技能 |
| TodoWrite | todo_write | 写入待办事项 |
| TodoRead | todo_read | 读取待办事项 |

### 高级工具

| Superpowers | iFlow CLI | 说明 |
|-------------|-----------|------|
| Glob | glob | 查找文件 |
| Search | search_file_content | 搜索文件内容 |
| Ask | ask_user_question | 询问用户 |
| ImageRead | image_read | 读取图像 |
| WebFetch | web_fetch | 获取网页内容 |
| WebSearch | web_search | 网页搜索 |

## 子代理映射

### 代理类型映射

| Superpowers | iFlow CLI | 说明 |
|-------------|-----------|------|
| code-reviewer | general-purpose | 代码审查代理 |
| implementer | general-purpose | 实现代理 |
| spec-reviewer | plan-agent | 规范审查代理 |
| code-quality-reviewer | general-purpose | 代码质量审查代理 |
| brainstorm | general-purpose | 头脑风暴代理 |
| debug | general-purpose | 调试代理 |
| plan | plan-agent | 规划代理 |

## 使用示例

### 查找技能

```javascript
// 使用 Glob 查找所有技能
const skills = glob({
  pattern: "skills/*/SKILL.md",
  path: "R:/test2/iFlow-Powers"
});

// 输出技能列表
skills.forEach(skill => {
  console.log(skill);
});
```

### 读取技能

```javascript
// 读取技能文件
const skillContent = read_file({
  absolute_path: "R:/test2/iFlow-Powers/skills/test-driven-development/SKILL.md"
});

// 解析 YAML frontmatter
const yamlMatch = skillContent.match(/^---\n(.*?)\n---/s);
const yamlContent = yamlMatch[1];
const metadata = yaml.parse(yamlContent);
```

## 维护说明

### 添加新技能

1. 在 `skills/` 目录下创建新技能目录
2. 创建 `SKILL.md` 文件，包含 YAML frontmatter
3. 创建 `examples/README.md` 文件，提供使用示例
4. 创建 `tests/test-basic.ps1` 文件，提供测试用例
5. 更新本索引文件

### 更新技能

1. 修改技能文件
2. 更新版本号
3. 运行测试
4. 更新本索引文件

### 删除技能

1. 确认技能没有依赖
2. 删除技能目录
3. 更新本索引文件

## 性能优化

### 技能发现优化

- 使用 Glob 工具的模式匹配功能
- 缓存技能列表
- 增量更新索引

### 技能查询优化

- 使用索引结构
- 支持模糊匹配
- 提供查询缓存

## 故障排除

### 问题：技能无法发现

**原因**：
- 技能文件路径不正确
- YAML frontmatter 格式错误

**解决方法**：
- 检查技能文件路径
- 验证 YAML frontmatter 格式

### 问题：技能元数据解析失败

**原因**：
- YAML 格式错误
- 缺少必填字段

**解决方法**：
- 验证 YAML 格式
- 检查必填字段

## 相关文档

- [技能发现机制计划](../planning/phases/04-integration-infrastructure/04-PLAN-SKILL-DISCOVERY.md)
- [工具映射系统计划](../planning/phases/04-integration-infrastructure/04-PLAN-TOOL-MAPPING.md)
- [子代理系统适配计划](../planning/phases/04-integration-infrastructure/04-PLAN-SUBAGENT-MAPPING.md)