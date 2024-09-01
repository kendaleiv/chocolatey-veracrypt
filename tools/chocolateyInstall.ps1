$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://launchpad.net/veracrypt/trunk/1.26.14/+download/VeraCrypt_Setup_x64_1.26.14.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url64bit      = $url64
  softwareName  = 'VeraCrypt*'
  checksum64    = '9A29C7B3B911BBC50BC7F41F93C7659CE70599FD19A78ACA002BD6E4A8D3E9A4'
  checksumType64= 'sha256'
  silentArgs    = "/qn /norestart ACCEPTLICENSE=YES"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
