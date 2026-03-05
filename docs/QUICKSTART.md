# 快速开始指南

## 欢迎使用 Superpowers for iFlow CLI！

本指南将在 5 分钟内帮助你开始使用 Superpowers 技能。

## 前置要求

在开始之前，确保你已安装：

- **iFlow CLI** (版本 0.4.11 或更高)
- **Python 3.x**
- **Git**

### 检查版本

```bash
iflow --version
python --version
git --version
```

预期输出：

```
iFlow CLI 0.4.11
Python 3.14.3
git version 2.53.0
```

如果某个命令未找到，请先安装相应的工具。

---

## 步骤 1: 下载 Superpowers

克隆项目仓库：

```bash
git clone https://github.com/your-username/superpowers-iflow.git
cd superpowers-iflow
```

---

## 步骤 2: 安装技能

将技能复制到 iFlow CLI 的技能目录：

### 全局安装（推荐）

```bash
cp -r skills/* ~/.iflow/skills/
```

### 项目安装

```bash
cp -r skills/* .iflow/skills/
```

---

## 步骤 3: 刷新技能列表

刷新技能列表以加载新安装的技能：

```bash
/skills refresh
```

预期输出：

```
技能列表已刷新。发现 8 个技能。
```

---

## 步骤 4: 验证安装

查看已安装的技能：

```bash
/skills list
```

你应该看到以下技能：

```
已安装技能:
- brainstorming
- executing-plans
- finishing-a-development-branch
- subagent-driven-development
- systematic-debugging
- test-driven-development
- using-git-worktrees
- writing-plans
```

---

## 步骤 5: 使用第一个技能

让我们尝试使用 **test-driven-development** 技能：

```
skill: "test-driven-development"
```

技能会引导你完成 TDD 流程：

### 1. 编写失败的测试

```javascript
// test/calculator.test.js
test('should add two numbers', () => {
  expect(add(2, 3)).toBe(5);
});
```

### 2. 运行测试（应该失败）

```bash
npm test
```

预期输出：

```
FAIL  test/calculator.test.js
  ✕ should add two numbers (2 ms)

Test Suites: 1 failed, 1 total
Tests:       1 failed, 1 total
```

### 3. 实现代码

```javascript
// src/calculator.js
function add(a, b) {
  return a + b;
}
```

### 4. 运行测试（应该通过）

```bash
npm test
```

预期输出：

```
PASS  test/calculator.test.js
  ✓ should add two numbers (1 ms)

Test Suites: 1 passed, 1 total
Tests:       1 passed, 1 total
```

### 5. 重构代码（如需要）

```javascript
// src/calculator.js
const add = (a, b) => a + b;
```

### 6. 验证测试仍然通过

```bash
npm test
```

---

## 常用技能

### test-driven-development

使用测试驱动开发方法确保代码质量。

```
skill: "test-driven-development"
```

---

### systematic-debugging

系统化调试方法，快速定位和修复问题。

```
skill: "systematic-debugging"
```

---

### brainstorming

在编码前探索需求和设计。

```
skill: "brainstorming"
```

---

### writing-plans

创建详细的实施计划。

```
skill: "writing-plans"
```

---

## 完整工作流示例

### 功能开发工作流

```bash
# 1. 探索需求
skill: "brainstorming"

# 2. 创建计划
skill: "writing-plans"

# 3. 使用 TDD 实现
skill: "test-driven-development"

# 4. 调试和优化
skill: "systematic-debugging"
```

---

## 下一步

### 查看完整文档

- [架构设计文档](ARCHITECTURE.md) - 了解系统架构
- [API 参考文档](API-REFERENCE.md) - 查看完整 API
- [集成指南](INTEGRATION.md) - 学习如何集成

### 探索示例

- [使用示例](EXAMPLES.md) - 查看更多使用示例
- [最佳实践](BEST-PRACTICES.md) - 学习最佳实践

### 获取帮助

- [故障排除指南](TROUBLESHOOTING.md) - 解决常见问题
- [常见问题解答](FAQ.md) - 查看常见问题

---

## 提示

### 技能调用方式

你可以通过以下方式调用技能：

```
方式 1: skill: "test-driven-development"

方式 2: 在提示中提及
"请使用 test-driven-development 技能来实现这个功能"
```

### 技能组合

技能可以组合使用以获得更好的效果：

```
brainstorming → writing-plans → test-driven-development → systematic-debugging
```

### 获取帮助

如果遇到问题：

1. 查看故障排除指南
2. 检查技能列表
3. 验证环境配置

---

## 恭喜！

你现在可以开始使用 Superpowers 技能了！

🎉 享受更高效的开发体验！

---

**文档版本**: 1.0.0
**最后更新**: 2026-03-05