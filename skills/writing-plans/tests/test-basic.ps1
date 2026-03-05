# Writing Plans Skill Test Script
# Tests for the Writing Plans skill on iFlow CLI

$ErrorActionPreference = "Stop"

# Test configuration
$SkillPath = "R:\test2\iFlow-Powers\skills\writing-plans\SKILL.md"
$TestsPath = "R:\test2\iFlow-Powers\skills\writing-plans\tests"
$ResultsFile = "$TestsPath\test-results.txt"

# Test counters
$TotalTests = 0
$PassedTests = 0
$FailedTests = 0

# Helper functions
function Write-TestResult {
    param(
        [string]$TestName,
        [bool]$Passed,
        [string]$Message = ""
    )
    
    $script:TotalTests++
    if ($Passed) {
        $script:PassedTests++
        $Status = "[PASS]"
        $Color = "Green"
    } else {
        $script:FailedTests++
        $Status = "[FAIL]"
        $Color = "Red"
    }
    
    Write-Host "$Status $TestName" -ForegroundColor $Color
    if ($Message) {
        Write-Host "     $Message" -ForegroundColor $Color
    }
    
    # Append to results file
    "$Status $TestName - $Message" | Out-File -FilePath $ResultsFile -Append -Encoding UTF8
}

function Test-FileExists {
    param(
        [string]$Path,
        [string]$Description
    )
    
    if (Test-Path $Path) {
        Write-TestResult -TestName $Description -Passed $true
        return $true
    } else {
        Write-TestResult -TestName $Description -Passed $false -Message "File not found: $Path"
        return $false
    }
}

function Test-FileContains {
    param(
        [string]$Path,
        [string]$Pattern,
        [string]$Description
    )
    
    if (-not (Test-Path $Path)) {
        Write-TestResult -TestName $Description -Passed $false -Message "File not found: $Path"
        return $false
    }
    
    $Content = Get-Content $Path -Raw -Encoding UTF8
    if ($Content -match $Pattern) {
        Write-TestResult -TestName $Description -Passed $true
        return $true
    } else {
        Write-TestResult -TestName $Description -Passed $false -Message "Pattern not found: $Pattern"
        return $false
    }
}

