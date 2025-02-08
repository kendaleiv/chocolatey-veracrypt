$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64      = 'https://launchpad.net/veracrypt/trunk/1.26.20/+download/VeraCrypt_Setup_x64_1.26.20.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url64bit      = $url64
  softwareName  = 'VeraCrypt*'
  checksum64    = '8CC1F95666FCBAB6016C18C36F1E6273308EDFCEEDC535035DA911EC090C2236'
  checksumType64= 'sha256'
  silentArgs    = "/qn /norestart ACCEPTLICENSE=YES"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
