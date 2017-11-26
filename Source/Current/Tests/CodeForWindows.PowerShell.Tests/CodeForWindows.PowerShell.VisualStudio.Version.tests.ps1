# Options
Set-StrictMode -Version Latest;    # Proactively avoid errors and inconsistency
$error.Clear();                    # Clear any errors from previous script runs
$ErrorActionPreference = "Stop";   # All unhandled errors stop program
$WarningPreference = "Stop";       # All warnings stop program

# Initialize
& "$PSScriptRoot\Setup.ps1";

# Tests
Describe "Tests" {

    It 'VisualStudio.Version Module' {

        # Verify manifest
        Test-ModuleManifest "$PSScriptRoot\..\..\PowerShell\CodeForWindows.PowerShell.VisualStudio\CodeForWindows.PowerShell.VisualStudio.psd1";

        # Test import
        Import-Module CodeForWindows.PowerShell.VisualStudio;
    }

    It 'VisualStudio.Version Get-VersionFile' {

        # Constants
        [string]$filePath = "$targetDirectory\Data\Version.txt";
        [Version]$expectedVersion = New-Object -TypeName 'System.Version' -ArgumentList 1, 2, 3344, 55666;

        # Call test method to read version file
        [Version]$version = Get-VersionFile($filePath);

        # Check result
        $version | Should Be $expectedVersion;
    }

    It 'VisualStudio.Version Set-VersionFile' {

        # Constants
        [string]$filePath = "$targetDirectory\Data\Set-FileVersion Result.txt";
        [Version]$expectedVersion = New-Object -TypeName 'System.Version' -ArgumentList 1, 2, 3344, 55666;

        # Call test method to write version file
        Set-VersionFile -File $filePath -Version $expectedVersion;

        # Read back and verify
        [Version]$version = Get-VersionFile $filePath;
        $version | Should Be $expectedVersion;
    }

    It 'VisualStudio.Version Set-VersionInXmlProject' {

        # Constants
        [string]$filePath = "$targetDirectory\Data\Visual Studio XML Project.xml";
        [Version]$newVersion = New-Object -TypeName 'System.Version' -ArgumentList 7, 8, 9900, 11222;

        # Call test method to write version file
        Set-VersionInXmlProject -File $filePath -Version $newVersion;
    }
}
