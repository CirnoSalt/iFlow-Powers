# Finishing a Development Branch - 使用示例

## 简单示例（本地合并）

假设您已完成 user-authentication 功能的开发，并且所有测试都通过。

### 步骤

1. **验证测试**
   ```powershell
   npm test
   # 输出: 47 tests passed, 0 failed
   ```

2. **确定基础分支**
   ```powershell
   $mainBase = git merge-base HEAD main 2>$null
   # 检测到基础分支：main
   ```

3. **呈现选项**
   ```
   实现完成。您想要做什么？

   1. 合并到 main 本地
   2. 推送并创建 Pull Request
   3. 保持分支原样（我稍后处理）
   4. 丢弃此工作

   选择哪个选项？
   ```

   用户选择：1

4. **执行本地合并**
   ```powershell
   # 切换到基础分支
   git checkout main

   # 拉取最新
   git pull

   # 合并特性分支
   git merge feature/user-authentication

   # 验证测试
   npm test
   # 输出: 48 tests passed, 0 failed

   # 删除特性分支
   git branch -d feature/user-authentication
   ```

5. **清理 worktree**
   ```powershell
   # 检查是否在 worktree 中
   if (git worktree list | Select-String "feature/user-authentication") {
       git worktree remove .
   }
   ```

6. **报告结果**
   ```
   特性分支已成功合并到 main
   Worktree 已清理
   开发工作完成
   ```

## 复杂示例（创建 PR）

假设您已完成 payment-gateway 功能的开发，并且需要创建 PR 进行代码审查。

### 步骤

1. **验证测试**
   ```powershell
   npm test
   # 输出: 78 tests passed, 0 failed
   ```

2. **确定基础分支**
   ```powershell
   $baseBranch = "main"
   # 检测到基础分支：main
   ```

3. **呈现选项**
   ```
   实现完成。您想要做什么？

   1. 合并到 main 本地
   2. 推送并创建 Pull Request
   3. 保持分支原样（我稍后处理）
   4. 丢弃此工作

   选择哪个选项？
   ```

   用户选择：2

4. **执行推送并创建 PR**
   ```powershell
   # 推送分支
   git push -u origin feature/payment-gateway

   # 创建 PR
   gh pr create --title "Add payment gateway integration" --body @"
   ## 摘要
   - 集成 Stripe 支付网关
   - 添加支付处理 API
   - 实现支付状态跟踪

   ## 测试计划
   - [ ] 单元测试通过（78/78）
   - [ ] 集成测试通过
   - [ ] 代码审查完成
   - [ ] 文档更新
   "@
   ```

5. **保留 worktree**
   ```
   Pull Request 已创建：https://github.com/user/repo/pull/123
   Worktree 保留在：/path/to/project/.worktrees/payment-gateway
   可以继续在 worktree 中工作，直到 PR 被合并
   ```

## 特殊场景示例（丢弃工作）

假设您正在开发一个实验性功能，但决定不继续。

### 步骤

1. **验证测试**
   ```powershell
   npm test
   # 输出: 52 tests passed, 0 failed
   ```

2. **呈现选项**
   ```
   实现完成。您想要做什么？

   1. 合并到 main 本地
   2. 推送并创建 Pull Request
   3. 保持分支原样（我稍后处理）
   4. 丢弃此工作

   选择哪个选项？
   ```

   用户选择：4

3. **确认丢弃**
   ```
   这将永久删除：
   - 分支 feature/experimental-api
   - 所有提交：a1b2c3d, e4f5g6h, i7j8k9l
   - Worktree 位于：/path/to/project/.worktrees/experimental-api

   输入 'discard' 以确认。
   ```

   用户输入：discard

4. **执行丢弃**
   ```powershell
   # 切换到基础分支
   git checkout main

   # 强制删除特性分支
   git branch -D feature/experimental-api
   ```

5. **清理 worktree**
   ```powershell
   # 清理 worktree
   git worktree remove .
   ```

6. **报告结果**
   ```
   分支 feature/experimental-api 已被删除
   Worktree 已清理
   实验性工作已被丢弃
   ```

