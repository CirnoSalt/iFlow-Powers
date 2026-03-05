# Brainstorming Skill Test Script
# Tests for the Brainstorming skill on iFlow CLI

$ErrorActionPreference = "Stop"

# Test configuration
$SkillPath = "R:\test2\iFlow-Powers\skills\brainstorming\SKILL.md"
$TestsPath = "R:\test2\iFlow-Powers\skills\brainstorming\tests"
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
    $ResultLine = "$Status $TestName - $Message"
    $ResultLine | Out-File -FilePath $ResultsFile -Append -Encoding UTF8
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
        $Msg = "File not found: $Path"
        Write-TestResult -TestName $Description -Passed $false -Message $Msg
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
        $Msg = "File not found: $Path"
        Write-TestResult -TestName $Description -Passed $false -Message $Msg
        return $false
    }
    
    $Content = Get-Content $Path -Raw -Encoding UTF8
    if ($Content -match $Pattern) {
        Write-TestResult -TestName $Description -Passed $true
        return $true
    } else {
        $Msg = "Pattern not found: $Pattern"
        Write-TestResult -TestName $Description -Passed $false -Message $Msg
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
        $Msg = "File not found: $Path"
        Write-TestResult -TestName $Description -Passed $false -Message $Msg
        return $false
    }
    
    $Content = Get-Content $Path -Raw -Encoding UTF8
    
    if ($ExpectedValue) {
        $Pattern = "${FieldName}:\s*`"$ExpectedValue`""
    } else {
        $Pattern = "${FieldName}:\s*`"([^`"]+)`""
    }
    
    if ($Content -match $Pattern) {
        Write-TestResult -TestName $Description -Passed $true
        return $true
    } else {
        $Msg = "Field not found: $FieldName"
        Write-TestResult -TestName $Description -Passed $false -Message $Msg
        return $false
    }
}

# Initialize test results
if (Test-Path $ResultsFile) {
    Remove-Item $ResultsFile -Force
}
$Date = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
$Header = "Brainstorming Skill Test Results - $Date"
$Header | Out-File -FilePath $ResultsFile -Encoding UTF8

# Start tests
Write-Host ""
Write-Host "=== Brainstorming Skill Tests ===" -ForegroundColor Cyan
Write-Host ""

# Test 1: Skill file exists
Test-FileExists -Path $SkillPath -Description "Skill file exists"

# Test 2: Skill has YAML frontmatter
Test-FileContains -Path $SkillPath -Pattern "^---" -Description "Skill has YAML frontmatter start"
Test-FileContains -Path $SkillPath -Pattern "^---$" -Description "Skill has YAML frontmatter end"

# Test 3: Skill has required fields
Test-YAMLField -Path $SkillPath -FieldName "name" -ExpectedValue "brainstorming" -Description "Skill has correct name"
Test-YAMLField -Path $SkillPath -FieldName "version" -Description "Skill has version field"
Test-YAMLField -Path $SkillPath -FieldName "author" -Description "Skill has author field"
Test-YAMLField -Path $SkillPath -FieldName "category" -Description "Skill has category field"
Test-YAMLField -Path $SkillPath -FieldName "tags" -Description "Skill has tags field"

# Test 4: Skill has required sections
Test-FileContains -Path $SkillPath -Pattern "^## 概述" -Description "Skill has 概述 section"
Test-FileContains -Path $SkillPath -Pattern "^## 反模式" -Description "Skill has 反模式 section"
Test-FileContains -Path $SkillPath -Pattern "^## 检查清单" -Description "Skill has 检查清单 section"
Test-FileContains -Path $SkillPath -Pattern "^## 流程图" -Description "Skill has 流程图 section"
Test-FileContains -Path $SkillPath -Pattern "^## 流程说明" -Description "Skill has 流程说明 section"
Test-FileContains -Path $SkillPath -Pattern "^## 关键原则" -Description "Skill has 关键原则 section"

# Test 5: Skill has iFlow CLI specific sections
Test-FileContains -Path $SkillPath -Pattern "^## iFlow CLI 特定说明" -Description "Skill has iFlow CLI 特定说明 section"
Test-FileContains -Path $SkillPath -Pattern "### 工具调用" -Description "Skill has 工具调用 section"
Test-FileContains -Path $SkillPath -Pattern "### Git 命令" -Description "Skill has Git 命令 section"

# Test 6: Skill has correct tool mappings
Test-FileContains -Path $SkillPath -Pattern "read_file" -Description "Skill references read_file tool"
Test-FileContains -Path $SkillPath -Pattern "write_file" -Description "Skill references write_file tool"
Test-FileContains -Path $SkillPath -Pattern "run_shell_command" -Description "Skill references run_shell_command tool"
Test-FileContains -Path $SkillPath -Pattern "Skill" -Description "Skill references Skill tool"

# Test 7: Skill has examples
Test-FileContains -Path $SkillPath -Pattern "^## 示例" -Description "Skill has 示例 section"
Test-FileContains -Path $SkillPath -Pattern "### 简单示例" -Description "Skill has 简单示例"
Test-FileContains -Path $SkillPath -Pattern "### 复杂示例" -Description "Skill has 复杂示例"

# Test 8: Skill has FAQ
Test-FileContains -Path $SkillPath -Pattern "^## 常见问题" -Description "Skill has 常见问题 section"

# Test 9: Examples directory exists
$ExamplesPath = "R:\test2\iFlow-Powers\skills\brainstorming\examples"
Test-FileExists -Path $ExamplesPath -Description "Examples directory exists"

# Test 10: Examples README exists
$ExamplesReadme = "R:\test2\iFlow-Powers\skills\brainstorming\examples\README.md"
Test-FileExists -Path $ExamplesReadme -Description "Examples README exists"

# Test 11: Examples README has content
Test-FileContains -Path $ExamplesReadme -Pattern "^# Brainstorming 技能使用示例" -Description "Examples README has title"
Test-FileContains -Path $ExamplesReadme -Pattern "## 基本用法" -Description "Examples README has basic usage"
Test-FileContains -Path $ExamplesReadme -Pattern "## 完整对话示例" -Description "Examples README has complete examples"

# Test 12: Skill mentions writing-plans
Test-FileContains -Path $SkillPath -Pattern "writing-plans" -Description "Skill mentions writing-plans skill"

# Test 13: Skill has HARD-GATE
Test-FileContains -Path $SkillPath -Pattern "HARD-GATE" -Description "Skill has HARD-GATE warning"

# Test 14: Skill has checklist items
Test-FileContains -Path $SkillPath -Pattern "1\.\*\*探索项目上下文\*\*" -Description "Skill has checklist item 1"
Test-FileContains -Path $SkillPath -Pattern "2\.\*\*提出澄清问题\*\*" -Description "Skill has checklist item 2"
Test-FileContains -Path $SkillPath -Pattern "3\.\*\*提出 2-3 种方法\*\*" -Description "Skill has checklist item 3"
Test-FileContains -Path $SkillPath -Pattern "4\.\*\*展示设计\*\*" -Description "Skill has checklist item 4"
Test-FileContains -Path $SkillPath -Pattern "5\.\*\*编写设计文档\*\*" -Description "Skill has checklist item 5"
Test-FileContains -Path $SkillPath -Pattern "6\.\*\*过渡到实施\*\*" -Description "Skill has checklist item 6"

# Test 15: Skill has key principles
Test-FileContains -Path $SkillPath -Pattern "- \*\*一次一个问题\*\*" -Description "Skill has key principle 1"
Test-FileContains -Path $SkillPath -Pattern "- \*\*偏好多选题\*\*" -Description "Skill has key principle 2"
Test-FileContains -Path $SkillPath -Pattern "- \*\*无情地应用 YAGNI\*\*" -Description "Skill has key principle 3"
Test-FileContains -Path $SkillPath -Pattern "- \*\*探索替代方案\*\*" -Description "Skill has key principle 4"
Test-FileContains -Path $SkillPath -Pattern "- \*\*增量验证\*\*" -Description "Skill has key principle 5"
Test-FileContains -Path $SkillPath -Pattern "- \*\*灵活\*\*" -Description "Skill has key principle 6"

# Print summary
Write-Host ""
Write-Host "=== Test Summary ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Total Tests: $TotalTests" -ForegroundColor White
Write-Host "Passed: $PassedTests" -ForegroundColor Green
Write-Host "Failed: $FailedTests" -ForegroundColor Red

if ($FailedTests -eq 0) {
    Write-Host ""
    Write-Host "All tests passed!" -ForegroundColor Green
    Write-Host ""
    exit 0
} else {
    Write-Host ""
    Write-Host "Some tests failed. Check results file for details." -ForegroundColor Red
    Write-Host ""
    exit 1
}