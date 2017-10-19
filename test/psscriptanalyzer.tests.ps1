$scriptAnalyzerRules = Get-ScriptAnalyzerRule
$rootFolderOfCheckout = Split-Path $PSScriptRoot
$powerShellFiles = Get-ChildItem $rootFolderOfCheckout -Recurse -Filter *.ps*1

foreach ($powerShellFile in $powerShellFiles)
{
    Describe "File $($powerShellFile) should not produce any PSScriptAnalyzer warnings" {
        
        $analysis = Invoke-ScriptAnalyzer -Path $powerShellFile.FullName   
        
        foreach ($rule in $scriptAnalyzerRules) {
            It "Should pass $rule" {
            
                If ($analysis.RuleName -contains $rule) {
                
                $analysis | Where-Object RuleName -EQ $rule -outvariable failures | Out-Default
                
                $failures.Count | Should Be 0
                
                }
            }
        }
    }
}
