# Superpowers for iFlow CLI - 集成指南

## 文档信息

- **版本**: 1.0.0
- **日期**: 2026-03-05
- **作者**: iFlow CLI
- **状态**: 已完成

## 目录

- [概述](#概述)
- [与 iFlow CLI 集成](#与-iflow-cli-集成)
- [与项目工作流集成](#与项目工作流集成)
- [与 CI/CD 集成](#与-cicd-集成)
- [与开发工具集成](#与开发工具集成)
- [高级集成场景](#高级集成场景)
- [故障排除](#故障排除)
- [最佳实践](#最佳实践)

## 概述

### 集成目标

本指南说明如何将 Superpowers 技能与 iFlow CLI 的其他功能集成，创建高效的开发工作流。

### 集成范围

- **iFlow CLI 核心**: 技能系统、工具系统、子代理系统
- **项目工作流**: 开发、测试、部署
- **CI/CD**: GitHub Actions、GitLab CI、Jenkins
- **开发工具**: VS Code、Git、Docker

## 与 iFlow CLI 集成

### 技能系统集成

#### 1. 技能调用

```bash
# 方法 1: 使用 skill 命令
skill: "test-driven-development"

# 方法 2: 在提示中引用
使用 test-driven-development 技能来实现这个功能
```

#### 2. 技能组合

```bash
# 组合使用多个技能
skill: "systematic-debugging"
# ... 执行调试流程
skill: "test-driven-development"
# ... 使用 TDD 修复问题
```

#### 3. 技能参数传递

```javascript
// 在技能调用中传递参数
task({
  subagent_type: "general-purpose",
  description: "Execute skill with parameters",
  prompt: `
    使用 test-driven-development 技能，参数：
    - 测试框架: Jest
    - 目标语言: TypeScript
    - 项目类型: Web 应用
  `,
  useContext: true
});
```

### 工具系统集成

#### 1. 文件操作集成

```javascript
// 读取配置文件
read_file({ absolute_path: "/path/to/config.json" });

// 使用技能处理
skill: "test-driven-development";

// 写入结果
write_file({
  file_path: "/path/to/result.json",
  content: JSON.stringify(result)
});
```

#### 2. 命令执行集成

```javascript
// 运行测试
run_shell_command({
  command: "npm test",
  description: "Run tests"
});

// 使用技能分析结果
skill: "systematic-debugging";

// 修复问题
run_shell_command({
  command: "npm run fix",
  description: "Fix issues"
});
```

#### 3. 子代理集成

```javascript
// 派遣子代理执行任务
task({
  subagent_type: "general-purpose",
  description: "Execute skill task",
  prompt: `
    使用 test-driven-development 技能完成以下任务：
    1. 编写测试
    2. 实现代码
    3. 验证结果
  `,
  useContext: true
});
```

## 与项目工作流集成

### 开发工作流

#### 1. 功能开发工作流

```bash
# 1. 创建功能分支
git checkout -b feature/new-feature

# 2. 使用 TDD 技能开发
skill: "test-driven-development"
# - 编写测试
# - 实现功能
# - 验证测试

# 3. 代码审查
skill: "systematic-debugging"
# - 检查代码质量
# - 识别潜在问题

# 4. 提交代码
git add .
git commit -m "feat: add new feature"

# 5. 推送分支
git push origin feature/new-feature
```

#### 2. Bug 修复工作流

```bash
# 1. 创建修复分支
git checkout -b fix/bug-123

# 2. 使用 Debugging 技能诊断
skill: "systematic-debugging"
# - 分析错误
# - 找到根本原因

# 3. 使用 TDD 技能修复
skill: "test-driven-development"
# - 编写失败测试
# - 实现修复
# - 验证测试

# 4. 提交修复
git add .
git commit -m "fix: resolve bug-123"

# 5. 推送分支
git push origin fix/bug-123
```

### 测试工作流

#### 1. 单元测试

```bash
# 使用 TDD 技能编写单元测试
skill: "test-driven-development"

# 编写测试
write_file({
  file_path: "/path/to/test.spec.ts",
  content: `
    test('should return correct result', () => {
      expect(result).toBe(expected);
    });
  `
});

# 运行测试
run_shell_command({
  command: "npm test -- unit",
  description: "Run unit tests"
});
```

#### 2. 集成测试

```bash
# 使用 Debugging 技能诊断集成问题
skill: "systematic-debugging"

# 分析集成错误
read_file({ absolute_path: "/path/to/error.log" });

# 修复问题
write_file({
  file_path: "/path/to/integration-test.spec.ts",
  content: "// 更新集成测试"
});

# 运行集成测试
run_shell_command({
  command: "npm test -- integration",
  description: "Run integration tests"
});
```

### 部署工作流

#### 1. 预部署检查

```bash
# 使用技能检查代码质量
skill: "systematic-debugging"

# 运行代码检查
run_shell_command({
  command: "npm run lint",
  description: "Run linter"
});

# 运行测试
run_shell_command({
  command: "npm test",
  description: "Run all tests"
});

# 构建项目
run_shell_command({
  command: "npm run build",
  description: "Build project"
});
```

#### 2. 部署后验证

```bash
# 部署到生产环境
run_shell_command({
  command: "npm run deploy",
  description: "Deploy to production"
});

# 使用技能验证部署
skill: "systematic-debugging"

# 检查日志
read_file({ absolute_path: "/path/to/production.log" });

# 验证功能
run_shell_command({
  command: "npm run verify",
  description: "Verify deployment"
});
```

## 与 CI/CD 集成

### GitHub Actions 集成

#### 1. 创建工作流文件

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2

    - name: Setup Node.js
      uses: actions/setup-node@v2
      with:
        node-version: '18'

    - name: Install dependencies
      run: npm ci

    - name: Run TDD tests
      run: |
        # 使用 iFlow CLI 运行 TDD 技能
        iflow skill invoke test-driven-development
        npm test

    - name: Debug if failed
      if: failure()
      run: |
        # 使用 iFlow CLI 运行 Debugging 技能
        iflow skill invoke systematic-debugging
```

#### 2. Pull Request 工作流

```yaml
# .github/workflows/pr.yml
name: Pull Request

on:
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  review:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2

    - name: Code Review
      run: |
        # 使用技能进行代码审查
        iflow skill invoke systematic-debugging
        iflow skill invoke test-driven-development

    - name: Comment on PR
      uses: actions/github-script@v6
      with:
        script: |
          github.rest.issues.createComment({
            issue_number: context.issue.number,
            owner: context.repo.owner,
            repo: context.repo.repo,
            body: '🤖 Code review completed using Superpowers skills'
          })
```

### GitLab CI 集成

#### 1. 创建 .gitlab-ci.yml

```yaml
# .gitlab-ci.yml
stages:
  - test
  - review
  - deploy

test:
  stage: test
  script:
    - npm ci
    - iflow skill invoke test-driven-development
    - npm test
  artifacts:
    reports:
      junit: coverage/junit.xml

review:
  stage: review
  script:
    - iflow skill invoke systematic-debugging
    - npm run lint
  only:
    - merge_requests

deploy:
  stage: deploy
  script:
    - iflow skill invoke systematic-debugging
    - npm run build
    - npm run deploy
  only:
    - main
```

### Jenkins 集成

#### 1. 创建 Jenkinsfile

```groovy
// Jenkinsfile
pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                sh 'npm ci'
                sh 'iflow skill invoke test-driven-development'
                sh 'npm test'
            }
        }

        stage('Review') {
            steps {
                sh 'iflow skill invoke systematic-debugging'
                sh 'npm run lint'
            }
        }

        stage('Deploy') {
            steps {
                sh 'iflow skill invoke systematic-debugging'
                sh 'npm run build'
                sh 'npm run deploy'
            }
        }
    }

    post {
        always {
            junit 'coverage/junit.xml'
        }
    }
}
```

## 与开发工具集成

### VS Code 集成

#### 1. 创建任务配置

```json
// .vscode/tasks.json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run TDD",
      "type": "shell",
      "command": "iflow",
      "args": ["skill", "invoke", "test-driven-development"],
      "problemMatcher": []
    },
    {
      "label": "Debug Issue",
      "type": "shell",
      "command": "iflow",
      "args": ["skill", "invoke", "systematic-debugging"],
      "problemMatcher": []
    }
  ]
}
```

#### 2. 创建快捷键

```json
// .vscode/keybindings.json
[
  {
    "key": "ctrl+shift+t",
    "command": "workbench.action.tasks.runTask",
    "args": "Run TDD"
  },
  {
    "key": "ctrl+shift+d",
    "command": "workbench.action.tasks.runTask",
    "args": "Debug Issue"
  }
]
```

#### 3. 创建代码片段

```json
// .vscode/snippets/javascript.json
{
  "TDD Test": {
    "prefix": "tdd-test",
    "body": [
      "test('$1', () => {",
      "  expect($2).toBe($3);",
      "});"
    ],
    "description": "TDD test template"
  }
}
```

### Git 集成

#### 1. Git Hooks

```bash
#!/bin/bash
# .git/hooks/pre-commit

# 使用 TDD 技能检查代码
iflow skill invoke test-driven-development

# 运行测试
npm test

# 检查通过才允许提交
if [ $? -ne 0 ]; then
  echo "Tests failed. Commit aborted."
  exit 1
fi
```

#### 2. Git Alias

```bash
# .gitconfig
[alias]
  tdd = "!f() { iflow skill invoke test-driven-development; }; f"
  debug = "!f() { iflow skill invoke systematic-debugging; }; f"
```

### Docker 集成

#### 1. Dockerfile

```dockerfile
# Dockerfile
FROM node:18

# 安装 iFlow CLI
RUN npm install -g @iflow/cli

# 安装 Superpowers 技能
COPY skills /root/.iflow/skills

# 工作目录
WORKDIR /app

# 复制项目文件
COPY package*.json ./
RUN npm ci

# 复制源代码
COPY . .

# 使用 TDD 技能运行测试
RUN iflow skill invoke test-driven-development && npm test

# 启动应用
CMD ["npm", "start"]
```

#### 2. Docker Compose

```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build: .
    volumes:
      - .:/app
    command: |
      sh -c "
        iflow skill invoke test-driven-development &&
        npm test &&
        npm start
      "
```

## 高级集成场景

### 1. 自动化工作流

```javascript
// 自动化 TDD 工作流
async function automatedTDDWorkflow() {
  // 1. 使用 TDD 技能
  skill: "test-driven-development";

  // 2. 编写测试
  await writeTestFile();

  // 3. 运行测试
  await runTests();

  // 4. 实现代码
  await implementCode();

  // 5. 验证测试
  await verifyTests();

  // 6. 如果失败，使用 Debugging 技能
  if (testsFailed) {
    skill: "systematic-debugging";
    await debugIssue();
  }
}
```

### 2. 多技能协作

```javascript
// 多技能协作工作流
async function multiSkillWorkflow() {
  // 1. 使用 Brainstorming 技能（Phase 2）
  skill: "brainstorming";
  await brainstormRequirements();

  // 2. 使用 Planning 技能（Phase 2）
  skill: "writing-plans";
  await createPlans();

  // 3. 使用 TDD 技能实现
  skill: "test-driven-development";
  await implementWithTDD();

  // 4. 使用 Debugging 技能验证
  skill: "systematic-debugging";
  await verifyImplementation();
}
```

### 3. 自定义技能组合

```javascript
// 创建自定义技能组合
const customSkillCombination = {
  name: "full-development-cycle",
  description: "完整的开发周期技能组合",
  skills: [
    "brainstorming",
    "writing-plans",
    "test-driven-development",
    "systematic-debugging"
  ],
  workflow: async () => {
    for (const skill of customSkillCombination.skills) {
      await invokeSkill(skill);
    }
  }
};
```

## 故障排除

### 常见问题

#### 1. 技能调用失败

**问题**: 技能无法调用或执行失败

**解决方案**:
1. 检查技能是否已正确安装
2. 刷新技能列表：`/skills refresh`
3. 检查技能文件格式
4. 查看错误日志

#### 2. 工具映射错误

**问题**: 工具调用失败或参数错误

**解决方案**:
1. 确认工具映射正确
2. 检查参数格式
3. 参考工具映射文档
4. 使用正确的工具调用方式

#### 3. 子代理调用失败

**问题**: 子代理无法执行或返回错误

**解决方案**:
1. 使用预定义代理类型
2. 检查 prompt 格式
3. 确认 useContext 设置
4. 查看子代理日志

## 最佳实践

### 1. 技能使用

- **先规划后执行**: 使用 Planning 技能规划任务
- **始终使用 TDD**: 确保代码质量
- **系统性调试**: 使用 Debugging 技能诊断问题
- **组合使用技能**: 充分利用技能组合

### 2. 工具集成

- **正确映射工具**: 确保工具映射正确
- **处理错误**: 妥善处理工具错误
- **优化性能**: 避免重复调用工具
- **验证结果**: 验证工具执行结果

### 3. CI/CD 集成

- **自动化流程**: 自动化重复任务
- **快速反馈**: 提供快速反馈机制
- **并行执行**: 并行执行独立任务
- **失败重试**: 实现失败重试机制

### 4. 团队协作

- **统一标准**: 使用统一的工作流程
- **文档化**: 清晰记录集成步骤
- **培训**: 为团队提供培训
- **持续改进**: 不断优化集成方案

## 总结

Superpowers for iFlow CLI 提供了丰富的集成选项，可以与各种工具和工作流无缝集成。通过合理利用这些集成功能，可以：

- ✅ 提高开发效率
- ✅ 改善代码质量
- ✅ 自动化工作流程
- ✅ 增强团队协作

遵循本指南，你可以充分发挥 Superpowers 技能的潜力，创建高效、可靠的开发环境。

---

**文档版本**: 1.0.0
**最后更新**: 2026-03-05