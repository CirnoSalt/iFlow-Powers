# Executing Plans Skill Test Script

$SkillPath = "R:\test2\iFlow-Powers\skills\executing-plans"
$SkillFile = "$SkillPath\SKILL.md"
$ExamplesPath = "$SkillPath\examples"

$TotalTests = 0
$PassedTests = 0
$FailedTests = 0

Write-Host "Starting tests for Executing Plans skill..."

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
if ($content -match "name:\s*executing-plans") {
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

# Test 13: Contains When to Stop section
$TotalTests++
if ($content -match "^#+\s*何时停止") {
    Write-Host "Test 13: Contains When to Stop section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 13: Contains When to Stop section - FAILED"
    $FailedTests++
}

# Test 14: Contains Remember section
$TotalTests++
if ($content -match "^#+\s*记住") {
    Write-Host "Test 14: Contains Remember section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 14: Contains Remember section - FAILED"
    $FailedTests++
}

# Test 15: Contains Integration section
$TotalTests++
if ($content -match "^#+\s*集成") {
    Write-Host "Test 15: Contains Integration section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 15: Contains Integration section - FAILED"
    $FailedTests++
}

# Test 16: Document mentions read_file tool
$TotalTests++
if ($content -match "read_file") {
    Write-Host "Test 16: Document mentions read_file tool - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 16: Document mentions read_file tool - FAILED"
    $FailedTests++
}

# Test 17: Document mentions todo_write tool
$TotalTests++
if ($content -match "todo_write") {
    Write-Host "Test 17: Document mentions todo_write tool - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 17: Document mentions todo_write tool - FAILED"
    $FailedTests++
}

# Test 18: Document mentions todo_read tool
$TotalTests++
if ($content -match "todo_read") {
    Write-Host "Test 18: Document mentions todo_read tool - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 18: Document mentions todo_read tool - FAILED"
    $FailedTests++
}

# Test 19: Document mentions Skill tool
$TotalTests++
if ($content -match "Skill") {
    Write-Host "Test 19: Document mentions Skill tool - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 19: Document mentions Skill tool - FAILED"
    $FailedTests++
}

# Test 20: Document mentions batch execution
$TotalTests++
if ($content -match "批次" -or $content -match "batch") {
    Write-Host "Test 20: Document mentions batch execution - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 20: Document mentions batch execution - FAILED"
    $FailedTests++
}

# Test 21: Document mentions verification
$TotalTests++
if ($content -match "验证") {
    Write-Host "Test 21: Document mentions verification - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 21: Document mentions verification - FAILED"
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

# Test 26: Examples contain best practices
$TotalTests++
if ($examplesContent -match "最佳实践") {
    Write-Host "Test 26: Examples contain best practices - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 26: Examples contain best practices - FAILED"
    $FailedTests++
}

# Test 27: Examples contain FAQ
$TotalTests++
if ($examplesContent -match "常见问题") {
    Write-Host "Test 27: Examples contain FAQ - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 27: Examples contain FAQ - FAILED"
    $FailedTests++
}

# Test 28: Document contains integration with using-git-worktrees
$TotalTests++
if ($content -match "using-git-worktrees") {
    Write-Host "Test 28: Document contains integration with using-git-worktrees - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 28: Document contains integration with using-git-worktrees - FAILED"
    $FailedTests++
}

# Test 29: Document contains integration with finishing-a-development-branch
$TotalTests++
if ($content -match "finishing-a-development-branch") {
    Write-Host "Test 29: Document contains integration with finishing-a-development-branch - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 29: Document contains integration with finishing-a-development-branch - FAILED"
    $FailedTests++
}

# Test 30: Document mentions not starting on main/master
$TotalTests++
if ($content -match "main/master") {
    Write-Host "Test 30: Document mentions not starting on main/master - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 30: Document mentions not starting on main/master - FAILED"
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