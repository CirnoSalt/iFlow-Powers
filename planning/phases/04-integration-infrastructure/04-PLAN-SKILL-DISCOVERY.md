# 计划：技能发现机制

## 技能分析

### 技能发现机制概述

技能发现机制用于自动发现项目中的所有技能，包括：
- 技能文件（SKILL.md）
- 示例文件（examples/README.md）
- 测试文件（tests/test-basic.ps1）

### 核心功能

1. **自动发现**：使用 Glob 工具自动发现所有技能
2. **元数据提取**：解析 YAML frontmatter 提取技能元数据
3. **索引创建**：创建技能索引以提高查询效率
4. **验证**：验证技能的完整性和有效性

## 工具使用分析

### Glob 工具

**用途**：查找文件

**参数**：
- `pattern`：文件匹配模式
- `path`：搜索路径（可选）
- `case_sensitive`：是否区分大小写（可选）

**示例**：
```javascript
glob({
  pattern: "skills/*/SKILL.md",
  path: "R:/test2/iFlow-Powers"
})
```

### read_file 工具

**用途**：读取文件内容

**参数**：
- `absolute_path`：文件的绝对路径

**示例**：
```javascript
read_file({
  absolute_path: "R:/test2/iFlow-Powers/skills/brainstorming/SKILL.md"
})
```

## 子代理使用分析

**子代理使用**：无

## 移植策略

### 策略 1：使用 Glob 工具自动发现

**步骤**：
1. 使用 Glob 工具查找所有 SKILL.md 文件
2. 使用 Glob 工具查找所有示例文件
3. 使用 Glob 工具查找所有测试文件
4. 解析每个 SKILL.md 文件的 YAML frontmatter
5. 创建技能索引

**优点**：
- 自动化程度高
- 性能好
- 易于维护

**缺点**：
- 依赖 Glob 工具
- 需要处理文件不存在的情况

### 策略 2：手动维护技能列表

**步骤**：
1. 创建技能列表文件
2. 手动添加技能信息
3. 定期更新技能列表

**优点**：
- 完全控制
- 不依赖工具

**缺点**：
- 维护成本高
- 容易遗漏

**决策**：使用策略 1

## 实施步骤

### 步骤 1：创建技能发现脚本

**文件**：`lib/skill-discovery.js`

**功能**：
- 使用 Glob 工具查找所有技能
- 解析 YAML frontmatter
- 创建技能索引

**代码结构**：
```javascript
const { glob } = require('glob');

async function discoverSkills(basePath) {
  // 查找所有 SKILL.md 文件
  const skillFiles = await glob('skills/*/SKILL.md', { 
    cwd: basePath,
    absolute: true 
  });
  
  // 解析每个技能
  const skills = [];
  for (const skillFile of skillFiles) {
    const skill = await parseSkillFile(skillFile);
    skills.push(skill);
  }
  
  return skills;
}

async function parseSkillFile(filePath) {
  // 读取文件内容
  const content = await fs.readFile(filePath, 'utf8');
  
  // 解析 YAML frontmatter
  const yamlMatch = content.match(/^---\n(.*?)\n---/s);
  if (!yamlMatch) {
    throw new Error(`Invalid skill file: ${filePath}`);
  }
  
  const yamlContent = yamlMatch[1];
  const metadata = yaml.parse(yamlContent);
  
  return {
    path: filePath,
    metadata: metadata,
    content: content
  };
}

module.exports = { discoverSkills, parseSkillFile };
```

### 步骤 2：创建技能索引

**文件**：`lib/skill-index.js`

**功能**：
- 创建技能索引
- 提供查询接口
- 支持按名称、类别、标签查询

**代码结构**：
```javascript
class SkillIndex {
  constructor() {
    this.skills = [];
    this.nameIndex = new Map();
    this.categoryIndex = new Map();
    this.tagIndex = new Map();
  }
  
  addSkill(skill) {
    this.skills.push(skill);
    
    // 添加到名称索引
    this.nameIndex.set(skill.metadata.name, skill);
    
    // 添加到类别索引
    const category = skill.metadata.category || 'Uncategorized';
    if (!this.categoryIndex.has(category)) {
      this.categoryIndex.set(category, []);
    }
    this.categoryIndex.get(category).push(skill);
    
    // 添加到标签索引
    const tags = skill.metadata.tags || [];
    for (const tag of tags) {
      if (!this.tagIndex.has(tag)) {
        this.tagIndex.set(tag, []);
      }
      this.tagIndex.get(tag).push(skill);
    }
  }
  
  getByName(name) {
    return this.nameIndex.get(name);
  }
  
  getByCategory(category) {
    return this.categoryIndex.get(category) || [];
  }
  
  getByTag(tag) {
    return this.tagIndex.get(tag) || [];
  }
  
  getAll() {
    return this.skills;
  }
}

module.exports = SkillIndex;
```

### 步骤 3：创建测试脚本

**文件**：`lib/skill-discovery.test.js`

**测试内容**：
- 测试技能发现功能
- 测试 YAML frontmatter 解析
- 测试技能索引功能
- 测试查询功能

### 步骤 4：创建使用文档

**文件**：`docs/skill-discovery.md`

**内容**：
- 技能发现机制概述
- 使用方法
- API 文档
- 示例代码
- 常见问题

## 关键决策点

### 决策 1：索引数据结构

**选项**：
1. 使用 Map
2. 使用 Object
3. 使用数据库

**决策**：使用 Map

**理由**：
- Map 提供更好的性能
- API 更简洁
- 不需要额外依赖

### 决策 2：缓存策略

**选项**：
1. 不缓存
2. 内存缓存
3. 文件缓存
4. 数据库缓存

**决策**：内存缓存

**理由**：
- 实现简单
- 性能好
- 技能数量不大

### 决策 3：错误处理

**选项**：
1. 静默失败
2. 记录警告
3. 抛出异常

**决策**：记录警告

**理由**：
- 不会中断程序
- 便于调试
- 保持系统稳定

## 成功标准

1. ✅ 能够自动发现所有技能
2. ✅ 能够正确解析 YAML frontmatter
3. ✅ 能够创建技能索引
4. ✅ 能够按名称、类别、标签查询
5. ✅ 测试通过率 100%
6. ✅ 文档完整
7. ✅ 性能满足要求

## 风险和缓解措施

### 风险 1：Glob 工具不可用

**影响**：无法发现技能

**缓解措施**：
- 提供备用实现（手动遍历目录）
- 添加错误处理和回退机制

### 风险 2：YAML frontmatter 解析失败

**影响**：无法提取元数据

**缓解措施**：
- 添加详细的错误信息
- 提供默认值
- 跳过损坏的技能文件

### 风险 3：性能问题

**影响**：技能发现速度慢

**缓解措施**：
- 使用缓存
- 优化算法
- 增量更新

## 时间估算

- 创建技能发现脚本：30 分钟
- 创建技能索引：30 分钟
- 创建测试脚本：30 分钟
- 创建使用文档：30 分钟
- **总计**：2 小时

## 下一步

1. 实现技能发现功能
2. 创建测试脚本
3. 运行测试
4. 创建使用文档