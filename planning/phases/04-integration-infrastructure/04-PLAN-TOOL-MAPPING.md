# 计划：工具映射系统

## 工具映射系统概述

工具映射系统用于将 Superpowers 的工具映射到 iFlow CLI 的工具，确保技能文档中的工具调用能够正确执行。

## 核心功能

1. **工具映射**：定义 Superpowers 工具到 iFlow CLI 工具的映射
2. **参数转换**：转换工具参数格式
3. **验证**：验证工具映射的正确性
4. **文档**：提供工具映射文档

## 工具映射表

### 基础工具映射

| Superpowers | iFlow CLI | 参数映射 |
|-------------|-----------|----------|
| `Read` | `read_file` | `path` → `absolute_path` |
| `Write` | `write_file` | `path` → `file_path`, `content` → `content` |
| `Edit` | `replace` | `path` → `file_path`, `old` → `old_string`, `new` → `new_string`, `instruction` → `instruction` |
| `Bash` | `run_shell_command` | `command` → `command` |
| `Task` | `task` | `type` → `subagent_type`, `prompt` → `prompt` |
| `Skill` | `Skill` | `name` → `skill` |
| `TodoWrite` | `todo_write` | `todos` → `todos` |
| `TodoRead` | `todo_read` | 无参数 |

### 高级工具映射

| Superpowers | iFlow CLI | 参数映射 |
|-------------|-----------|----------|
| `Glob` | `glob` | `pattern` → `pattern`, `path` → `path` |
| `Search` | `search_file_content` | `pattern` → `pattern`, `path` → `path` |
| `Ask` | `ask_user_question` | `questions` → `questions` |
| `ImageRead` | `image_read` | `image` → `image_input`, `prompt` → `prompt` |
| `WebFetch` | `web_fetch` | `url` → `url`, `prompt` → `prompt` |
| `WebSearch` | `web_search` | `query` → `query`, `intent` → `intent`, `expected` → `expected` |

## 实施步骤

### 步骤 1：创建工具映射配置文件

**文件**：`config/tool-mapping.json`

**内容**：
```json
{
  "tools": {
    "Read": {
      "iflow": "read_file",
      "params": {
        "path": "absolute_path"
      }
    },
    "Write": {
      "iflow": "write_file",
      "params": {
        "path": "file_path",
        "content": "content"
      }
    },
    "Edit": {
      "iflow": "replace",
      "params": {
        "path": "file_path",
        "old": "old_string",
        "new": "new_string",
        "instruction": "instruction"
      }
    },
    "Bash": {
      "iflow": "run_shell_command",
      "params": {
        "command": "command"
      }
    },
    "Task": {
      "iflow": "task",
      "params": {
        "type": "subagent_type",
        "prompt": "prompt"
      }
    },
    "Skill": {
      "iflow": "Skill",
      "params": {
        "name": "skill"
      }
    },
    "TodoWrite": {
      "iflow": "todo_write",
      "params": {
        "todos": "todos"
      }
    },
    "TodoRead": {
      "iflow": "todo_read",
      "params": {}
    },
    "Glob": {
      "iflow": "glob",
      "params": {
        "pattern": "pattern",
        "path": "path"
      }
    },
    "Search": {
      "iflow": "search_file_content",
      "params": {
        "pattern": "pattern",
        "path": "path"
      }
    },
    "Ask": {
      "iflow": "ask_user_question",
      "params": {
        "questions": "questions"
      }
    },
    "ImageRead": {
      "iflow": "image_read",
      "params": {
        "image": "image_input",
        "prompt": "prompt"
      }
    },
    "WebFetch": {
      "iflow": "web_fetch",
      "params": {
        "url": "url",
        "prompt": "prompt"
      }
    },
    "WebSearch": {
      "iflow": "web_search",
      "params": {
        "query": "query",
        "intent": "intent",
        "expected": "expected"
      }
    }
  }
}
```

### 步骤 2：创建工具映射库

**文件**：`lib/tool-mapping.js`

**功能**：
- 加载工具映射配置
- 转换工具调用
- 验证工具映射

**代码结构**：
```javascript
const fs = require('fs');
const path = require('path');

class ToolMapping {
  constructor(configPath) {
    this.configPath = configPath;
    this.mapping = null;
  }
  
  load() {
    const configContent = fs.readFileSync(this.configPath, 'utf8');
    this.mapping = JSON.parse(configContent);
  }
  
  mapTool(superpowersTool, params) {
    const toolInfo = this.mapping.tools[superpowersTool];
    if (!toolInfo) {
      throw new Error(`Unknown tool: ${superpowersTool}`);
    }
    
    const iflowParams = {};
    for (const [superKey, iflowKey] of Object.entries(toolInfo.params)) {
      if (params.hasOwnProperty(superKey)) {
        iflowParams[iflowKey] = params[superKey];
      }
    }
    
    return {
      tool: toolInfo.iflow,
      params: iflowParams
    };
  }
  
  validate() {
    const errors = [];
    
    for (const [superpowersTool, toolInfo] of Object.entries(this.mapping.tools)) {
      if (!toolInfo.iflow) {
        errors.push(`Tool ${superpowersTool} missing iflow mapping`);
      }
      
      if (!toolInfo.params || Object.keys(toolInfo.params).length === 0) {
        errors.push(`Tool ${superpowersTool} missing parameter mapping`);
      }
    }
    
    return errors;
  }
}

module.exports = ToolMapping;
```

### 步骤 3：创建测试脚本

**文件**：`lib/tool-mapping.test.js`

**测试内容**：
- 测试工具映射加载
- 测试工具转换
- 测试参数转换
- 测试验证功能

### 步骤 4：创建使用文档

**文件**：`docs/tool-mapping.md`

**内容**：
- 工具映射系统概述
- 工具映射表
- 使用方法
- API 文档
- 示例代码
- 常见问题

## 关键决策点

### 决策 1：配置文件格式

**选项**：
1. JSON
2. YAML
3. JavaScript

**决策**：JSON

**理由**：
- 标准格式
- 易于解析
- 广泛支持

### 决策 2：参数映射策略

**选项**：
1. 简单替换
2. 复杂转换
3. 自动推断

**决策**：简单替换

**理由**：
- 实现简单
- 易于理解
- 可维护性好

### 决策 3：错误处理

**选项**：
1. 静默失败
2. 记录警告
3. 抛出异常

**决策**：抛出异常

**理由**：
- 明确错误
- 便于调试
- 避免隐式错误

## 成功标准

1. ✅ 能够加载工具映射配置
2. ✅ 能够正确转换工具调用
3. ✅ 能够正确转换参数
4. ✅ 能够验证工具映射
5. ✅ 测试通过率 100%
6. ✅ 文档完整
7. ✅ 性能满足要求

## 风险和缓解措施

### 风险 1：工具名称不一致

**影响**：无法正确映射工具

**缓解措施**：
- 创建完整的工具映射表
- 添加详细的文档
- 提供示例

### 风险 2：参数格式不兼容

**影响**：无法正确转换参数

**缓解措施**：
- 详细的参数映射表
- 参数类型检查
- 错误提示

### 风险 3：配置文件损坏

**影响**：无法加载工具映射

**缓解措施**：
- 配置文件验证
- 默认配置
- 错误处理

## 时间估算

- 创建工具映射配置文件：30 分钟
- 创建工具映射库：30 分钟
- 创建测试脚本：30 分钟
- 创建使用文档：30 分钟
- **总计**：2 小时

## 下一步

1. 实现工具映射功能
2. 创建测试脚本
3. 运行测试
4. 创建使用文档