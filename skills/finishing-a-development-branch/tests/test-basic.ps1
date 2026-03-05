# Finishing a Development Branch Skill Test Script

$SkillPath = "R:\test2\iFlow-Powers\skills\finishing-a-development-branch"
$SkillFile = "$SkillPath\SKILL.md"
$ExamplesPath = "$SkillPath\examples"

$TotalTests = 0
$PassedTests = 0
$FailedTests = 0

Write-Host "Starting tests for Finishing a Development Branch skill..."

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
if ($content -match "name:\s*finishing-a-development-branch") {
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

# Test 12: Contains Flow section
$TotalTests++
if ($content -match "^#+\s*流程") {
    Write-Host "Test 12: Contains Flow section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 12: Contains Flow section - FAILED"
    $FailedTests++
}

# Test 13: Contains Quick Reference section
$TotalTests++
if ($content -match "^#+\s*快速参考") {
    Write-Host "Test 13: Contains Quick Reference section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 13: Contains Quick Reference section - FAILED"
    $FailedTests++
}

# Test 14: Contains Common Errors section
$TotalTests++
if ($content -match "^#+\s*常见错误") {
    Write-Host "Test 14: Contains Common Errors section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 14: Contains Common Errors section - FAILED"
    $FailedTests++
}

# Test 15: Contains Red Flags section
$TotalTests++
if ($content -match "^#+\s*警告标志") {
    Write-Host "Test 15: Contains Red Flags section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 15: Contains Red Flags section - FAILED"
    $FailedTests++
}

# Test 16: Contains Integration section
$TotalTests++
if ($content -match "^#+\s*集成") {
    Write-Host "Test 16: Contains Integration section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 16: Contains Integration section - FAILED"
    $FailedTests++
}

# Test 17: Document mentions test verification
$TotalTests++
if ($content -match "验证测试") {
    Write-Host "Test 17: Document mentions test verification - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 17: Document mentions test verification - FAILED"
    $FailedTests++
}

# Test 18: Document contains 4 options
$TotalTests++
if ($content -match "4.*选项" -or $content -match "4.*选项") {
    Write-Host "Test 18: Document contains 4 options - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 18: Document contains 4 options - FAILED"
    $FailedTests++
}

# Test 19: Document contains worktree cleanup instructions
$TotalTests++
if ($content -match "清理 Worktree") {
    Write-Host "Test 19: Document contains worktree cleanup instructions - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 19: Document contains worktree cleanup instructions - FAILED"
    $FailedTests++
}

# Test 20: Document contains PowerShell commands
$TotalTests++
if ($content -match "PowerShell") {
    Write-Host "Test 20: Document contains PowerShell commands - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 20: Document contains PowerShell commands - FAILED"
    $FailedTests++
}

# Test 21: Document contains Git Bash commands
$TotalTests++
if ($content -match "Git Bash") {
    Write-Host "Test 21: Document contains Git Bash commands - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 21: Document contains Git Bash commands - FAILED"
    $FailedTests++
}

# Test 22: Example document exists
$TotalTests++
$examplesContent = Get-Content "$ExamplesPath\README.md" -Raw
if ($examplesContent -ne $null) {
    Write-Host "Test 22: Example document exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 22: Example document exists - FAILED"
    $FailedTests++
}

# Test 23: Examples contain simple example
$TotalTests++
if ($examplesContent -match "简单示例") {
    Write-Host "Test 23: Examples contain simple example - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 23: Examples contain simple example - FAILED"
    $FailedTests++
}

# Test 24: Examples contain complex example
$TotalTests++
if ($examplesContent -match "复杂示例") {
    Write-Host "Test 24: Examples contain complex example - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 24: Examples contain complex example - FAILED"
    $FailedTests++
}

# Test 25: Examples contain special scenario example
$TotalTests++
if ($examplesContent -match "特殊场景示例") {
    Write-Host "Test 25: Examples contain special scenario example - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 25: Examples contain special scenario example - FAILED"
    $FailedTests++
}

# Test 26: Examples contain Git Bash version example
$TotalTests++
if ($examplesContent -match "Git Bash 版本") {
    Write-Host "Test 26: Examples contain Git Bash version example - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 26: Examples contain Git Bash version example - FAILED"
    $FailedTests++
}

# Test 27: Examples contain best practices
$TotalTests++
if ($examplesContent -match "最佳实践") {
    Write-Host "Test 27: Examples contain best practices - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 27: Examples contain best practices - FAILED"
    $FailedTests++
}

# Test 28: Examples contain troubleshooting
$TotalTests++
if ($examplesContent -match "故障排除") {
    Write-Host "Test 28: Examples contain troubleshooting - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 28: Examples contain troubleshooting - FAILED"
    $FailedTests++
}

# Test 29: Document contains option 1 (local merge)
$TotalTests++
if ($content -match "选项 1" -or $content -match "Option 1") {
    Write-Host "Test 29: Document contains option 1 - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 29: Document contains option 1 - FAILED"
    $FailedTests++
}

# Test 30: Document contains option 2 (create PR)
$TotalTests++
if ($content -match "选项 2" -or $content -match "Option 2") {
    Write-Host "Test 30: Document contains option 2 - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 30: Document contains option 2 - FAILED"
    $FailedTests++
}

# Test 31: Document contains option 3 (keep as-is)
$TotalTests++
if ($content -match "选项 3" -or $content -match "Option 3") {
    Write-Host "Test 31: Document contains option 3 - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 31: Document contains option 3 - FAILED"
    $FailedTests++
}

# Test 32: Document contains option 4 (discard)
$TotalTests++
if ($content -match "选项 4" -or $content -match "Option 4") {
    Write-Host "Test 32: Document contains option 4 - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 32: Document contains option 4 - FAILED"
    $FailedTests++
}

# Test 33: Document contains confirmation for option 4
$TotalTests++
if ($content -match "discard" -and $content -match "确认") {
    Write-Host "Test 33: Document contains confirmation for option 4 - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 33: Document contains confirmation for option 4 - FAILED"
    $FailedTests++
}

# Test 34: Document contains integration with using-git-worktrees
$TotalTests++
if ($content -match "using-git-worktrees") {
    Write-Host "Test 34: Document contains integration with using-git-worktrees - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 34: Document contains integration with using-git-worktrees - FAILED"
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