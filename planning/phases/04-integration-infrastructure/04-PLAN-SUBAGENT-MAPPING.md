# 计划：子代理系统适配

## 子代理系统适配概述

子代理系统适配用于将 Superpowers 的自定义代理映射到 iFlow CLI 的预定义代理类型，确保技能能够正确使用子代理。

## 核心功能

1. **代理类型映射**：定义 Superpowers 代理类型到 iFlow CLI 代理类型的映射
2. **角色定义**：在 prompt 中明确指定代理角色
3. **上下文传递**：正确传递上下文到子代理
4. **验证**：验证代理映射的正确性

## 子代理类型映射

### 基础代理映射

| Superpowers | iFlow CLI | 描述 |
|-------------|-----------|------|
| `code-reviewer` | `general-purpose` | 代码审查代理 |
| `implementer` | `general-purpose` | 实现代理 |
| `spec-reviewer` | `plan-agent` | 规范审查代理 |
| `code-quality-reviewer` | `general-purpose` | 代码质量审查代理 |
| `brainstorm` | `general-purpose` | 头脑风暴代理 |
| `debug` | `general-purpose` | 调试代理 |
| `plan` | `plan-agent` | 规划代理 |

### 角色定义

#### code-reviewer

**iFlow CLI 类型**：`general-purpose`

**角色描述**：
```
你是一个专业的代码审查员，负责审查代码的质量、安全性和最佳实践。
你需要关注以下方面：
1. 代码逻辑是否正确
2. 是否存在潜在的安全漏洞
3. 是否遵循最佳实践
4. 代码是否易于维护
5. 是否有足够的测试覆盖
```

#### implementer

**iFlow CLI 类型**：`general-purpose`

**角色描述**：
```
你是一个专业的开发者，负责实现具体的功能。
你需要遵循以下原则：
1. 遵循 TDD 方法
2. 编写清晰、可维护的代码
3. 确保代码通过所有测试
4. 遵循项目的编码规范
5. 及时报告遇到的问题
```

#### spec-reviewer

**iFlow CLI 类型**：`plan-agent`

**角色描述**：
```
你是一个专业的规范审查员，负责验证代码是否符合规范。
你需要关注以下方面：
1. 代码是否实现了所有规范要求
2. 是否有多余的功能
3. 是否缺少必要功能
4. 接口是否符合规范
5. 数据格式是否正确
```

#### code-quality-reviewer

**iFlow CLI 类型**：`general-purpose`

**角色描述**：
```
你是一个专业的代码质量审查员，负责评估代码的质量。
你需要关注以下方面：
1. 代码复杂度
2. 代码可读性
3. 代码可维护性
4. 性能优化机会
5. 重构建议
```

## 实施步骤

### 步骤 1：创建子代理映射配置文件

**文件**：`config/subagent-mapping.json`

**内容**：
```json
{
  "subagents": {
    "code-reviewer": {
      "iflow": "general-purpose",
      "role": "你是一个专业的代码审查员，负责审查代码的质量、安全性和最佳实践。\n你需要关注以下方面：\n1. 代码逻辑是否正确\n2. 是否存在潜在的安全漏洞\n3. 是否遵循最佳实践\n4. 代码是否易于维护\n5. 是否有足够的测试覆盖",
      "capabilities": [
        "code_review",
        "security_analysis",
        "best_practices",
        "test_coverage"
      ]
    },
    "implementer": {
      "iflow": "general-purpose",
      "role": "你是一个专业的开发者，负责实现具体的功能。\n你需要遵循以下原则：\n1. 遵循 TDD 方法\n2. 编写清晰、可维护的代码\n3. 确保代码通过所有测试\n4. 遵循项目的编码规范\n5. 及时报告遇到的问题",
      "capabilities": [
        "implementation",
        "tdd",
        "code_quality",
        "testing"
      ]
    },
    "spec-reviewer": {
      "iflow": "plan-agent",
      "role": "你是一个专业的规范审查员，负责验证代码是否符合规范。\n你需要关注以下方面：\n1. 代码是否实现了所有规范要求\n2. 是否有多余的功能\n3. 是否缺少必要功能\n4. 接口是否符合规范\n5. 数据格式是否正确",
      "capabilities": [
        "spec_validation",
        "requirement_checking",
        "interface_validation"
      ]
    },
    "code-quality-reviewer": {
      "iflow": "general-purpose",
      "role": "你是一个专业的代码质量审查员，负责评估代码的质量。\n你需要关注以下方面：\n1. 代码复杂度\n2. 代码可读性\n3. 代码可维护性\n4. 性能优化机会\n5. 重构建议",
      "capabilities": [
        "quality_assessment",
        "complexity_analysis",
        "readability_check",
        "performance_optimization"
      ]
    },
    "brainstorm": {
      "iflow": "general-purpose",
      "role": "你是一个专业的头脑风暴专家，负责生成创新的解决方案。\n你需要遵循以下原则：\n1. 生成多样化的方案\n2. 每个方案都有明确的价值主张\n3. 提供客观的评估标准\n4. 保持开放和创造性的思维",
      "capabilities": [
        "idea_generation",
        "creative_thinking",
        "solution_design"
      ]
    },
    "debug": {
      "iflow": "general-purpose",
      "role": "你是一个专业的调试专家，负责定位和修复问题。\n你需要遵循以下原则：\n1. 系统化的调试方法\n2. 准确定位问题根源\n3. 提供可靠的修复方案\n4. 验证修复的有效性",
      "capabilities": [
        "debugging",
        "root_cause_analysis",
        "problem_solving"
      ]
    },
    "plan": {
      "iflow": "plan-agent",
      "role": "你是一个专业的规划专家，负责创建详细的实施计划。\n你需要遵循以下原则：\n1. 分解任务为可管理的步骤\n2. 定义明确的验证标准\n3. 考虑潜在的风险和依赖\n4. 确保计划的可行性",
      "capabilities": [
        "planning",
        "task_breakdown",
        "risk_assessment"
      ]
    }
  }
}
```

