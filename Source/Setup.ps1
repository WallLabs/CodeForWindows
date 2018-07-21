# Options
Set-StrictMode -Version Latest    # Proactively avoid errors and inconsistency
$error.Clear()                    # Clear any errors from previous script runs
$ErrorActionPreference = "Stop"   # All unhandled errors stop program
$WarningPreference = "Stop"       # All warnings stop program

# Write banner
Write-Output 'Solution Setup'
Write-Output '=============='
Write-Output 'Installs and configures the system ready for development or build.'

# Update NuGet
Write-Output 'Updating NuGet provider (required by Pester)...'
Install-PackageProvider -Name NuGet -Force

# Update Pester
Write-Output 'Updating Pester...'
Install-Module -name Pester -Force -SkipPublisherCheck

# Exit successfully
Exit 0;
