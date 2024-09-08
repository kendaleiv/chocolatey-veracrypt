$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://launchpad.net/veracrypt/trunk/1.26.15/+download/VeraCrypt_Setup_x64_1.26.15.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url64bit      = $url64
  softwareName  = 'VeraCrypt*'
  checksum64    = 'B04253864ADAD522669AD69E94E55945A0736A8C4AEB6742357228120D342CF7'
  checksumType64= 'sha256'
  silentArgs    = "/qn /norestart ACCEPTLICENSE=YES"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
