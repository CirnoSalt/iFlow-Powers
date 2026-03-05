# Using Git Worktrees Skill Test Script

$SkillPath = "R:\test2\iFlow-Powers\skills\using-git-worktrees"
$SkillFile = "$SkillPath\SKILL.md"
$ExamplesPath = "$SkillPath\examples"

$TotalTests = 0
$PassedTests = 0
$FailedTests = 0

Write-Host "Starting tests for Using Git Worktrees skill..."

# Test 1: SKILL.md exists
$TotalTests++
if (Test-Path $SkillFile) {
    Write-Host "Test 1: SKILL.md exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 1: SKILL.md exists - FAILED"
    $FailedTests++
}

# Test 2: examples directory exists
$TotalTests++
if (Test-Path $ExamplesPath) {
    Write-Host "Test 2: examples directory exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 2: examples directory exists - FAILED"
    $FailedTests++
}

# Test 3: examples/README.md exists
$TotalTests++
if (Test-Path "$ExamplesPath\README.md") {
    Write-Host "Test 3: examples/README.md exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 3: examples/README.md exists - FAILED"
    $FailedTests++
}

# Test 4: YAML frontmatter exists
$TotalTests++
$content = Get-Content $SkillFile -Raw
$yamlMatch = [regex]::Match($content, "^---\r?\n(.*?)\r?\n---", [System.Text.RegularExpressions.RegexOptions]::Singleline)
if ($yamlMatch.Success) {
    Write-Host "Test 4: YAML frontmatter exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 4: YAML frontmatter exists - FAILED"
    $FailedTests++
}

# Test 5: Contains name field
$TotalTests++
if ($content -match "name:\s*using-git-worktrees") {
    Write-Host "Test 5: Contains name field - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 5: Contains name field - FAILED"
    $FailedTests++
}

# Test 6: Contains description field
$TotalTests++
if ($content -match "description:") {
    Write-Host "Test 6: Contains description field - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 6: Contains description field - FAILED"
    $FailedTests++
}

# Test 7: Contains version field
$TotalTests++
if ($content -match "version:") {
    Write-Host "Test 7: Contains version field - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 7: Contains version field - FAILED"
    $FailedTests++
}

# Test 8: Contains author field
$TotalTests++
if ($content -match "author:") {
    Write-Host "Test 8: Contains author field - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 8: Contains author field - FAILED"
    $FailedTests++
}

# Test 9: Contains category field
$TotalTests++
if ($content -match "category:") {
    Write-Host "Test 9: Contains category field - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 9: Contains category field - FAILED"
    $FailedTests++
}

# Test 10: Contains tags field
$TotalTests++
if ($content -match "tags:") {
    Write-Host "Test 10: Contains tags field - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 10: Contains tags field - FAILED"
    $FailedTests++
}

# Test 11: Contains Overview section
$TotalTests++
if ($content -match "^#+\s*概述") {
    Write-Host "Test 11: Contains Overview section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 11: Contains Overview section - FAILED"
    $FailedTests++
}

# Test 12: Contains Directory Selection Process section
$TotalTests++
if ($content -match "^#+\s*目录选择过程") {
    Write-Host "Test 12: Contains Directory Selection Process section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 12: Contains Directory Selection Process section - FAILED"
    $FailedTests++
}

# Test 13: Contains Security Verification section
$TotalTests++
if ($content -match "^#+\s*安全性验证") {
    Write-Host "Test 13: Contains Security Verification section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 13: Contains Security Verification section - FAILED"
    $FailedTests++
}

# Test 14: Contains Creation Steps section
$TotalTests++
if ($content -match "^#+\s*创建步骤") {
    Write-Host "Test 14: Contains Creation Steps section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 14: Contains Creation Steps section - FAILED"
    $FailedTests++
}

# Test 15: Contains Quick Reference section
$TotalTests++
if ($content -match "^#+\s*快速参考") {
    Write-Host "Test 15: Contains Quick Reference section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 15: Contains Quick Reference section - FAILED"
    $FailedTests++
}

# Test 16: Contains Common Errors section
$TotalTests++
if ($content -match "^#+\s*常见错误") {
    Write-Host "Test 16: Contains Common Errors section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 16: Contains Common Errors section - FAILED"
    $FailedTests++
}

# Test 17: Contains Example Workflow section
$TotalTests++
if ($content -match "^#+\s*示例工作流") {
    Write-Host "Test 17: Contains Example Workflow section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 17: Contains Example Workflow section - FAILED"
    $FailedTests++
}