function Test-YAMLField {
    param(
        [string]$Path,
        [string]$FieldName,
        [string]$ExpectedValue,
        [string]$Description
    )
    
    if (-not (Test-Path $Path)) {
        Write-TestResult -TestName $Description -Passed $false -Message "File not found: $Path"
        return $false
    }
    
    $Content = Get-Content $Path -Raw -Encoding UTF8
    $Pattern = "name:\s*`"$FieldName`""
    
    if ($ExpectedValue) {
        $Pattern = "$FieldName:\s*`"$ExpectedValue`""
    } else {
        $Pattern = "$FieldName:\s*`"([^`"`]+)`""
    }
    
    if ($Content -match $Pattern) {
        Write-TestResult -TestName $Description -Passed $true
        return $true
    } else {
        Write-TestResult -TestName $Description -Passed $false -Message "Field not found: $FieldName"
        return $false
    }
}

# Initialize test results
if (Test-Path $ResultsFile) {
    Remove-Item $ResultsFile -Force
}
"Writing Plans Skill Test Results - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $ResultsFile -Encoding UTF8

# Start tests
Write-Host "`n=== Writing Plans Skill Tests ===`n" -ForegroundColor Cyan

# Test 1: Skill file exists
Test-FileExists -Path $SkillPath -Description "Skill file exists"

# Test 2: Skill has YAML frontmatter
Test-FileContains -Path $SkillPath -Pattern "^---" -Description "Skill has YAML frontmatter start"
Test-FileContains -Path $SkillPath -Pattern "^---$" -Description "Skill has YAML frontmatter end"

# Test 3: Skill has required fields
Test-YAMLField -Path $SkillPath -FieldName "name" -ExpectedValue "writing-plans" -Description "Skill has correct name"
Test-YAMLField -Path $SkillPath -FieldName "version" -Description "Skill has version field"
Test-YAMLField -Path $SkillPath -FieldName "author" -Description "Skill has author field"
Test-YAMLField -Path $SkillPath -FieldName "category" -Description "Skill has category field"
Test-YAMLField -Path $SkillPath -FieldName "tags" -Description "Skill has tags field"

# Test 4: Skill has required sections
Test-FileContains -Path $SkillPath -Pattern "^## 概述" -Description "Skill has 概述 section"
Test-FileContains -Path $SkillPath -Pattern "^## 小任务粒度" -Description "Skill has 小任务粒度 section"
Test-FileContains -Path $SkillPath -Pattern "^## 计划文档头部" -Description "Skill has 计划文档头部 section"
Test-FileContains -Path $SkillPath -Pattern "^## 任务结构" -Description "Skill has 任务结构 section"
Test-FileContains -Path $SkillPath -Pattern "^## 记住" -Description "Skill has 记住 section"
Test-FileContains -Path $SkillPath -Pattern "^## 执行交接" -Description "Skill has 执行交接 section"

# Test 5: Skill has iFlow CLI specific sections
Test-FileContains -Path $SkillPath -Pattern "^## iFlow CLI 特定说明" -Description "Skill has iFlow CLI 特定说明 section"
Test-FileContains -Path $SkillPath -Pattern "### 工具调用" -Description "Skill has 工具调用 section"
Test-FileContains -Path $SkillPath -Pattern "### Git 命令" -Description "Skill has Git 命令 section"

# Test 6: Skill has correct tool mappings
Test-FileContains -Path $SkillPath -Pattern "write_file" -Description "Skill references write_file tool"
Test-FileContains -Path $SkillPath -Pattern "Skill" -Description "Skill references Skill tool"

# Test 7: Skill has subskill status notice
Test-FileContains -Path $SkillPath -Pattern "### 子技能状态" -Description "Skill has 子技能状态 section"
Test-FileContains -Path $SkillPath -Pattern "executing-plans" -Description "Skill mentions executing-plans"
Test-FileContains -Path $SkillPath -Pattern "subagent-driven-development" -Description "Skill mentions subagent-driven-development"

# Test 8: Skill has examples
Test-FileContains -Path $SkillPath -Pattern "^## 示例" -Description "Skill has 示例 section"
Test-FileContains -Path $SkillPath -Pattern "### 简单示例" -Description "Skill has 简单示例"

# Test 9: Skill has FAQ
Test-FileContains -Path $SkillPath -Pattern "^## 常见问题" -Description "Skill has 常见问题 section"

# Test 10: Skill has best practices
Test-FileContains -Path $SkillPath -Pattern "^## 最佳实践" -Description "Skill has 最佳实践 section"

# Test 11: Examples directory exists
$ExamplesPath = "R:\test2\iFlow-Powers\skills\writing-plans\examples"
Test-FileExists -Path $ExamplesPath -Description "Examples directory exists"

# Test 12: Examples README exists
$ExamplesReadme = "R:\test2\iFlow-Powers\skills\writing-plans\examples\README.md"
Test-FileExists -Path $ExamplesReadme -Description "Examples README exists"

# Test 13: Examples README has content
Test-FileContains -Path $ExamplesReadme -Pattern "^# Writing Plans 技能使用示例" -Description "Examples README has title"
Test-FileContains -Path $ExamplesReadme -Pattern "## 基本用法" -Description "Examples README has basic usage"
Test-FileContains -Path $ExamplesReadme -Pattern "## 计划文档示例" -Description "Examples README has plan examples"

# Test 14: Skill has plan document header template
Test-FileContains -Path $SkillPath -Pattern "# \[功能名称\] 实施计划" -Description "Skill has plan document header template"
Test-FileContains -Path $SkillPath -Pattern "\*\*目标：\*\*" -Description "Skill has 目标 field"
Test-FileContains -Path $SkillPath -Pattern "\*\*架构：\*\*" -Description "Skill has 架构 field"
Test-FileContains -Path $SkillPath -Pattern "\*\*技术栈：\*\*" -Description "Skill has 技术栈 field"

# Test 15: Skill has task structure template
Test-FileContains -Path $SkillPath -Pattern "### 任务 N:" -Description "Skill has task structure template"
Test-FileContains -Path $SkillPath -Pattern "\*\*文件：\*\*" -Description "Skill has 文件 field"
Test-FileContains -Path $SkillPath -Pattern "- 创建：" -Description "Skill has 创建 field"
Test-FileContains -Path $SkillPath -Pattern "- 修改：" -Description "Skill has 修改 field"
Test-FileContains -Path $SkillPath -Pattern "- 测试：" -Description "Skill has 测试 field"

# Test 16: Skill has step template
Test-FileContains -Path $SkillPath -Pattern "\*\*步骤 1：编写失败的测试\*\*" -Description "Skill has step 1 template"
Test-FileContains -Path $SkillPath -Pattern "\*\*步骤 2：运行测试以验证它失败\*\*" -Description "Skill has step 2 template"
Test-FileContains -Path $SkillPath -Pattern "\*\*步骤 3：编写最少的实现\*\*" -Description "Skill has step 3 template"
Test-FileContains -Path $SkillPath -Pattern "\*\*步骤 4：运行测试以验证它通过\*\*" -Description "Skill has step 4 template"
Test-FileContains -Path $SkillPath -Pattern "\*\*步骤 5：提交\*\*" -Description "Skill has step 5 template"

# Test 17: Skill has execution options
Test-FileContains -Path $SkillPath -Pattern "1\. 子代理驱动（此会话）" -Description "Skill has execution option 1"
Test-FileContains -Path $SkillPath -Pattern "2\. 并行会话（单独）" -Description "Skill has execution option 2"

# Test 18: Skill mentions TDD
Test-FileContains -Path $SkillPath -Pattern "TDD" -Description "Skill mentions TDD"
Test-FileContains -Path $SkillPath -Pattern "YAGNI" -Description "Skill mentions YAGNI"
Test-FileContains -Path $SkillPath -Pattern "DRY" -Description "Skill mentions DRY"

# Test 19: Skill has git commit examples
Test-FileContains -Path $SkillPath -Pattern "git add" -Description "Skill has git add command"
Test-FileContains -Path $SkillPath -Pattern "git commit" -Description "Skill has git commit command"

# Test 20: Skill has PowerShell examples
Test-FileContains -Path $SkillPath -Pattern "PowerShell" -Description "Skill has PowerShell examples"

# Print summary
Write-Host "`n=== Test Summary ===`n" -ForegroundColor Cyan
Write-Host "Total Tests: $TotalTests" -ForegroundColor White
Write-Host "Passed: $PassedTests" -ForegroundColor Green
Write-Host "Failed: $FailedTests" -ForegroundColor Red

if ($FailedTests -eq 0) {
    Write-Host "`nAll tests passed!`n" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`nSome tests failed. Check $ResultsFile for details.`n" -ForegroundColor Red
    exit 1
}