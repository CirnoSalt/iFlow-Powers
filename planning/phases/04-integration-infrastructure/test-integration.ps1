# Phase 4 Integration Test Script

$BasePath = "R:\test2\iFlow-Powers"
$TotalTests = 0
$PassedTests = 0
$FailedTests = 0

Write-Host "Starting Phase 4 integration tests..."

# Test 1: Skills directory exists
$TotalTests++
if (Test-Path "$BasePath\skills") {
    Write-Host "Test 1: Skills directory exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 1: Skills directory exists - FAILED"
    $FailedTests++
}

# Test 2: Config directory exists
$TotalTests++
if (Test-Path "$BasePath\config") {
    Write-Host "Test 2: Config directory exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 2: Config directory exists - FAILED"
    $FailedTests++
}

# Test 3: Lib directory exists
$TotalTests++
if (Test-Path "$BasePath\lib") {
    Write-Host "Test 3: Lib directory exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 3: Lib directory exists - FAILED"
    $FailedTests++
}

# Test 4: Tool mapping config exists
$TotalTests++
if (Test-Path "$BasePath\config\tool-mapping.json") {
    Write-Host "Test 4: Tool mapping config exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 4: Tool mapping config exists - FAILED"
    $FailedTests++
}

# Test 5: Subagent mapping config exists
$TotalTests++
if (Test-Path "$BasePath\config\subagent-mapping.json") {
    Write-Host "Test 5: Subagent mapping config exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 5: Subagent mapping config exists - FAILED"
    $FailedTests++
}

# Test 6: Skill index exists
$TotalTests++
if (Test-Path "$BasePath\lib\SKILL-INDEX.md") {
    Write-Host "Test 6: Skill index exists - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 6: Skill index exists - FAILED"
    $FailedTests++
}

# Test 7: Tool mapping config is valid JSON
$TotalTests++
try {
    $toolMapping = Get-Content "$BasePath\config\tool-mapping.json" -Raw | ConvertFrom-Json
    Write-Host "Test 7: Tool mapping config is valid JSON - PASSED"
    $PassedTests++
} catch {
    Write-Host "Test 7: Tool mapping config is valid JSON - FAILED"
    $FailedTests++
}

# Test 8: Subagent mapping config is valid JSON
$TotalTests++
try {
    $subagentMapping = Get-Content "$BasePath\config\subagent-mapping.json" -Raw | ConvertFrom-Json
    Write-Host "Test 8: Subagent mapping config is valid JSON - PASSED"
    $PassedTests++
} catch {
    Write-Host "Test 8: Subagent mapping config is valid JSON - FAILED"
    $FailedTests++
}

# Test 9: All skills have SKILL.md files
$TotalTests++
$skillDirs = Get-ChildItem "$BasePath\skills" -Directory
$missingSkills = 0
foreach ($skillDir in $skillDirs) {
    if (-not (Test-Path "$($skillDir.FullName)\SKILL.md")) {
        $missingSkills++
    }
}
if ($missingSkills -eq 0) {
    Write-Host "Test 9: All skills have SKILL.md files - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 9: All skills have SKILL.md files - FAILED ($missingSkills missing)"
    $FailedTests++
}

# Test 10: Tool mapping contains all required tools
$TotalTests++
try {
    $toolMapping = Get-Content "$BasePath\config\tool-mapping.json" -Raw | ConvertFrom-Json
    $requiredTools = @("Read", "Write", "Edit", "Bash", "Task", "Skill", "TodoWrite", "TodoRead")
    $missingTools = 0
    foreach ($tool in $requiredTools) {
        if (-not $toolMapping.tools.PSObject.Properties.Name.Contains($tool)) {
            $missingTools++
        }
    }
    if ($missingTools -eq 0) {
        Write-Host "Test 10: Tool mapping contains all required tools - PASSED"
        $PassedTests++
    } else {
        Write-Host "Test 10: Tool mapping contains all required tools - FAILED ($missingTools missing)"
        $FailedTests++
    }
} catch {
    Write-Host "Test 10: Tool mapping contains all required tools - FAILED"
    $FailedTests++
}