# Test 18: Contains Red Flags section
$TotalTests++
if ($content -match "^#+\s*警告标志") {
    Write-Host "Test 18: Contains Red Flags section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 18: Contains Red Flags section - FAILED"
    $FailedTests++
}

# Test 19: Contains Integration section
$TotalTests++
if ($content -match "^#+\s*集成") {
    Write-Host "Test 19: Contains Integration section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 19: Contains Integration section - FAILED"
    $FailedTests++
}

# Test 20: Document mentions read_file tool
$TotalTests++
if ($content -match "read_file") {
    Write-Host "Test 20: Document mentions read_file tool - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 20: Document mentions read_file tool - FAILED"
    $FailedTests++
}

# Test 21: Document mentions write_file tool
$TotalTests++
if ($content -match "write_file") {
    Write-Host "Test 21: Document mentions write_file tool - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 21: Document mentions write_file tool - FAILED"
    $FailedTests++
}

# Test 22: Document mentions run_shell_command tool
$TotalTests++
if ($content -match "run_shell_command") {
    Write-Host "Test 22: Document mentions run_shell_command tool - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 22: Document mentions run_shell_command tool - FAILED"
    $FailedTests++
}

# Test 23: Document contains PowerShell commands
$TotalTests++
if ($content -match "PowerShell") {
    Write-Host "Test 23: Document contains PowerShell commands - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 23: Document contains PowerShell commands - FAILED"
    $FailedTests++
}

# Test 24: Document contains Git Bash commands
$TotalTests++
if ($content -match "Git Bash") {
    Write-Host "Test 24: Document contains Git Bash commands - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 24: Document contains Git Bash commands - FAILED"
    $FailedTests++
}

# Test 25: Document uses Unix-style paths
$TotalTests++
if ($content -match "/") {
    Write-Host "Test 25: Document uses Unix-style paths - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 25: Document uses Unix-style paths - FAILED"
    $FailedTests++
}

# Test 26: Example document exists
$TotalTests++
$examplesContent = Get-Content "$ExamplesPath\README.md" -Raw
if ($examplesContent -ne $null) {
    Write-Host "Test 26: Example document exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 26: Example document exists - FAILED"
    $FailedTests++
}

# Test 27: Examples contain simple example
$TotalTests++
if ($examplesContent -match "简单示例") {
    Write-Host "Test 27: Examples contain simple example - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 27: Examples contain simple example - FAILED"
    $FailedTests++
}

# Test 28: Examples contain complex example
$TotalTests++
if ($examplesContent -match "复杂示例") {
    Write-Host "Test 28: Examples contain complex example - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 28: Examples contain complex example - FAILED"
    $FailedTests++
}

# Test 29: Examples contain special scenario example
$TotalTests++
if ($examplesContent -match "特殊场景示例") {
    Write-Host "Test 29: Examples contain special scenario example - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 29: Examples contain special scenario example - FAILED"
    $FailedTests++
}

# Test 30: Examples contain Git Bash version example
$TotalTests++
if ($examplesContent -match "Git Bash 版本") {
    Write-Host "Test 30: Examples contain Git Bash version example - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 30: Examples contain Git Bash version example - FAILED"
    $FailedTests++
}

# Test 31: Document contains directory selection priority explanation
$TotalTests++
if ($content -match "优先级") {
    Write-Host "Test 31: Document contains directory selection priority explanation - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 31: Document contains directory selection priority explanation - FAILED"
    $FailedTests++
}

# Test 32: Document contains security verification explanation
$TotalTests++
if ($content -match "git check-ignore") {
    Write-Host "Test 32: Document contains security verification explanation - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 32: Document contains security verification explanation - FAILED"
    $FailedTests++
}

# Test 33: Document contains project setup auto-detection explanation
$TotalTests++
if ($content -match "自动检测") {
    Write-Host "Test 33: Document contains project setup auto-detection explanation - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 33: Document contains project setup auto-detection explanation - FAILED"
    $FailedTests++
}

# Test 34: Document contains baseline verification explanation
$TotalTests++
if ($content -match "基线") {
    Write-Host "Test 34: Document contains baseline verification explanation - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 34: Document contains baseline verification explanation - FAILED"
    $FailedTests++
}

# Results
Write-Host "`n===== Test Results ====="
Write-Host "Total tests: $TotalTests"
Write-Host "Passed: $PassedTests"
Write-Host "Failed: $FailedTests"

if ($FailedTests -eq 0) {
    Write-Host "All tests passed!"
    exit 0
} else {
    Write-Host "$FailedTests test(s) failed"
    exit 1
}