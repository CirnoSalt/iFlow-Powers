# 常见问题解答 (FAQ)

本文档回答了关于 Superpowers for iFlow CLI 的常见问题。

## 目录

- [安装和设置](#安装和设置)
- [技能使用](#技能使用)
- [工具映射](#工具映射)
- [子代理](#子代理)
- [TDD 相关](#tdd-相关)
- [Debugging 相关](#debugging-相关)
- [集成和部署](#集成和部署)
- [性能和优化](#性能和优化)
- [常见错误](#常见错误)
- [获取帮助](#获取帮助)

---

## 安装和设置

### Q1: 如何安装 Superpowers 技能？

**A**: 按照以下步骤安装：

1. 克隆项目仓库：
```bash
git clone https://github.com/your-username/superpowers-iflow.git
cd superpowers-iflow
```

2. 复制技能到 iFlow CLI 技能目录：
```bash
# 全局安装
cp -r skills/* ~/.iflow/skills/

# 或项目安装
cp -r skills/* .iflow/skills/
```

3. 刷新技能列表：
```bash
/skills refresh
```

4. 验证安装：
```bash
/skills list
```

你应该看到 8 个已安装的技能。

---

### Q2: 安装前需要什么？

**A**: 你需要：

- **iFlow CLI** (版本 0.4.11 或更高)
- **Python 3.x**
- **Git**

检查版本：
```bash
iflow --version
python --version
git --version
```

---

### Q3: 技能支持哪些操作系统？

**A**: Superpowers for iFlow CLI 支持以下操作系统：

- Windows 10/11
- macOS (Intel 和 Apple Silicon)
- Linux (Ubuntu, Debian, CentOS 等)

所有技能都经过跨平台测试。

---

### Q4: 如何更新技能？

**A**: 更新技能：

1. 拉取最新代码：
```bash
cd superpowers-iflow
git pull origin main
```

2. 复制更新的技能：
```bash
cp -r skills/* ~/.iflow/skills/
```

3. 刷新技能列表：
```bash
/skills refresh
```

---

### Q5: 可以同时安装多个版本的技能吗？

**A**: 不可以。每个技能只能有一个版本。更新技能会覆盖旧版本。

建议在更新前备份现有技能：
```bash
cp -r ~/.iflow/skills ~/iflow-skills-backup
```

---

## 技能使用

### Q6: 如何调用技能？

**A**: 有两种方式调用技能：

**方式 1: 使用 skill 命令**
```
skill: "test-driven-development"
```

**方式 2: 在提示中引用**
```
请使用 test-driven-development 技能来实现这个功能
```

---

### Q7: 可以同时使用多个技能吗？

**A**: 可以！你可以按顺序使用多个技能：

```
1. skill: "brainstorming" - 探索需求
2. skill: "writing-plans" - 创建计划
3. skill: "test-driven-development" - 实现
4. skill: "systematic-debugging" - 调试
```

这是推荐的完整工作流。

---

### Q8: 技能的执行顺序重要吗？

**A**: 是的，某些技能有推荐的执行顺序：

**推荐的工作流**:
1. **brainstorming** - 探索需求和设计
2. **writing-plans** - 创建详细计划
3. **test-driven-development** - 使用 TDD 实现
4. **systematic-debugging** - 调试和优化

遵循这个顺序可以获得最佳效果。

---

### Q9: 如何查看已安装的技能？

**A**: 使用以下命令查看已安装的技能：

```bash
/skills list
```

这会显示所有已安装技能的名称和描述。

---

### Q10: 技能调用后没有响应怎么办？

**A**: 如果技能调用后长时间无响应：

1. 检查技能是否正确安装：
```bash
/skills list
```

2. 检查网络连接（某些技能需要网络）

3. 增加超时时间：
```javascript
run_shell_command({
  command: "npm test",
  description: "Run tests",
  timeout: 300  // 5 分钟
});
```

4. 查看日志：
```bash
Get-Content ~/.iflow/logs/latest.log -Tail 50
```

---

## 工具映射

### Q11: 如何将 Superpowers 工具映射到 iFlow CLI？

**A**: 工具映射是自动的。Superpowers 工具名称会自动映射到 iFlow CLI 工具：

| Superpowers | iFlow CLI |
|-------------|-----------|
| Read | read_file |
| Write | write_file |
| Edit | replace |
| Bash | run_shell_command |
| Task | task |
| Skill | Skill |

详细映射见 [API 参考文档](API-REFERENCE.md)。

---

### Q12: 为什么我的工具调用失败？

**A**: 常见原因：

1. **参数名称不正确**：
```javascript
// ❌ 错误
read_file({ path: "/path/to/file" });

// ✅ 正确
read_file({ absolute_path: "/path/to/file" });
```

2. **缺少必需参数**：
```javascript
// ❌ 错误 - 缺少参数
read_file();

// ✅ 正确 - 包含必需参数
read_file({ absolute_path: "/path/to/file" });
```

3. **参数类型不正确**：
```javascript
// ❌ 错误 - 数组而不是字符串
read_file({ absolute_path: ["/path/to/file"] });

// ✅ 正确 - 字符串
read_file({ absolute_path: "/path/to/file" });
```

---

### Q13: 如何在 Windows 上使用 Bash 命令？

**A**: 在 Windows 上，使用 PowerShell 语法：

```javascript
// ❌ 错误 - Linux 语法
run_shell_command({
  command: "npm test && npm run build"
});

// ✅ 正确 - PowerShell 语法
run_shell_command({
  command: "npm test; if ($?) { npm run build }"
});
```

更多 Windows 特定问题见 [故障排除指南](TROUBLESHOOTING.md)。

---

## 子代理

### Q14: 什么是子代理？

**A**: 子代理是独立的 AI 代理，可以执行特定任务。iFlow CLI 提供以下预定义子代理：

- **general-purpose**: 通用任务（代码生成、审查等）
- **plan-agent**: 规划和分析任务
- **explore-agent**: 代码库探索和分析
- **frontend-tester**: 前端测试和验证

---

### Q15: 如何调用子代理？

**A**: 使用 `task` 工具调用子代理：

```javascript
task({
  subagent_type: "general-purpose",
  description: "Review code",
  prompt: "Review the code for quality and best practices",
  useContext: true
});
```

---

### Q16: 可以创建自定义子代理吗？

**A**: 不可以。iFlow CLI 不支持自定义子代理定义。但是，你可以在 `prompt` 参数中定义角色：

```javascript
task({
  subagent_type: "general-purpose",
  description: "Custom task",
  prompt: "You are a custom agent. Perform the following task: ..."
});
```

---

### Q17: 子代理调用失败怎么办？

**A**: 检查以下几点：

1. **使用预定义代理类型**：
```javascript
// ✅ 正确
task({ subagent_type: "general-purpose", ... });

// ❌ 错误
task({ subagent_type: "custom-agent", ... });  // 不存在
```

2. **prompt 格式正确**：
```javascript
// ✅ 正确
task({
  subagent_type: "general-purpose",
  description: "Task",
  prompt: "You are a reviewer. Review this code: ${code}"
});

// ❌ 错误
task({
  subagent_type: "general-purpose",
  description: "Task",
  prompt: "Review"  // 太简单，不明确
});
```

3. **useContext 设置正确**：
```javascript
// ✅ 正确 - 传递上下文
task({ subagent_type: "general-purpose", ..., useContext: true });
```

---

## TDD 相关

### Q18: 什么是 TDD？

**A**: TDD (Test-Driven Development) 是一种开发方法，遵循 RED-GREEN-REFACTOR 循环：

1. **RED**: 编写失败的测试
2. **GREEN**: 编写最小代码通过测试
3. **REFACTOR**: 重构代码（保持测试绿色）

---

### Q19: 如何使用 TDD 技能？

**A**: 调用技能：

```
skill: "test-driven-development"
```

技能会引导你完成 TDD 流程。详细示例见 [使用示例库](EXAMPLES.md)。

---

### Q20: TDD 适合所有项目吗？

**A**: TDD 适合大多数项目，特别是：

- 需要高质量代码的项目
- 需要长期维护的项目
- 复杂的业务逻辑

对于简单的脚本或一次性任务，TDD 可能不是最佳选择。

---

### Q21: TDD 会降低开发速度吗？

**A**: 短期可能看起来较慢，但长期会：

- 减少调试时间
- 减少返工
- 提高代码质量
- 加快新功能开发

总体上，TDD 会提高开发效率。

---

## Debugging 相关

### Q22: 什么是 Systematic Debugging？

**A**: Systematic Debugging 是一种四阶段调试方法：

1. **Phase 1: 根本原因调查** - 理解问题
2. **Phase 2: 模式分析** - 识别差异
3. **Phase 3: 假设和测试** - 验证假设
4. **Phase 4: 实现** - 修复根本原因

---

### Q23: 如何使用 Debugging 技能？

**A**: 调用技能：

```
skill: "systematic-debugging"
```

技能会引导你完成四阶段调试流程。详细示例见 [使用示例库](EXAMPLES.md)。

---

### Q24: Debugging 技能和普通调试有什么区别？

**A**: 区别：

| 普通调试 | Systematic Debugging |
|---------|---------------------|
| 尝试随机修复 | 系统化方法 |
| 修复症状 | 修复根本原因 |
| 依赖经验 | 依赖流程 |
| 可能重复出现 | 一次性解决 |

---

### Q25: 调试时应该跳过某些步骤吗？

**A**: 不应该。Systematic Debugging 的每个阶段都很重要：

- **跳过 Phase 1**: 可能修复错误的问题
- **跳过 Phase 2**: 可能错过根本原因
- **跳过 Phase 3**: 可能实现错误的修复
- **跳过 Phase 4**: 可能没有修复根本原因

始终完成所有四个阶段。

---

## 集成和部署

### Q26: 如何将技能集成到 CI/CD？

**A**: 参考 [集成指南](INTEGRATION.md)。以下是 GitHub Actions 示例：

```yaml
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Run TDD
      run: |
        skill: "test-driven-development"
        npm test
```

---

### Q27: 可以在团队中共享技能吗？

**A**: 可以。有几种方式：

1. **项目级技能** - 将技能放在项目的 `.iflow/skills/` 目录
2. **团队共享仓库** - 创建团队共享的技能仓库
3. **全局安装** - 在每个开发者的全局目录安装

---

### Q28: 如何在 Docker 中使用技能？

**A**: 在 Dockerfile 中安装技能：

```dockerfile
FROM node:18

# 安装 iFlow CLI
RUN npm install -g @iflow/cli

# 安装技能
COPY skills /root/.iflow/skills

# 工作目录
WORKDIR /app

# 使用技能运行测试
RUN skill: "test-driven-development" && npm test
```

---

## 性能和优化

### Q29: 技能会影响性能吗？

**A**: 技能本身不会显著影响性能。但是：

- **技能调用时间**: 取决于技能复杂度
- **技能数量**: 技能越多，刷新时间越长
- **上下文大小**: 大上下文会增加处理时间

优化建议：
- 只安装需要的技能
- 定期清理未使用的技能
- 限制上下文大小

---

### Q30: 如何优化技能执行速度？

**A**: 优化方法：

1. **使用项目级技能** - 加载更快
2. **缓存技能** - 避免重复加载
3. **限制上下文** - 使用 `useContext: false`
4. **简化 prompt** - 避免过长或复杂的 prompt

---

### Q31: 技能占用多少磁盘空间？

**A**: 所有技能大约占用：

- **技能文件**: ~500 KB
- **文档**: ~2 MB
- **总计**: ~2.5 MB

非常小，不会占用太多磁盘空间。

---

## 常见错误

### Q32: "技能不存在" 错误

**A**: 解决方法：

1. 检查技能是否已安装：
```bash
/skills list
```

2. 刷新技能列表：
```bash
/skills refresh
```

3. 检查技能名称拼写（大小写敏感）

---

### Q33: "权限不足" 错误

**A**: 解决方法：

1. 使用管理员权限运行
2. 检查文件权限
3. 使用项目级技能而不是全局技能

---

### Q34: "路径错误" 错误

**A**: 解决方法：

1. 使用绝对路径
2. 使用正斜杠（/）而不是反斜杠（\）
3. 检查路径长度（Windows 限制 260 字符）

---

### Q35: "编码错误" 错误

**A**: 解决方法：

1. 确保文件使用 UTF-8 编码
2. 设置控制台编码为 UTF-8：
```bash
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
```

---

## 获取帮助

### Q36: 如何获取更多帮助？

**A**: 获取帮助的方式：

1. **文档**:
   - [快速开始指南](QUICKSTART.md)
   - [API 参考文档](API-REFERENCE.md)
   - [故障排除指南](TROUBLESHOOTING.md)
   - [使用示例库](EXAMPLES.md)
   - [最佳实践指南](BEST-PRACTICES.md)

2. **社区**:
   - [GitHub Issues](https://github.com/your-username/superpowers-iflow/issues)
   - [GitHub Discussions](https://github.com/your-username/superpowers-iflow/discussions)

3. **联系**:
   - Email: your-email@example.com

---

### Q37: 如何报告 Bug？

**A**: 报告 Bug 的步骤：

1. 收集诊断信息
2. 记录错误消息
3. 提供复现步骤
4. 提交 GitHub Issue

Issue 模板见 [故障排除指南](TROUBLESHOOTING.md#报告问题)。

---

### Q38: 如何请求新功能？

**A**: 请求新功能：

1. 检查是否已有类似请求
2. 创建 GitHub Issue
3. 描述新功能需求
4. 提供使用场景和示例

---

### Q39: 如何贡献代码？

**A**: 贡献代码：

1. Fork 项目仓库
2. 创建功能分支
3. 提交更改
4. 创建 Pull Request

详细贡献指南见 [CONTRIBUTING.md](../CONTRIBUTING.md)。

---

### Q40: 未找到答案怎么办？

**A**: 如果未找到答案：

1. 搜索 [故障排除指南](TROUBLESHOOTING.md)
2. 搜索 [GitHub Issues](https://github.com/your-username/superpowers-iflow/issues)
3. 在 [GitHub Discussions](https://github.com/your-username/superpowers-iflow/discussions) 提问
4. 创建新的 GitHub Issue

---

## 索引

### 按类别

| 类别 | 问题数 |
|------|--------|
| 安装和设置 | 5 |
| 技能使用 | 5 |
| 工具映射 | 3 |
| 子代理 | 4 |
| TDD 相关 | 4 |
| Debugging 相关 | 4 |
| 集成和部署 | 3 |
| 性能和优化 | 3 |
| 常见错误 | 4 |
| 获取帮助 | 5 |

### 按频率

| 问题 | 频率 |
|------|------|
| 如何安装技能？ | 高 |
| 如何调用技能？ | 高 |
| 工具调用失败？ | 中 |
| 子代理调用失败？ | 中 |
| 技能无响应？ | 低 |

---

## 总结

本 FAQ 涵盖了 Superpowers for iFlow CLI 的常见问题。如果你有其他问题：

1. 查看文档
2. 搜索社区资源
3. 提问或报告问题

记住：大多数问题都可以通过查看文档或使用诊断工具解决。

---

**文档版本**: 1.0.0
**最后更新**: 2026-03-05