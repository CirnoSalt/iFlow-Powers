# Test-Driven Development Skill Basic Test
# PowerShell script for Windows compatibility

param(
    [string]$SkillPath = "R:\test2\iFlow-Powers\skills\test-driven-development"
)

# Test counters
$TestsPassed = 0
$TestsFailed = 0
$TotalTests = 0

# Helper function to assert file exists
function Assert-FileExists {
    param(
        [string]$Path,
        [string]$Description
    )
    
    $script:TotalTests++
    if (Test-Path $Path) {
        Write-Host "[PASS] $Description" -ForegroundColor Green
        $script:TestsPassed++
    } else {
        Write-Host "[FAIL] $Description (File not found: $Path)" -ForegroundColor Red
        $script:TestsFailed++
    }
}

# Helper function to assert file contains content
function Assert-Contains {
    param(
        [string]$Path,
        [string]$Content,
        [string]$Description
    )
    
    $script:TotalTests++
    if (Test-Path $Path) {
        $fileContent = Get-Content $Path -Raw
        if ($fileContent -like "*$Content*") {
            Write-Host "[PASS] $Description" -ForegroundColor Green
            $script:TestsPassed++
        } else {
            Write-Host "[FAIL] $Description (Content not found in $Path)" -ForegroundColor Red
            $script:TestsFailed++
        }
    } else {
        Write-Host "[FAIL] $Description (File not found: $Path)" -ForegroundColor Red
        $script:TestsFailed++
    }
}

# Helper function to assert YAML field exists
function Assert-YamlField {
    param(
        [string]$Path,
        [string]$Field,
        [string]$Description
    )
    
    $script:TotalTests++
    if (Test-Path $Path) {
        $fileContent = Get-Content $Path -Raw
        $pattern = "$field\s*:"
        if ($fileContent -match $pattern) {
            Write-Host "[PASS] $Description" -ForegroundColor Green
            $script:TestsPassed++
        } else {
            Write-Host "[FAIL] $Description (YAML field '$Field' not found in $Path)" -ForegroundColor Red
            $script:TestsFailed++
        }
    } else {
        Write-Host "[FAIL] $Description (File not found: $Path)" -ForegroundColor Red
        $script:TestsFailed++
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Test-Driven Development Skill Tests" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Test 1: Check if skill file exists
Write-Host "Test 1: File Structure" -ForegroundColor Yellow
Assert-FileExists -Path "$SkillPath\SKILL.md" -Description "SKILL.md exists"
Assert-FileExists -Path "$SkillPath\tests\test-basic.ps1" -Description "test-basic.ps1 exists"
Assert-FileExists -Path "$SkillPath\examples\README.md" -Description "examples/README.md exists"

# Test 2: Check YAML frontmatter
Write-Host ""
Write-Host "Test 2: YAML Frontmatter" -ForegroundColor Yellow
Assert-YamlField -Path "$SkillPath\SKILL.md" -Field "name" -Description "YAML field 'name' exists"
Assert-YamlField -Path "$SkillPath\SKILL.md" -Field "description" -Description "YAML field 'description' exists"
Assert-YamlField -Path "$SkillPath\SKILL.md" -Field "version" -Description "YAML field 'version' exists"
Assert-YamlField -Path "$SkillPath\SKILL.md" -Field "author" -Description "YAML field 'author' exists"
Assert-YamlField -Path "$SkillPath\SKILL.md" -Field "category" -Description "YAML field 'category' exists"
Assert-YamlField -Path "$SkillPath\SKILL.md" -Field "tags" -Description "YAML field 'tags' exists"

# Test 3: Check core content
Write-Host ""
Write-Host "Test 3: Core Content" -ForegroundColor Yellow
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "RED-GREEN-REFACTOR" -Description "RED-GREEN-REFACTOR section exists"
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "铁律" -Description "铁律 section exists"
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "工具映射" -Description "工具映射 section exists"
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "在 iFlow CLI 中使用" -Description "iFlow CLI usage section exists"

# Test 4: Check TDD cycle components
Write-Host ""
Write-Host "Test 4: TDD Cycle Components" -ForegroundColor Yellow
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "RED - 编写失败的测试" -Description "RED section exists"
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "GREEN - 最小代码" -Description "GREEN section exists"
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "REFACTOR - 清理" -Description "REFACTOR section exists"

# Test 5: Check tool mapping
Write-Host ""
Write-Host "Test 5: Tool Mapping" -ForegroundColor Yellow
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "read_file" -Description "Tool mapping for read_file exists"
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "write_file" -Description "Tool mapping for write_file exists"
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "replace" -Description "Tool mapping for replace exists"
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "run_shell_command" -Description "Tool mapping for run_shell_command exists"

# Test 6: Check common rationalizations
Write-Host ""
Write-Host "Test 6: Common Rationalizations" -ForegroundColor Yellow
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "常见合理化" -Description "常见合理化 section exists"

# Test 7: Check verification checklist
Write-Host ""
Write-Host "Test 7: Verification Checklist" -ForegroundColor Yellow
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "验证检查清单" -Description "验证检查清单 section exists"

# Test 8: Check examples
Write-Host ""
Write-Host "Test 8: Examples" -ForegroundColor Yellow
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "示例：Bug 修复" -Description "Bug fix example exists"
Assert-Contains -Path "$SkillPath\SKILL.md" -Content "完整示例" -Description "Complete example exists"

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