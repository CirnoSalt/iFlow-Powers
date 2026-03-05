# Subagent-Driven Development Skill Test Script

$SkillPath = "R:\test2\iFlow-Powers\skills\subagent-driven-development"
$SkillFile = "$SkillPath\SKILL.md"
$PromptsPath = "$SkillPath\prompts"
$ExamplesPath = "$SkillPath\examples"

$TotalTests = 0
$PassedTests = 0
$FailedTests = 0

Write-Host "Starting tests for Subagent-Driven Development skill..."

# Test 1: SKILL.md exists
$TotalTests++
if (Test-Path $SkillFile) {
    Write-Host "Test 1: SKILL.md exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 1: SKILL.md exists - FAILED"
    $FailedTests++
}

# Test 2: prompts directory exists
$TotalTests++
if (Test-Path $PromptsPath) {
    Write-Host "Test 2: prompts directory exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 2: prompts directory exists - FAILED"
    $FailedTests++
}

# Test 3: examples directory exists
$TotalTests++
if (Test-Path $ExamplesPath) {
    Write-Host "Test 3: examples directory exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 3: examples directory exists - FAILED"
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
if ($content -match "name:\s*subagent-driven-development") {
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

# Test 12: Contains When to Use section
$TotalTests++
if ($content -match "^#+\s*何时使用") {
    Write-Host "Test 12: Contains When to Use section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 12: Contains When to Use section - FAILED"
    $FailedTests++
}

# Test 13: Contains Flow section
$TotalTests++
if ($content -match "^#+\s*流程") {
    Write-Host "Test 13: Contains Flow section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 13: Contains Flow section - FAILED"
    $FailedTests++
}

# Test 14: Contains Prompt Templates section
$TotalTests++
if ($content -match "^#+\s*Prompt 模板") {
    Write-Host "Test 14: Contains Prompt Templates section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 14: Contains Prompt Templates section - FAILED"
    $FailedTests++
}

# Test 15: Contains Advantages section
$TotalTests++
if ($content -match "^#+\s*优势") {
    Write-Host "Test 15: Contains Advantages section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 15: Contains Advantages section - FAILED"
    $FailedTests++
}

# Test 16: Contains Red Flags section
$TotalTests++
if ($content -match "^#+\s*红色警告") {
    Write-Host "Test 16: Contains Red Flags section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 16: Contains Red Flags section - FAILED"
    $FailedTests++
}

# Test 17: Contains Integration section
$TotalTests++
if ($content -match "^#+\s*集成") {
    Write-Host "Test 17: Contains Integration section - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 17: Contains Integration section - FAILED"
    $FailedTests++
}

# Test 18: Document mentions read_file tool
$TotalTests++
if ($content -match "read_file") {
    Write-Host "Test 18: Document mentions read_file tool - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 18: Document mentions read_file tool - FAILED"
    $FailedTests++
}

# Test 19: Document mentions todo_write tool
$TotalTests++
if ($content -match "todo_write") {
    Write-Host "Test 19: Document mentions todo_write tool - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 19: Document mentions todo_write tool - FAILED"
    $FailedTests++
}

# Test 20: Document mentions task tool
$TotalTests++
if ($content -match "task") {
    Write-Host "Test 20: Document mentions task tool - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 20: Document mentions task tool - FAILED"
    $FailedTests++
}

# Test 21: Document mentions Skill tool
$TotalTests++
if ($content -match "Skill") {
    Write-Host "Test 21: Document mentions Skill tool - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 21: Document mentions Skill tool - FAILED"
    $FailedTests++
}

# Test 22: Document mentions two-stage review
$TotalTests++
if ($content -match "两阶段审查") {
    Write-Host "Test 22: Document mentions two-stage review - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 22: Document mentions two-stage review - FAILED"
    $FailedTests++
}

# Test 23: implementer-prompt.md exists
$TotalTests++
if (Test-Path "$PromptsPath\implementer-prompt.md") {
    Write-Host "Test 23: implementer-prompt.md exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 23: implementer-prompt.md exists - FAILED"
    $FailedTests++
}

# Test 24: spec-reviewer-prompt.md exists
$TotalTests++
if (Test-Path "$PromptsPath\spec-reviewer-prompt.md") {
    Write-Host "Test 24: spec-reviewer-prompt.md exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 24: spec-reviewer-prompt.md exists - FAILED"
    $FailedTests++
}

# Test 25: code-quality-reviewer-prompt.md exists
$TotalTests++
if (Test-Path "$PromptsPath\code-quality-reviewer-prompt.md") {
    Write-Host "Test 25: code-quality-reviewer-prompt.md exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 25: code-quality-reviewer-prompt.md exists - FAILED"
    $FailedTests++
}

# Test 26: Example document exists
$TotalTests++
if (Test-Path "$ExamplesPath\README.md") {
    Write-Host "Test 26: Example document exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 26: Example document exists - FAILED"
    $FailedTests++
}

# Test 27: Examples contain simple example
$TotalTests++
$examplesContent = Get-Content "$ExamplesPath\README.md" -Raw
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

# Test 29: Examples contain best practices
$TotalTests++
if ($examplesContent -match "最佳实践") {
    Write-Host "Test 29: Examples contain best practices - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 29: Examples contain best practices - FAILED"
    $FailedTests++
}

# Test 30: Document contains subagent type mapping
$TotalTests++
if ($content -match "general-purpose" -and $content -match "plan-agent") {
    Write-Host "Test 30: Document contains subagent type mapping - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 30: Document contains subagent type mapping - FAILED"
    $FailedTests++
}

# Test 31: Document mentions using-git-worktrees
$TotalTests++
if ($content -match "using-git-worktrees") {
    Write-Host "Test 31: Document mentions using-git-worktrees - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 31: Document mentions using-git-worktrees - FAILED"
    $FailedTests++
}

# Test 32: Document mentions finishing-a-development-branch
$TotalTests++
if ($content -match "finishing-a-development-branch") {
    Write-Host "Test 32: Document mentions finishing-a-development-branch - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 32: Document mentions finishing-a-development-branch - FAILED"
    $FailedTests++
}

# Test 33: implementer prompt contains role description
$TotalTests++
$implementerPrompt = Get-Content "$PromptsPath\implementer-prompt.md" -Raw
if ($implementerPrompt -match "你的角色") {
    Write-Host "Test 33: implementer prompt contains role description - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 33: implementer prompt contains role description - FAILED"
    $FailedTests++
}

# Test 34: spec-reviewer prompt contains review criteria
$TotalTests++
$specReviewerPrompt = Get-Content "$PromptsPath\spec-reviewer-prompt.md" -Raw
if ($specReviewerPrompt -match "审查标准") {
    Write-Host "Test 34: spec-reviewer prompt contains review criteria - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 34: spec-reviewer prompt contains review criteria - FAILED"
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