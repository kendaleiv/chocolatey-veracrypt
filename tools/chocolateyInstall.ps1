$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://launchpad.net/veracrypt/trunk/1.25.9/+download/VeraCrypt_Setup_x64_1.25.9.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url64bit      = $url64
  softwareName  = 'VeraCrypt*'
  checksum64    = '206d31c2ed1a2b0390d4dfa12e74a9b9dae88658d1f9bfa1bb433b23e2b24fd8'
  checksumType64= 'sha256'
  silentArgs    = "/qn /norestart ACCEPTLICENSE=YES"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
