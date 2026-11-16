$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://github.com/veracrypt/VeraCrypt/releases/download/VeraCrypt_1.26.31/VeraCrypt_Setup_x64_1.26.31.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url64bit      = $url64
  softwareName  = 'VeraCrypt*'
  checksum64    = '6B0DBCC1D6910EC9F045689DD29172B4AE825B5FDCDAE1A2D5F1E5B692782265'
  checksumType64= 'sha256'
  silentArgs    = "/qn /norestart ACCEPTLICENSE=YES"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
