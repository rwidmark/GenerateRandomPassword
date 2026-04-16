$ModulePath = Join-Path -Path $PSScriptRoot -ChildPath 'GenerateRandomPassword'
Publish-Module -Path $ModulePath -NuGetApiKey $Env:PSGALLERY
