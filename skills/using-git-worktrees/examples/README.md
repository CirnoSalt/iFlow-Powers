# Using Git Worktrees - 使用示例

## 简单示例（使用 .worktrees 目录）

假设您正在开发一个名为 "user-authentication" 的功能，并且项目中已经存在 `.worktrees` 目录。

### 步骤

1. **检查现有目录**
   ```powershell
   Test-Path .worktrees  # 返回 True
   ```

2. **验证目录被忽略**
   ```powershell
   git check-ignore -q .worktrees
   # 退出代码 0 表示被忽略
   ```

3. **创建 worktree**
   ```powershell
   git worktree add .worktrees/user-authentication -b feature/user-authentication
   cd .worktrees/user-authentication
   ```

4. **运行项目设置**
   ```powershell
   # 假设是 Node.js 项目
   npm install
   npm test
   # 输出: 42 tests passed, 0 failed
   ```

5. **报告结果**
   ```
   Worktree 就绪于 /path/to/project/.worktrees/user-authentication
   测试通过（42 测试，0 失败）
   准备实现 user-authentication 特性
   ```

## 复杂示例（使用全局目录）

假设您正在开发一个名为 "payment-gateway" 的功能，项目中没有现有的 worktree 目录，并且没有 CLAUDE.md 配置。

### 步骤

1. **检查现有目录**
   ```powershell
   Test-Path .worktrees  # 返回 False
   Test-Path worktrees   # 返回 False
   ```

2. **检查 CLAUDE.md**
   ```powershell
   Select-String -Path "CLAUDE.md" -Pattern "worktree.*director" -CaseSensitive:$false
   # 未找到匹配项
   ```

3. **询问用户**
   ```
   未找到 worktree 目录。我应该在哪里创建 worktree？

   1. .worktrees/ (项目本地，隐藏)
   2. ~/.config/superpowers/worktrees/<project-name>/ (全局位置)

   您更喜欢哪个？
   ```

   用户选择：2

4. **检测项目名称**
   ```powershell
   $project = Split-Path -Leaf (git rev-parse --show-toplevel)
   # $project = "my-ecommerce-app"
   ```

5. **创建 worktree**
   ```powershell
   $LOCATION = "~/.config/superpowers/worktrees/my-ecommerce-app"
   $BRANCH_NAME = "feature/payment-gateway"
   $path = "$LOCATION/$BRANCH_NAME"

   # 创建全局目录（如果不存在）
   New-Item -ItemType Directory -Path $LOCATION -Force

   git worktree add $path -b $BRANCH_NAME
   cd $path
   ```

6. **运行项目设置**
   ```powershell
   # 假设是 Python 项目
   pip install -r requirements.txt
   pytest
   # 输出: 78 tests passed, 0 failed
   ```

7. **报告结果**
   ```
   Worktree 就绪于 ~/.config/superpowers/worktrees/my-ecommerce-app/feature/payment-gateway
   测试通过（78 测试，0 失败）
   准备实现 payment-gateway 特性
   ```

## 特殊场景示例（安全性验证）

假设您正在开发一个名为 "api-v2" 的功能，项目中存在 `.worktrees` 目录，但它未被 git ignore。

### 步骤

1. **检查现有目录**
   ```powershell
   Test-Path .worktrees  # 返回 True
   ```

2. **验证目录被忽略**
   ```powershell
   git check-ignore -q .worktrees
   # 退出代码 1 表示未被忽略
   ```

