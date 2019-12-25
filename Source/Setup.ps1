<#
	.Synopsis
	Development Setup Script

	.Description
	Prepares a developer workstation to test, debug or edit this solution.
#>

#region Globals

# Options.
Set-StrictMode -Version Latest;   # Proactively avoid errors and inconsistency
$error.Clear();                   # Clear any errors from previous script runs
$ErrorActionPreference = "Stop";  # All unhandled errors stop program
$WarningPreference = "Stop";      # All warnings stop program

#endregion

#region Main script.

# Display banner.
Write-Output 'Solution Setup'
Write-Output '=============='
Write-Output 'Installs and configures the system ready for development or build.'

# Update NuGet.
Write-Output 'Updating NuGet provider (required by Pester)...'
Install-PackageProvider -Name NuGet -Force

# Update Pester.
Write-Output 'Updating Pester...'
Install-Module -name Pester -Force -SkipPublisherCheck

# Exit successfully.
Exit 0;

#endregion