# Test 11: Subagent mapping contains all required subagents
$TotalTests++
try {
    $subagentMapping = Get-Content "$BasePath\config\subagent-mapping.json" -Raw | ConvertFrom-Json
    $requiredSubagents = @("code-reviewer", "implementer", "spec-reviewer", "code-quality-reviewer")
    $missingSubagents = 0
    foreach ($subagent in $requiredSubagents) {
        if (-not $subagentMapping.subagents.PSObject.Properties.Name.Contains($subagent)) {
            $missingSubagents++
        }
    }
    if ($missingSubagents -eq 0) {
        Write-Host "Test 11: Subagent mapping contains all required subagents - PASSED"
        $PassedTests++
    } else {
        Write-Host "Test 11: Subagent mapping contains all required subagents - FAILED ($missingSubagents missing)"
        $FailedTests++
    }
} catch {
    Write-Host "Test 11: Subagent mapping contains all required subagents - FAILED"
    $FailedTests++
}

# Test 12: Skill index contains all skills
$TotalTests++
try {
    $skillIndex = Get-Content "$BasePath\lib\SKILL-INDEX.md" -Raw
    $requiredSkills = @("test-driven-development", "systematic-debugging", "brainstorming", "writing-plans", "using-git-worktrees", "finishing-a-development-branch", "executing-plans", "subagent-driven-development")
    $missingSkills = 0
    foreach ($skill in $requiredSkills) {
        if ($skillIndex -notmatch $skill) {
            $missingSkills++
        }
    }
    if ($missingSkills -eq 0) {
        Write-Host "Test 12: Skill index contains all skills - PASSED"
        $PassedTests++
    } else {
        Write-Host "Test 12: Skill index contains all skills - FAILED ($missingSkills missing)"
        $FailedTests++
    }
} catch {
    Write-Host "Test 12: Skill index contains all skills - FAILED"
    $FailedTests++
}

# Test 13: Tool mapping has proper structure
$TotalTests++
try {
    $toolMapping = Get-Content "$BasePath\config\tool-mapping.json" -Raw | ConvertFrom-Json
    $validStructure = $true
    foreach ($tool in $toolMapping.tools.PSObject.Properties) {
        if (-not $tool.Value.iflow -or -not $tool.Value.params) {
            $validStructure = $false
            break
        }
    }
    if ($validStructure) {
        Write-Host "Test 13: Tool mapping has proper structure - PASSED"
        $PassedTests++
    } else {
        Write-Host "Test 13: Tool mapping has proper structure - FAILED"
        $FailedTests++
    }
} catch {
    Write-Host "Test 13: Tool mapping has proper structure - FAILED"
    $FailedTests++
}

# Test 14: Subagent mapping has proper structure
$TotalTests++
try {
    $subagentMapping = Get-Content "$BasePath\config\subagent-mapping.json" -Raw | ConvertFrom-Json
    $validStructure = $true
    foreach ($subagent in $subagentMapping.subagents.PSObject.Properties) {
        if (-not $subagent.Value.iflow -or -not $subagent.Value.role -or -not $subagent.Value.capabilities) {
            $validStructure = $false
            break
        }
    }
    if ($validStructure) {
        Write-Host "Test 14: Subagent mapping has proper structure - PASSED"
        $PassedTests++
    } else {
        Write-Host "Test 14: Subagent mapping has proper structure - FAILED"
        $FailedTests++
    }
} catch {
    Write-Host "Test 14: Subagent mapping has proper structure - FAILED"
    $FailedTests++
}

# Test 15: All skills have valid YAML frontmatter
$TotalTests++
$validFrontmatter = 0
$skillDirs = Get-ChildItem "$BasePath\skills" -Directory
foreach ($skillDir in $skillDirs) {
    $skillFile = "$($skillDir.FullName)\SKILL.md"
    if (Test-Path $skillFile) {
        $content = Get-Content $skillFile -Raw
        if ($content -match "^---[\s\S]*?---") {
            $validFrontmatter++
        }
    }
}
if ($validFrontmatter -eq $skillDirs.Count) {
    Write-Host "Test 15: All skills have valid YAML frontmatter - PASSED"
    $PassedTests++
} else {
    Write-Host "Test 15: All skills have valid YAML frontmatter - FAILED ($validFrontmatter/$($skillDirs.Count) valid)"
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