3. **修复问题（根据 Jesse 的规则）**
   ```powershell
   # 添加到 .gitignore
   Add-Content .gitignore "`n.worktrees"

   # 提交更改
   git add .gitignore
   git commit -m "Ignore .worktrees directory"
   ```

4. **创建 worktree**
   ```powershell
   git worktree add .worktrees/api-v2 -b feature/api-v2
   cd .worktrees/api-v2
   ```

5. **运行项目设置**
   ```powershell
   # 假设是 Rust 项目
   cargo build
   cargo test
   # 输出: test result: ok. 156 passed; 0 failed
   ```

6. **报告结果**
   ```
   已将 .worktrees 添加到 .gitignore 并提交
   Worktree 就绪于 /path/to/project/.worktrees/api-v2
   测试通过（156 测试，0 失败）
   准备实现 api-v2 特性
   ```

## 测试失败场景

假设您正在开发一个名为 "search-optimization" 的功能，基线测试失败。

### 步骤

1. **检查现有目录**
   ```powershell
   Test-Path .worktrees  # 返回 True
   ```

2. **验证目录被忽略**
   ```powershell
   git check-ignore -q .worktrees
   # 退出代码 0 表示被忽略
   ```

3. **创建 worktree**
   ```powershell
   git worktree add .worktrees/search-optimization -b feature/search-optimization
   cd .worktrees/search-optimization
   ```

4. **运行项目设置**
   ```powershell
   # 假设是 Node.js 项目
   npm install
   npm test
   # 输出: 42 tests passed, 3 failed
   ```

5. **报告失败**
   ```
   Worktree 就绪于 /path/to/project/.worktrees/search-optimization
   测试失败（42 测试通过，3 失败）

   失败的测试:
   1. test_search_index.js:123 - Search returns incorrect results for special characters
   2. test_search_index.js:189 - Search performance below threshold
   3. test_search_api.js:45 - API endpoint returns 500 error

   是否继续实现 search-optimization 特性？（建议先调查并修复失败）
   ```

## Git Bash 版本示例

以下示例使用 Git Bash 命令（跨平台）：

### 简单示例

```bash
# 检查现有目录
ls -d .worktrees 2>/dev/null
# 输出: .worktrees

# 验证被忽略
git check-ignore -q .worktrees 2>/dev/null
# 退出代码 0 表示被忽略

# 创建 worktree
git worktree add .worktrees/user-authentication -b feature/user-authentication
cd .worktrees/user-authentication

# 运行项目设置（Node.js）
npm install
npm test
# 输出: 42 tests passed, 0 failed

# 报告结果
echo "Worktree 就绪于 $(pwd)"
echo "测试通过（42 测试，0 失败）"
echo "准备实现 user-authentication 特性"
```

### 复杂示例（全局目录）

```bash
# 检查现有目录
ls -d .worktrees 2>/dev/null || ls -d worktrees 2>/dev/null
# 无输出

# 检查 CLAUDE.md
grep -i "worktree.*director" CLAUDE.md 2>/dev/null
# 无输出

# 询问用户
echo "未找到 worktree 目录。我应该在哪里创建 worktree？"
echo "1. .worktrees/ (项目本地，隐藏)"
echo "2. ~/.config/superpowers/worktrees/<project-name>/ (全局位置)"
read -p "您更喜欢哪个？(1/2): " choice

# 检测项目名称
project=$(basename "$(git rev-parse --show-toplevel)")

# 创建 worktree（假设用户选择 2）
BRANCH_NAME="feature/payment-gateway"
LOCATION="~/.config/superpowers/worktrees/$project"
path="$LOCATION/$BRANCH_NAME"

# 创建全局目录
mkdir -p "$LOCATION"

# 创建 worktree
git worktree add "$path" -b "$BRANCH_NAME"
cd "$path"

# 运行项目设置（Python）
pip install -r requirements.txt
pytest
# 输出: 78 tests passed, 0 failed

# 报告结果
echo "Worktree 就绪于 $(pwd)"
echo "测试通过（78 测试，0 失败）"
echo "准备实现 payment-gateway 特性"
```

## 最佳实践

1. **始终验证目录被忽略**（对于项目本地目录）
2. **遵循目录优先级**（现有 > CLAUDE.md > 询问）
3. **运行基线测试**以确保清洁的开始状态
4. **自动检测项目设置**（不要硬编码）
5. **使用 Unix 风格路径**以获得跨平台兼容性

## 故障排除

### 问题: "fatal: Invalid path" 错误

**解决方案**: 确保路径使用正斜杠（`/`），即使在 Windows 上：
```powershell
# 错误
git worktree add .worktrees\user-auth -b feature/user-auth

# 正确
git worktree add .worktrees/user-auth -b feature/user-auth
```

### 问题: Worktree 目录未被跟踪

**解决方案**: 使用 `git worktree list` 查看所有 worktree：
```powershell
git worktree list
```

### 问题: 无法删除 worktree

**解决方案**: 使用 `git worktree remove` 命令：
```powershell
git worktree remove .worktrees/user-auth
```

如果仍然失败，手动删除并使用 `git worktree prune`：
```powershell
Remove-Item -Recurse -Force .worktrees/user-auth
git worktree prune
```