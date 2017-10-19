Describe 'Modules are installed' {
  It "Pester is installed" {
      Get-Module -ListAvailable Pester | Should Not Be $bull
  }
}