## 测试失败场景

假设您正在开发 search-optimization 功能，但测试失败。

### 步骤

1. **验证测试**
   ```powershell
   npm test
   # 输出: 42 tests passed, 3 failed
   ```

2. **报告失败**
   ```
   测试失败（3 个失败）。必须先修复才能完成：

   失败的测试:
   1. test_search_index.js:123 - 搜索返回特殊字符的结果不正确
   2. test_search_index.js:189 - 搜索性能低于阈值
   3. test_search_api.js:45 - API 端点返回 500 错误

   在测试通过之前无法继续合并/PR。

   请先修复失败的测试，然后重新运行 finishing-a-development-branch 技能。
   ```

   停止。不继续到选项呈现。

## Git Bash 版本示例

以下示例使用 Git Bash 命令（跨平台）：

### 简单示例（本地合并）

```bash
# 1. 验证测试
npm test
# 输出: 47 tests passed, 0 failed

# 2. 确定基础分支
BASE_SHA=$(git merge-base HEAD main 2>/dev/null)
base_branch="main"

# 3. 切换到基础分支
git checkout $base_branch

# 4. 拉取最新
git pull

# 5. 合并特性分支
git merge feature/user-authentication

# 6. 验证测试
npm test
# 输出: 48 tests passed, 0 failed

# 7. 删除特性分支
git branch -d feature/user-authentication

# 8. 清理 worktree
if git worktree list | grep -q "feature/user-authentication"; then
    git worktree remove .
fi

echo "特性分支已成功合并到 main"
echo "Worktree 已清理"
```

### 复杂示例（创建 PR）

```bash
# 1. 验证测试
npm test
# 输出: 78 tests passed, 0 failed

# 2. 推送分支
git push -u origin feature/payment-gateway

# 3. 创建 PR
gh pr create --title "Add payment gateway integration" --body '## 摘要
- 集成 Stripe 支付网关
- 添加支付处理 API
- 实现支付状态跟踪

## 测试计划
- [ ] 单元测试通过（78/78）
- [ ] 集成测试通过
- [ ] 代码审查完成
- [ ] 文档更新'

echo "Pull Request 已创建"
echo "Worktree 保留，可以继续工作"
```

## 最佳实践

1. **始终在呈现选项之前验证测试**，不要跳过
2. **精确呈现 4 个选项**，不要添加额外信息
3. **对于选项 4，要求明确的 "discard" 确认**
4. **仅清理选项 1 和 4 的 worktree**，保留选项 2 和 3
5. **自动检测基础分支**，但允许用户指定
6. **提供清晰的失败消息**，帮助用户理解问题

## 故障排除

### 问题: "fatal: branch 'feature-x' not found" 错误

**解决方案**: 确保您在正确的分支上：
```powershell
git branch --show-current
```

### 问题: Worktree 无法删除

**解决方案**: 确保您不在 worktree 中：
```powershell
# 切换到主仓库
cd /path/to/project
git worktree remove .worktrees/feature-x
```

### 问题: 测试在合并后失败

**解决方案**: 解决合并冲突，然后重新运行测试：
```powershell
# 解决冲突
git status
git add <resolved-files>
git commit

# 重新运行测试
npm test
```

## 与其他技能的集成

### 与 using-git-worktrees 配合

```powershell
# 1. 使用 using-git-worktrees 创建隔离环境
# （已在开始时完成）

# 2. 开发功能
# ...

# 3. 完成开发后使用 finishing-a-development-branch
# 自动清理 using-git-worktrees 创建的 worktree
```

### 与 subagent-driven-development 配合

```powershell
# 1. 使用 subagent-driven-development 执行计划
# （已在开始时完成）

# 2. 所有任务完成后，使用 finishing-a-development-branch
# 呈现选项并完成工作
```

### 与 executing-plans 配合

```powershell
# 1. 使用 executing-plans 执行计划
# （已在开始时完成）

# 2. 所有批次完成后，使用 finishing-a-development-branch
# 呈现选项并完成工作
```