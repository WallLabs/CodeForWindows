#
# Test Setup
#

# Options
Set-StrictMode -Version Latest    # Proactively avoid errors and inconsistency
$error.Clear()                    # Clear any errors from previous script runs
$ErrorActionPreference = "Stop"   # All unhandled errors stop program
$WarningPreference = "Stop"       # All warnings stop program

# Initialize module paths
$env:PSModulePath = [Environment]::GetEnvironmentVariable("PSModulePath", "Machine");
$env:PSModulePath = "$env:PSModulePath;$PSScriptRoot\..\..\PowerShell";

# Force reload of all modules in solution (so source updates are included)
Get-Module -ListAvailable -Name 'CodeForWindows*' -Refresh;
Get-Module -Name 'CodeForWindows*' | Remove-Module -Force;

# Remove any existing output
Set-Location $PSScriptRoot;
[string]$targetDirectory = "$PSScriptRoot\bin";
Get-Item -Path "$targetDirectory\Data" -ErrorAction SilentlyContinue | ForEach-Object { Remove-Item $targetDirectory -Recurse -Force; }

# Copy data to test working path
New-Item -ItemType Directory -Path $targetDirectory;
Copy-Item -Path "$PSScriptRoot\Data" -Destination "$targetDirectory\Data" -Recurse -Force;

# Set working directory for tests
Set-Location $targetDirectory;