#
# Module manifest for module 'dotnetCli'
#
 
@{
 
# Script module or binary module file associated with this manifest
RootModule = 'dotnetCli.psm1'
 
# Version number of this module.
ModuleVersion = '1.0'
 
# ID used to uniquely identify this module
GUID = '2fed0871-56b7-445d-91b9-dfac476430ca'
 
# Author of this module
Author = 'Christoph Bergmeister'
 
# Company or vendor of this module
CompanyName = 'Unknown'
 
# Copyright statement for this module
Copyright = '(c) 2017 Christoph Bergmeister. All rights reserved.'
 
# Description of the functionality provided by this module
Description = 'Wrappers for the dotnet CLI'
 
# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = ''
 
# Name of the Windows PowerShell host required by this module
PowerShellHostName = ''
 
# Minimum version of the Windows PowerShell host required by this module
PowerShellHostVersion = ''
 
# Minimum version of the .NET Framework required by this module
DotNetFrameworkVersion = ''
 
# Minimum version of the common language runtime (CLR) required by this module
CLRVersion = ''
 
# Processor architecture (None, X86, Amd64, IA64) required by this module
ProcessorArchitecture = ''
 
# Modules that must be imported into the global environment prior to importing this module
RequiredModules =  @()
 
# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = @()
 
# Script files (.ps1) that are run in the caller's environment prior to importing this module
ScriptsToProcess = '.\dotnetCliAliases.ps1'
 
# Type files (.ps1xml) to be loaded when importing this module
TypesToProcess = @()
 
# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = @()
 
# Modules to import as nested modules of the module specified in ModuleToProcess
NestedModules = @()
 
# Functions to export from this module
FunctionsToExport = @(
    'dotnetbuild',
    'dotnetclean',
    'dotnetpublish',
    'dotnetrestore',
    'dotnettest'
)
 
# Cmdlets to export from this module
CmdletsToExport = @()
 
# Variables to export from this module
VariablesToExport = '*'
 
# Aliases to export from this module
AliasesToExport = @(
    'd'
    'dn'
    'dnc'
    'dnr'
    'dnb'
    'dnt'
    'dnp'
)
 
# List of all modules packaged with this module
ModuleList = @()
 
# List of all files packaged with this module
FileList = @()
 
# Private data to pass to the module specified in ModuleToProcess
PrivateData = ''
 
}