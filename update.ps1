$ErrorActionPreference = 'Stop'

$nuspecPath = Join-Path $PSScriptRoot 'veracrypt.nuspec'
$installPath = Join-Path $PSScriptRoot 'tools/chocolateyInstall.ps1'
$nuspec = Get-Content $nuspecPath -Raw -Encoding UTF8
$currentVersion = [Version] ([xml] $nuspec).package.metadata.version
$release = Invoke-RestMethod -Uri 'https://api.github.com/repos/veracrypt/VeraCrypt/releases/latest'
if ($release.tag_name -notmatch '^VeraCrypt_(\d+\.\d+\.\d+)$') {
    throw "Unexpected release tag: $($release.tag_name)"
}
$version = $Matches[1]

if ([Version] $version -le $currentVersion) {
    Write-Host "Package is up to date at version $currentVersion"
    if ($env:GITHUB_OUTPUT) {
        'updated=false' | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
    }
    return
}

$asset = @($release.assets | Where-Object { $_.name -eq "VeraCrypt_Setup_x64_$version.msi" })
if ($asset.Count -ne 1) {
    throw "Expected exactly one x64 MSI for VeraCrypt $version."
}
$url64 = $asset[0].browser_download_url
$install = Get-Content $installPath -Raw -Encoding UTF8
$urlPattern = "(?m)^(\`$url64\s*=\s*)'[^']*'"
$checksumPattern = "(?m)^(\s*checksum64\s*=\s*)'[^']*'"
if ([regex]::Matches($nuspec, '<version>[^<]*</version>').Count -ne 1 -or
    [regex]::Matches($install, $urlPattern).Count -ne 1 -or
    [regex]::Matches($install, $checksumPattern).Count -ne 1) {
    throw 'Expected one package version, download URL and checksum to update.'
}

$download = [IO.Path]::GetTempFileName()
try {
    Invoke-WebRequest -Uri $url64 -OutFile $download -UseBasicParsing
    $checksum64 = (Get-FileHash $download -Algorithm SHA256).Hash
} finally {
    Remove-Item $download -Force
}

$nuspec = $nuspec -replace '<version>[^<]*</version>', "<version>$version</version>"
$install = $install -replace $urlPattern, "`${1}'$url64'"
$install = $install -replace $checksumPattern, "`${1}'$checksum64'"
[IO.File]::WriteAllText($nuspecPath, $nuspec)
[IO.File]::WriteAllText($installPath, $install, (New-Object System.Text.UTF8Encoding $true))

Write-Host "Updated VeraCrypt from $currentVersion to $version"
if ($env:GITHUB_OUTPUT) {
    "updated=true" | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
    "version=$version" | Out-File -FilePath $env:GITHUB_OUTPUT -Append -Encoding utf8
}
