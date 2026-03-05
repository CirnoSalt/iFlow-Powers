# Superpowers 到 iFlow CLI 迁移指南

## 文档信息

- **版本**: 1.0.0
- **日期**: 2026-03-05
- **作者**: iFlow CLI
- **状态**: 已完成

## 目录

- [概述](#概述)
- [迁移前准备](#迁移前准备)
- [迁移步骤](#迁移步骤)
- [迁移检查清单](#迁移检查清单)
- [常见问题](#常见问题)
- [最佳实践](#最佳实践)
- [后续支持](#后续支持)

## 概述

### 迁移目标

本指南帮助用户从 Superpowers 迁移到 Superpowers for iFlow CLI，确保平滑过渡和功能保持。

### 迁移范围

- **已迁移的功能**:
  - Test-Driven Development 技能
  - Systematic Debugging 技能

- **未迁移的功能**:
  - 钩子系统（SessionStart、SessionEnd）
  - 技能自动触发机制
  - 完整的测试框架
  - 其他 Superpowers 技能（将在后续版本迁移）

### 迁移策略

采用渐进式迁移策略：

1. **Phase 1**: 移植核心技能（TDD 和 Debugging）
2. **Phase 2**: 移植规划和头脑风暴技能
3. **Phase 3**: 建立技能发现和加载机制
4. **Phase 4**: 编写完整文档
5. **Phase 5**: 验证和优化

## 迁移前准备

### 环境检查

1. **检查 iFlow CLI 版本**

```bash
iflow --version
```

确保版本 >= 0.4.11。

2. **检查 Python 环境**

```bash
python --version
```

确保 Python 3.x 已安装。

3. **检查 Git 环境**

```bash
git --version
```

确保 Git 已安装。

### 数据备份

1. **备份现有 Superpowers 技能**

```bash
cp -r ~/.superpowers/skills ~/superpowers-backup
```

2. **备份项目文件**

```bash
git commit -am "Backup before Superpowers migration"
```

3. **记录当前工作状态**

```bash
git status > migration-status.txt
```

### 依赖检查

1. **检查依赖项**

```bash
npm list
pip list
```

2. **安装缺失依赖**

```bash
npm install
pip install -r requirements.txt
```

## 迁移步骤

### 步骤 1: 下载 Superpowers for iFlow CLI

```bash
# 克隆项目
git clone https://github.com/your-username/superpowers-iflow.git
cd superpowers-iflow

# 或下载压缩包
wget https://github.com/your-username/superpowers-iflow/archive/main.zip
unzip main.zip
```

### 步骤 2: 安装技能

```bash
# 全局安装
cp -r skills/* ~/.iflow/skills/

# 或项目安装
cp -r skills/* .iflow/skills/
```

### 步骤 3: 刷新技能列表

```bash
/skills refresh
```

### 步骤 4: 验证安装

```bash
/skills list
```

你应该看到：
- test-driven-development
- systematic-debugging

### 步骤 5: 测试技能

```bash
# 测试 TDD 技能
skill: "test-driven-development"

# 测试 Debugging 技能
skill: "systematic-debugging"
```

### 步骤 6: 更新工作流程

1. **更新项目文档**

```markdown
# 将 Superpowers 引用更新为 iFlow CLI 引用

# 之前
使用 superpowers:test-driven-development 技能

# 之后
使用 test-driven-development 技能
```

2. **更新脚本和配置**

```bash
# 更新脚本中的技能调用
sed -i 's/superpowers:/skill: "/g' *.sh
```

3. **更新 CI/CD 配置**

```yaml
# 更新 GitHub Actions
- name: Run tests
  run: |
    skill: "test-driven-development"
    npm test
```

### 步骤 7: 验证功能

1. **运行测试套件**

```bash
npm test
```

2. **检查代码质量**

```bash
npm run lint
```

3. **验证构建**

```bash
npm run build
```

### 步骤 8: 清理旧文件（可选）

```bash
# 删除旧的 Superpowers 技能
rm -rf ~/.superpowers/skills

# 或保留作为备份
mv ~/.superpowers/skills ~/superpowers-backup
```

## 迁移检查清单

### 安装检查

- [ ] iFlow CLI 版本 >= 0.4.11
- [ ] Python 3.x 已安装
- [ ] Git 已安装
- [ ] Superpowers for iFlow CLI 已下载
- [ ] 技能已安装到正确位置
- [ ] 技能列表已刷新

### 功能检查

- [ ] test-driven-development 技能可以调用
- [ ] systematic-debugging 技能可以调用
- [ ] 技能文档完整且清晰
- [ ] 技能示例可以运行
- [ ] 技能测试通过

### 集成检查

- [ ] 项目文档已更新
- [ ] 脚本已更新
- [ ] CI/CD 配置已更新
- [ ] 工作流程已更新

### 验证检查

- [ ] 测试套件通过
- [ ] 代码质量检查通过
- [ ] 构建成功
- [ ] 无功能回归

## 常见问题

### Q: 迁移后技能无法调用？

A: 检查以下几点：

1. 确认技能已安装到正确位置
2. 刷新技能列表：`/skills refresh`
3. 检查技能文件格式是否正确
4. 查看错误日志

### Q: 工具调用失败？

A: 确保工具映射正确：

```javascript
// 检查工具调用
read_file({ absolute_path: "/path/to/file" })  // 正确
read({ path: "/path/to/file" })  // 错误
```

### Q: 子代理调用失败？

A: 使用预定义代理类型：

```javascript
// 正确
task({
  subagent_type: "general-purpose",
  description: "Task",
  prompt: "Prompt"
})

// 错误
task({
  agent: "code-reviewer",  // iFlow CLI 不支持自定义代理
  description: "Task",
  prompt: "Prompt"
})
```

### Q: 上下文引用失败？

A: 使用 `useContext` 参数：

```javascript
// 正确
task({
  subagent_type: "general-purpose",
  description: "Task",
  prompt: "Prompt",
  useContext: true
})

// 错误
<context>
@PROJECT.md  // iFlow CLI 不支持 @file 语法
</context>
```

### Q: 测试脚本编码问题？

A: 使用 UTF8 编码：

```powershell
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
```

## 最佳实践

### 1. 渐进式迁移

不要一次性迁移所有功能。采用渐进式迁移：

1. 先迁移核心技能
2. 验证功能正常
3. 再迁移其他技能

### 2. 保持备份

迁移前始终备份现有配置和技能：

```bash
cp -r ~/.superpowers ~/superpowers-backup
```

### 3. 文档更新

及时更新项目文档，反映迁移后的变化：

```markdown
## 开发工作流程

### 测试驱动开发

使用 test-driven-development 技能：
1. 调用技能：`skill: "test-driven-development"`
2. 遵循 RED-GREEN-REFACTOR 循环
3. 验证测试通过
```

### 4. 团队培训

为团队成员提供培训，确保他们了解新系统：

1. 举办培训会议
2. 提供使用文档
3. 创建示例项目
4. 提供一对一指导

### 5. 持续监控

迁移后持续监控系统：

1. 监控错误日志
2. 收集用户反馈
3. 优化性能
4. 修复问题

## 后续支持

### 技术支持

- **文档**: 查看 [README.md](../README.md) 和 [ARCHITECTURE.md](./ARCHITECTURE.md)
- **问题反馈**: https://github.com/your-username/superpowers-iflow/issues
- **邮件支持**: your-email@example.com

### 社区支持

- **GitHub Discussions**: https://github.com/your-username/superpowers-iflow/discussions
- **Stack Overflow**: 使用标签 `superpowers-iflow`
- **Slack**: 加入我们的 Slack 频道

### 更新和升级

订阅更新通知：

```bash
# Watch GitHub 仓库
git remote add origin https://github.com/your-username/superpowers-iflow.git
git fetch origin
```

检查更新：

```bash
git pull origin main
```

## 总结

从 Superpowers 迁移到 Superpowers for iFlow CLI 是一个简单的过程，遵循本指南可以确保平滑过渡。关键步骤包括：

1. **准备工作**: 检查环境，备份数据
2. **安装技能**: 下载并安装技能
3. **验证功能**: 测试技能功能
4. **更新工作流程**: 更新文档和脚本
5. **清理和优化**: 清理旧文件，优化性能

迁移后，你将获得：

- ✅ 与 iFlow CLI 完全兼容的技能系统
- ✅ 简化的工具调用
- ✅ 清晰的文档和示例
- ✅ 持续的更新和支持

如有任何问题，请参考本文档或联系技术支持。

---

**文档版本**: 1.0.0
**最后更新**: 2026-03-05