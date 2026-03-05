# Systematic Debugging Skill Basic Test
# PowerShell script for Windows compatibility

$SkillPath = "R:\test2\iFlow-Powers\skills\systematic-debugging"

# Test counters
$TestsPassed = 0
$TestsFailed = 0
$TotalTests = 0

# Helper function to run a test
function Test-Content {
    param(
        [string]$Path,
        [string]$Content,
        [string]$Description
    )
    
    $script:TotalTests++
    if (Test-Path $Path) {
        $fileContent = [System.IO.File]::ReadAllText($Path, [System.Text.Encoding]::UTF8)
        if ($fileContent -match $Content) {
            Write-Host "[PASS] $Description" -ForegroundColor Green
            $script:TestsPassed++
        } else {
            Write-Host "[FAIL] $Description (Content not found)" -ForegroundColor Red
            $script:TestsFailed++
        }
    } else {
        Write-Host "[FAIL] $Description (File not found)" -ForegroundColor Red
        $script:TestsFailed++
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Systematic Debugging Skill Tests" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Test 1: File Structure
Write-Host "Test 1: File Structure" -ForegroundColor Yellow
Test-Content -Path "$SkillPath\SKILL.md" -Content "Systematic Debugging" -Description "SKILL.md contains skill name"
Test-Content -Path "$SkillPath\SKILL.md" -Content "四阶段根因分析" -Description "SKILL.md contains description"
Test-Content -Path "$SkillPath\examples\README.md" -Content "Systematic Debugging" -Description "examples/README.md exists"

# Test 2: YAML Frontmatter
Write-Host ""
Write-Host "Test 2: YAML Frontmatter" -ForegroundColor Yellow
Test-Content -Path "$SkillPath\SKILL.md" -Content "name: systematic-debugging" -Description "YAML field 'name' exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "description:" -Description "YAML field 'description' exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "version:" -Description "YAML field 'version' exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "author:" -Description "YAML field 'author' exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "category:" -Description "YAML field 'category' exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "tags:" -Description "YAML field 'tags' exists"

# Test 3: Core Content
Write-Host ""
Write-Host "Test 3: Core Content" -ForegroundColor Yellow
Test-Content -Path "$SkillPath\SKILL.md" -Content "铁律" -Description "铁律 section exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "四个阶段" -Description "四个阶段 section exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "工具映射" -Description "工具映射 section exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "在 iFlow CLI 中使用" -Description "iFlow CLI usage section exists"

# Test 4: Four Phases
Write-Host ""
Write-Host "Test 4: Four Phases" -ForegroundColor Yellow
Test-Content -Path "$SkillPath\SKILL.md" -Content "Phase 1: 根本原因调查" -Description "Phase 1 exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "Phase 2: 模式分析" -Description "Phase 2 exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "Phase 3: 假设和测试" -Description "Phase 3 exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "Phase 4: 实现" -Description "Phase 4 exists"

# Test 5: Tool Mapping
Write-Host ""
Write-Host "Test 5: Tool Mapping" -ForegroundColor Yellow
Test-Content -Path "$SkillPath\SKILL.md" -Content "read_file" -Description "Tool mapping for read_file exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "write_file" -Description "Tool mapping for write_file exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "replace" -Description "Tool mapping for replace exists"
Test-Content -Path "$SkillPath\SKILL.md" -Content "run_shell_command" -Description "Tool mapping for run_shell_command exists"

# Test 6: Common Rationalizations
Write-Host ""
Write-Host "Test 6: Common Rationalizations" -ForegroundColor Yellow
Test-Content -Path "$SkillPath\SKILL.md" -Content "常见合理化" -Description "常见合理化 section exists"

# Test 7: Red Flags
Write-Host ""
Write-Host "Test 7: Red Flags" -ForegroundColor Yellow
Test-Content -Path "$SkillPath\SKILL.md" -Content "红色标志" -Description "红色标志 section exists"

# Test 8: Quick Reference
Write-Host ""
Write-Host "Test 8: Quick Reference" -ForegroundColor Yellow
Test-Content -Path "$SkillPath\SKILL.md" -Content "快速参考" -Description "快速参考 section exists"

# Test 9: Examples
Write-Host ""
Write-Host "Test 9: Examples" -ForegroundColor Yellow
Test-Content -Path "$SkillPath\SKILL.md" -Content "完整示例" -Description "Complete example exists"

# Test 10: Real Impact
Write-Host ""
Write-Host "Test 10: Real Impact" -ForegroundColor Yellow
Test-Content -Path "$SkillPath\SKILL.md" -Content "真实影响" -Description "真实影响 section exists"

# Print summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Test Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total Tests: $TotalTests" -ForegroundColor White
Write-Host "Passed: $TestsPassed" -ForegroundColor Green
Write-Host "Failed: $TestsFailed" -ForegroundColor Red

if ($TestsFailed -eq 0) {
    Write-Host ""
    Write-Host "[OK] All tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host ""
    Write-Host "[ERROR] Some tests failed!" -ForegroundColor Red
    exit 1
}