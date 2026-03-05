# Phase 3 Execution Skills - Test Runner

$Phase3Skills = @(
    "using-git-worktrees",
    "finishing-a-development-branch",
    "executing-plans",
    "subagent-driven-development"
)

$BasePath = "R:\test2\iFlow-Powers\skills"

$TotalTests = 0
$TotalPassed = 0
$TotalFailed = 0

$SkillResults = @{}

Write-Host "`n===== Phase 3 Execution Skills - Test Runner =====`n" -ForegroundColor Cyan

foreach ($skill in $Phase3Skills) {
    Write-Host "Testing skill: $skill" -ForegroundColor Yellow

    $testScript = "$BasePath\$skill\tests\test-basic.ps1"

    if (-not (Test-Path $testScript)) {
        Write-Host "  ERROR: Test script not found" -ForegroundColor Red
        continue
    }

    try {
        $result = & $testScript 2>&1

        # Parse test results from output
        $passed = 0
        $failed = 0

        foreach ($line in $result) {
            if ($line -match "Total tests: (\d+)") {
                $total = [int]$matches[1]
            }
            if ($line -match "Passed: (\d+)") {
                $passed = [int]$matches[1]
            }
            if ($line -match "Failed: (\d+)") {
                $failed = [int]$matches[1]
            }
        }

        $TotalTests += $total
        $TotalPassed += $passed
        $TotalFailed += $failed

        $SkillResults[$skill] = @{
            Total = $total
            Passed = $passed
            Failed = $failed
            Status = if ($failed -eq 0) { "PASSED" } else { "FAILED" }
        }

        if ($failed -eq 0) {
            Write-Host "  Result: PASSED ($passed/$total tests passed)" -ForegroundColor Green
        } else {
            Write-Host "  Result: FAILED ($failed/$total tests failed)" -ForegroundColor Red
        }
    } catch {
        Write-Host "  ERROR: $($_.Exception.Message)" -ForegroundColor Red
        $SkillResults[$skill] = @{
            Total = 0
            Passed = 0
            Failed = 1
            Status = "ERROR"
        }
        $TotalFailed++
    }
    Write-Host ""
}

# Overall Summary
Write-Host "`n===== Overall Summary =====`n" -ForegroundColor Cyan
Write-Host "Skills tested: $($Phase3Skills.Count)" -ForegroundColor White
Write-Host "Total tests: $TotalTests" -ForegroundColor White
Write-Host "Passed: $TotalPassed" -ForegroundColor Green
Write-Host "Failed: $TotalFailed" -ForegroundColor Red

if ($TotalFailed -eq 0) {
    Write-Host "`n✅ All skills passed their tests!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n❌ Some skills have failed tests" -ForegroundColor Red
    Write-Host "`nDetailed Results:`n" -ForegroundColor Yellow
    foreach ($skill in $SkillResults.Keys) {
        $result = $SkillResults[$skill]
        Write-Host "$($skill): $($result.Status) ($($result.Passed)/$($result.Total) passed, $($result.Failed) failed)" -ForegroundColor $(if ($result.Status -eq "PASSED") { "Green" } else { "Red" })
    }
    exit 1
}