### 步骤 2：创建子代理映射库

**文件**：`lib/subagent-mapping.js`

**功能**：
- 加载子代理映射配置
- 转换子代理调用
- 添加角色定义
- 验证代理映射

**代码结构**：
```javascript
const fs = require('fs');
const path = require('path');

class SubagentMapping {
  constructor(configPath) {
    this.configPath = configPath;
    this.mapping = null;
  }
  
  load() {
    const configContent = fs.readFileSync(this.configPath, 'utf8');
    this.mapping = JSON.parse(configContent);
  }
  
  mapSubagent(superpowersSubagent) {
    const subagentInfo = this.mapping.subagents[superpowersSubagent];
    if (!subagentInfo) {
      throw new Error(`Unknown subagent: ${superpowersSubagent}`);
    }
    
    return {
      subagent_type: subagentInfo.iflow,
      role: subagentInfo.role,
      capabilities: subagentInfo.capabilities
    };
  }
  
  createPrompt(superpowersSubagent, originalPrompt) {
    const mapping = this.mapSubagent(superpowersSubagent);
    
    return `${mapping.role}\n\n任务：\n${originalPrompt}`;
  }
  
  validate() {
    const errors = [];
    
    for (const [superpowersSubagent, subagentInfo] of Object.entries(this.mapping.subagents)) {
      if (!subagentInfo.iflow) {
        errors.push(`Subagent ${superpowersSubagent} missing iflow mapping`);
      }
      
      if (!subagentInfo.role) {
        errors.push(`Subagent ${superpowersSubagent} missing role definition`);
      }
      
      if (!subagentInfo.capabilities || subagentInfo.capabilities.length === 0) {
        errors.push(`Subagent ${superpowersSubagent} missing capabilities`);
      }
    }
    
    return errors;
  }
}

module.exports = SubagentMapping;
```

### 步骤 3：创建测试脚本

**文件**：`lib/subagent-mapping.test.js`

**测试内容**：
- 测试子代理映射加载
- 测试子代理转换
- 测试角色定义
- 测试 prompt 创建
- 测试验证功能

### 步骤 4：创建使用文档

**文件**：`docs/subagent-mapping.md`

**内容**：
- 子代理系统适配概述
- 子代理类型映射表
- 角色定义
- 使用方法
- API 文档
- 示例代码
- 常见问题

## 关键决策点

### 决策 1：代理类型映射策略

**选项**：
1. 一对一映射
2. 多对一映射
3. 动态映射

**决策**：多对一映射

**理由**：
- iFlow CLI 代理类型有限
- Superpowers 代理类型更细分
- 通过角色定义区分功能

### 决策 2：角色定义方式

**选项**：
1. 内嵌在 prompt 中
2. 独立配置文件
3. 自动生成

**决策**：内嵌在 prompt 中

**理由**：
- 简单直接
- 易于修改
- 不需要额外文件

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

1. ✅ 能够加载子代理映射配置
2. ✅ 能够正确转换子代理调用
3. ✅ 能够正确添加角色定义
4. ✅ 能够正确创建 prompt
5. ✅ 能够验证代理映射
6. ✅ 测试通过率 100%
7. ✅ 文档完整
8. ✅ 性能满足要求

## 风险和缓解措施

### 风险 1：代理类型不兼容

**影响**：无法正确映射代理

**缓解措施**：
- 创建完整的代理映射表
- 添加详细的文档
- 提供示例

### 风险 2：角色定义不完整

**影响**：子代理无法正确理解任务

**缓解措施**：
- 详细的角色定义
- 多次测试和优化
- 用户反馈

### 风险 3：配置文件损坏

**影响**：无法加载子代理映射

**缓解措施**：
- 配置文件验证
- 默认配置
- 错误处理

## 时间估算

- 创建子代理映射配置文件：30 分钟
- 创建子代理映射库：30 分钟
- 创建测试脚本：30 分钟
- 创建使用文档：30 分钟
- **总计**：2 小时

## 下一步

1. 实现子代理系统适配
2. 创建测试脚本
3. 运行测试
4. 创建使用文档