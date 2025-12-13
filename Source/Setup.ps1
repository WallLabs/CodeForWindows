<#
	.Synopsis
	Development Setup Script

	.Description
	Prepares a developer workstation to test, debug or edit this solution.
#>

#region Globals

# Options.
Set-StrictMode -Version Latest;   # Proactively avoid errors and inconsistency.
$error.Clear();                   # Clear any errors from previous script runs.
$ErrorActionPreference = "Stop";  # All unhandled errors stop program.
$WarningPreference = "Stop";      # All warnings stop program.

#endregion

#region Main script.

# Display banner.
Write-Host 'Solution Setup';
Write-Host '==============';
Write-Host 'Configures the system with dependencies required build the solution.';
Write-Host;

# Set web proxy default credential (in case necessary).
$proxy = [System.Net.WebRequest]::GetSystemWebProxy();
$proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials;
[System.Net.WebRequest]::DefaultWebProxy = $proxy;

# TODO: Confirm if setup still required with current PowerShell versions. Upgade to PS Core/7.x.

## Update NuGet.
#Write-Output 'Updating NuGet provider (required by Pester)...'
#Install-PackageProvider -Name NuGet -Force

# Exit successfully.
Write-Host "Development setup completed successfully.";
Exit 0;

#endregion
