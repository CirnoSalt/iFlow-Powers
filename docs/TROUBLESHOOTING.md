# 故障排除指南

## 文档信息

- **版本**: 1.0.0
- **日期**: 2026-03-05
- **作者**: iFlow CLI
- **状态**: Completed

## 概述

本指南提供 Superpowers for iFlow CLI 的常见问题和解决方案，帮助你快速诊断和解决问题。

## 目录

- [安装问题](#安装问题)
- [技能调用问题](#技能调用问题)
- [工具映射问题](#工具映射问题)
- [子代理调用问题](#子代理调用问题)
- [性能问题](#性能问题)
- [Windows 特定问题](#windows-特定问题)
- [诊断工具](#诊断工具)
- [获取帮助](#获取帮助)

---

## 安装问题

### 问题 1: 技能无法调用

**症状**:

调用技能时失败，提示技能不存在。

```
技能 'test-driven-development' 不存在
```

**可能原因**:

1. 技能未安装
2. 技能列表未刷新
3. 技能文件路径不正确
4. 技能名称拼写错误

**解决步骤**:

1. **检查技能是否已安装**:

```bash
/skills list
```

如果技能不存在，继续下一步。

2. **安装技能**:

```bash
# 全局安装
cp -r skills/* ~/.iflow/skills/

# 或项目安装
cp -r skills/* .iflow/skills/
```

3. **刷新技能列表**:

```bash
/skills refresh
```

预期输出：

```
技能列表已刷新。发现 8 个技能。
```

4. **验证技能可用**:

```bash
/skills list
```

应该看到所有已安装的技能。

**预防措施**:

- 安装技能后立即刷新技能列表
- 定期检查技能列表
- 使用正确的技能名称（大小写敏感）

**相关资源**:
- [集成指南](INTEGRATION.md)
- [技能索引](../lib/SKILL-INDEX.md)

---

### 问题 2: iFlow CLI 版本不兼容

**症状**:

技能调用失败，提示版本不兼容。

```
错误: 需要 iFlow CLI 版本 0.4.11 或更高
```

**可能原因**:

1. iFlow CLI 版本过低
2. 技能要求更高的版本

**解决步骤**:

1. **检查当前版本**:

```bash
iflow --version
```

2. **升级 iFlow CLI**:

```bash
# 使用 npm
npm install -g @iflow/cli@latest

# 或使用 pip
pip install --upgrade iflow-cli
```

3. **验证版本**:

```bash
iflow --version
```

应该显示版本 0.4.11 或更高。

**预防措施**:

- 定期更新 iFlow CLI
- 在迁移前检查版本要求
- 保持依赖项更新

---

### 问题 3: Python 环境问题

**症状**:

技能调用失败，提示 Python 不可用。

```
错误: Python 3.x 未安装
```

**可能原因**:

1. Python 未安装
2. Python 版本过低
3. Python 不在 PATH 中

**解决步骤**:

1. **检查 Python 是否安装**:

```bash
python --version
```

2. **安装 Python**:

```bash
# Windows (使用 winget)
winget install Python.Python.3.12

# 或从官网下载
# https://www.python.org/downloads/
```

3. **验证 Python 版本**:

```bash
python --version
```

应该显示 Python 3.x。

4. **检查 Python 路径**:

```bash
where python
```

应该显示 Python 可执行文件的路径。

**预防措施**:

- 安装最新稳定版 Python
- 将 Python 添加到 PATH
- 使用虚拟环境隔离项目依赖

---

## 技能调用问题

### 问题 4: 技能执行超时

**症状**:

技能调用后长时间无响应，最终超时。

**可能原因**:

1. 技能执行时间过长
2. 网络请求超时
3. 资源限制

**解决步骤**:

1. **检查技能执行状态**:

```bash
# 查看技能日志
tail -f ~/.iflow/logs/skills.log
```

2. **增加超时时间**:

在调用技能时指定更长的超时时间：

```javascript
run_shell_command({
  command: "npm test",
  description: "Run tests",
  timeout: 300  // 5 分钟
});
```

3. **检查网络连接**:

```bash
ping iflow.cli
```

4. **检查系统资源**:

```bash
# Windows
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10

# 检查内存
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 10
```

**预防措施**:

- 优化技能执行效率
- 使用后台执行（run_in_bg）
- 监控系统资源使用

---

### 问题 5: 技能返回错误

**症状**:

技能执行完成，但返回错误信息。

```
错误: 无法读取文件 /path/to/file.txt
```

**可能原因**:

1. 文件不存在
2. 文件路径不正确
3. 权限不足

**解决步骤**:

1. **检查文件是否存在**:

```bash
# Windows
Test-Path /path/to/file.txt

# 如果不存在，创建文件
New-Item -Path /path/to/file.txt -ItemType File
```

2. **检查文件路径**:

```bash
# 使用绝对路径
$fullPath = Resolve-Path ./file.txt
Write-Host $fullPath
```

3. **检查文件权限**:

```bash
# Windows
Get-Acl /path/to/file.txt | Format-List

# 修改权限（如果需要）
icacls /path/to/file.txt /grant Users:F
```

**预防措施**:

- 始终使用绝对路径
- 在操作前检查文件是否存在
- 确保有足够的权限

---

## 工具映射问题

### 问题 6: 工具调用失败

**症状**:

工具调用失败，提示参数错误。

```
错误: 参数 'absolute_path' 是必需的
```

**可能原因**:

1. 参数名称不正确
2. 参数类型不正确
3. 缺少必需参数

**解决步骤**:

1. **检查工具映射**:

参考 [API 参考文档](API-REFERENCE.md) 确认正确的参数名称和类型。

2. **检查参数传递**:

```javascript
// ✅ 正确
read_file({
  absolute_path: "/path/to/file.txt"
});

// ❌ 错误 - 参数名称不正确
read_file({
  path: "/path/to/file.txt"
});

// ❌ 错误 - 缺少必需参数
read_file();
```

3. **验证参数类型**:

```javascript
// ✅ 正确 - 字符串
read_file({
  absolute_path: "/path/to/file.txt"
});

// ❌ 错误 - 类型不正确
read_file({
  absolute_path: ["/path/to/file.txt"]  // 数组而不是字符串
});
```

**预防措施**:

- 参考 API 文档确认参数
- 使用正确的参数名称
- 确保参数类型正确

---

### 问题 7: 命令执行失败

**症状**:

shell 命令执行失败。

```
错误: 命令 'npm' 未找到
```

**可能原因**:

1. 命令不存在
2. 命令不在 PATH 中
3. 命令语法错误

**解决步骤**:

1. **检查命令是否存在**:

```bash
where npm
```

2. **安装缺失的命令**:

```bash
# 安装 Node.js 和 npm
winget install OpenJS.NodeJS

# 验证安装
npm --version
```

3. **检查命令语法**:

```bash
# ✅ 正确 - PowerShell 语法
npm test; if ($?) { npm run build }

# ❌ 错误 - 不支持 &&
npm test && npm run build
```

4. **使用绝对路径**:

```bash
# 使用完整路径
C:\Program Files\nodejs\npm.exe test
```

**预防措施**:

- 在 Windows 上使用 PowerShell 语法
- 使用分号（;）分隔命令
- 验证命令在 PATH 中

---

## 子代理调用问题

### 问题 8: 子代理调用失败

**症状**:

子代理调用失败，提示代理类型不存在。

```
错误: 代理类型 'custom-agent' 不存在
```

**可能原因**:

1. 使用了未定义的代理类型
2. 代理类型名称拼写错误
3. 不支持自定义代理

**解决步骤**:

1. **检查代理类型**:

参考 [API 参考文档](API-REFERENCE.md#子代理-api) 确认可用的代理类型。

2. **使用预定义代理类型**:

```javascript
// ✅ 正确 - 使用预定义代理
task({
  subagent_type: "general-purpose",
  description: "Review code",
  prompt: "Review the code"
});

// ❌ 错误 - 自定义代理
task({
  subagent_type: "custom-agent",  // 不支持
  description: "Review code",
  prompt: "Review the code"
});
```

3. **在 prompt 中定义角色**:

```javascript
// ✅ 正确 - 在 prompt 中定义角色
task({
  subagent_type: "general-purpose",
  description: "Review code",
  prompt: "You are a professional code reviewer. Review the following code for quality and best practices"
});
```

**预防措施**:

- 使用预定义代理类型
- 在 prompt 中明确定义角色
- 参考 API 文档确认可用代理

---

### 问题 9: 子代理无响应

**症状**:

子代理调用后长时间无响应。

**可能原因**:

1. 任务过于复杂
2. 资源限制
3. 网络问题

**解决步骤**:

1. **简化任务**:

将复杂任务分解为多个小任务：

```javascript
// ❌ 错误 - 任务过于复杂
task({
  subagent_type: "general-purpose",
  description: "Complete all tasks",
  prompt: "Analyze, design, implement, test, and document this feature"
});

// ✅ 正确 - 分解任务
task({
  subagent_type: "plan-agent",
  description: "Create plan",
  prompt: "Create a detailed plan for implementing this feature"
});
// ... 然后逐步执行
```

2. **使用 useContext**:

```javascript
// ✅ 正确 - 传递上下文
task({
  subagent_type: "general-purpose",
  description: "Review code",
  prompt: "Review the code",
  useContext: true
});
```

3. **检查网络连接**:

```bash
ping iflow.cli
```

**预防措施**:

- 将复杂任务分解
- 使用 useContext 传递上下文
- 简化 prompt

---

## 性能问题

### 问题 10: 技能加载缓慢

**症状**:

技能列表刷新或加载技能时速度很慢。

**可能原因**:

1. 技能文件过多
2. 文件系统性能问题
3. 网络延迟

**解决步骤**:

1. **检查技能数量**:

```bash
/skills list
```

2. **清理未使用的技能**:

```bash
# 删除未使用的技能
Remove-Item -Path ~/.iflow/skills/unused-skill -Recurse
```

3. **优化文件系统**:

```bash
# Windows - 检查磁盘性能
Get-PhysicalDisk | Select-Object DeviceId, MediaType, HealthStatus

# 清理临时文件
Remove-Item -Path $env:TEMP\* -Recurse -Force
```

4. **使用本地技能**:

将技能放在项目目录而不是全局目录：

```bash
cp -r skills/* .iflow/skills/
```

**预防措施**:

- 只安装需要的技能
- 定期清理未使用的技能
- 使用项目级技能

---

### 问题 11: 内存使用过高

**症状**:

iFlow CLI 进程占用大量内存。

**可能原因**:

1. 上下文过大
2. 未释放的资源
3. 内存泄漏

**解决步骤**:

1. **检查内存使用**:

```bash
Get-Process | Where-Object { $_.ProcessName -like "*iflow*" } | Select-Object ProcessName, WorkingSet
```

2. **限制上下文大小**:

```javascript
// ✅ 正确 - 只传递必要的上下文
task({
  subagent_type: "general-purpose",
  description: "Review specific file",
  prompt: "Review only the main.ts file",
  useContext: false  // 不传递全部上下文
});
```

3. **重启 iFlow CLI**:

```bash
# 终止进程
Stop-Process -Name iflow -Force

# 重新启动
iflow
```

**预防措施**:

- 限制上下文大小
- 按需加载文件
- 定期重启 iFlow CLI

---

## Windows 特定问题

### 问题 12: 路径分隔符问题

**症状**:

文件操作失败，提示路径不正确。

```
错误: 路径包含无效字符
```

**可能原因**:

1. 路径分隔符混用
2. 反斜杠转义问题
3. 路径长度限制

**解决步骤**:

1. **使用正斜杠**:

```javascript
// ✅ 正确 - 使用正斜杠
read_file({
  absolute_path: "C:/path/to/file.txt"
});

// ✅ 也可以 - 使用双反斜杠
read_file({
  absolute_path: "C:\\path\\to\\file.txt"
});

// ❌ 错误 - 单反斜杠（转义字符）
read_file({
  absolute_path: "C:\path\to\file.txt"  // \t 会被解释为制表符
});
```

2. **使用绝对路径**:

```javascript
// ✅ 正确 - 绝对路径
read_file({
  absolute_path: "C:/path/to/file.txt"
});

// ❌ 错误 - 相对路径
read_file({
  absolute_path: "./file.txt"  // 不支持相对路径
});
```

3. **处理路径长度**:

```bash
# Windows 路径长度限制为 260 字符
# 使用长路径支持（需要管理员权限）
# 在注册表中启用长路径：
# HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem
# LongPathsEnabled = 1
```

**预防措施**:

- 使用正斜杠（/）而不是反斜杠（\）
- 始终使用绝对路径
- 注意路径长度限制

---

### 问题 13: 编码问题

**症状**:

读取或写入文件时出现乱码。

```
错误: 无法解析文件内容
```

**可能原因**:

1. 文件编码不是 UTF-8
2. PowerShell 控制台编码问题
3. 读取时编码未指定

**解决步骤**:

1. **检查文件编码**:

```bash
# 使用 PowerShell 检查编码
$fileContent = [System.IO.File]::ReadAllBytes("C:/path/to/file.txt")
$encoding = [System.Text.Encoding]::UTF8.GetString($fileContent)
```

2. **使用 UTF-8 编码**:

```powershell
# 读取文件时指定编码
$content = [System.IO.File]::ReadAllText("C:/path/to/file.txt", [System.Text.Encoding]::UTF8)

# 写入文件时指定编码
[System.IO.File]::WriteAllText("C:/path/to/file.txt", $content, [System.Text.Encoding]::UTF8)
```

3. **设置 PowerShell 控制台编码**:

```bash
# 设置控制台为 UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# 验证编码
chcp 65001
```

**预防措施**:

- 始终使用 UTF-8 编码
- 在读写时指定编码
- 设置控制台编码为 UTF-8

---

### 问题 14: 权限问题

**症状**:

文件操作失败，提示权限不足。

```
错误: 拒绝访问
```

**可能原因**:

1. 文件或目录被锁定
2. 用户权限不足
3. 文件只读

**解决步骤**:

1. **检查文件锁定**:

```bash
# Windows - 检查哪些进程锁定了文件
# 需要安装 Sysinternals Suite
handle.exe C:/path/to/file.txt
```

2. **检查文件权限**:

```bash
# Windows - 检查权限
Get-Acl C:/path/to/file.txt | Format-List
```

3. **修改权限**:

```bash
# Windows - 授予完全控制权限
icacls C:/path/to/file.txt /grant Users:F

# 或以管理员身份运行
# 右键 PowerShell -> 以管理员身份运行
```

4. **关闭锁定文件的进程**:

```bash
# 强制关闭进程
Stop-Process -Name "notepad" -Force
```

**预防措施**:

- 以管理员身份运行 iFlow CLI
- 在操作前关闭文件
- 检查并修改文件权限

---

## 诊断工具

### 环境检查脚本

创建诊断脚本 `diagnose.ps1`:

```powershell
# iFlow CLI 诊断脚本

Write-Host "=== iFlow CLI 环境诊断 ===" -ForegroundColor Cyan

# 1. 检查 iFlow CLI 版本
Write-Host "`n[1] 检查 iFlow CLI 版本..." -ForegroundColor Yellow
try {
    $version = iflow --version 2>&1
    Write-Host "iFlow CLI 版本: $version" -ForegroundColor Green
} catch {
    Write-Host "错误: iFlow CLI 未安装" -ForegroundColor Red
}

# 2. 检查 Python 版本
Write-Host "`n[2] 检查 Python 版本..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version 2>&1
    Write-Host "Python 版本: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "错误: Python 未安装" -ForegroundColor Red
}

# 3. 检查 Git 版本
Write-Host "`n[3] 检查 Git 版本..." -ForegroundColor Yellow
try {
    $gitVersion = git --version 2>&1
    Write-Host "Git 版本: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "错误: Git 未安装" -ForegroundColor Red
}

# 4. 检查技能目录
Write-Host "`n[4] 检查技能目录..." -ForegroundColor Yellow
$skillDir = "$env:USERPROFILE\.iflow\skills"
if (Test-Path $skillDir) {
    $skillCount = (Get-ChildItem $skillDir -Filter "SKILL.md" -Recurse).Count
    Write-Host "技能目录: $skillDir" -ForegroundColor Green
    Write-Host "已安装技能数: $skillCount" -ForegroundColor Green
} else {
    Write-Host "警告: 技能目录不存在: $skillDir" -ForegroundColor Yellow
}

# 5. 检查控制台编码
Write-Host "`n[5] 检查控制台编码..." -ForegroundColor Yellow
$encoding = [Console]::OutputEncoding.EncodingName
Write-Host "控制台编码: $encoding" -ForegroundColor Green

# 6. 检查磁盘空间
Write-Host "`n[6] 检查磁盘空间..." -ForegroundColor Yellow
$disk = Get-PSDrive C
$used = [math]::Round(($disk.Used / 1GB), 2)
$free = [math]::Round(($disk.Free / 1GB), 2)
Write-Host "C: 盘使用: $used GB / 可用: $free GB" -ForegroundColor Green

Write-Host "`n=== 诊断完成 ===" -ForegroundColor Cyan
```

运行诊断脚本:

```bash
.\diagnose.ps1
```

---

### 日志分析

查看 iFlow CLI 日志:

```bash
# 查看日志目录
Get-ChildItem ~/.iflow/logs

# 查看最新日志
Get-Content ~/.iflow/logs/latest.log -Tail 50

# 搜索错误
Select-String -Path ~/.iflow/logs\*.log -Pattern "错误|Error|Exception" | Select-Object -First 20
```

---

## 获取帮助

### 文档资源

- [架构设计文档](ARCHITECTURE.md)
- [集成指南](INTEGRATION.md)
- [迁移指南](MIGRATION.md)
- [API 参考文档](API-REFERENCE.md)
- [技能索引](../lib/SKILL-INDEX.md)

### 社区支持

- **GitHub Issues**: https://github.com/your-username/superpowers-iflow/issues
- **GitHub Discussions**: https://github.com/your-username/superpowers-iflow/discussions
- **Stack Overflow**: 使用标签 `superpowers-iflow`

### 报告问题

如果遇到未在此指南中解决的问题，请：

1. 收集诊断信息
2. 记录错误消息
3. 提供复现步骤
4. 提交 GitHub Issue

### Issue 模板

```markdown
## 问题描述

[简要描述问题]

## 复现步骤

1. [步骤 1]
2. [步骤 2]
3. [步骤 3]

## 期望行为

[描述期望的行为]

## 实际行为

[描述实际发生的行为]

## 错误消息

```
[粘贴错误消息]
```

## 环境信息

- iFlow CLI 版本: [版本]
- 操作系统: Windows [版本]
- Python 版本: [版本]
- Git 版本: [版本]

## 诊断输出

```
[粘贴诊断脚本输出]
```

## 其他信息

[任何其他相关信息]
```

---

## 总结

本故障排除指南涵盖了 Superpowers for iFlow CLI 的常见问题和解决方案。如果问题仍未解决：

1. 使用诊断工具收集信息
2. 查看日志文件
3. 搜索社区资源
4. 提交 GitHub Issue

记住，大多数问题都可以通过：

- 检查版本兼容性
- 验证配置正确性
- 查看错误日志
- 使用诊断工具

来解决。

---

**文档版本**: 1.0.0
**最后更新**: 2026-03-05