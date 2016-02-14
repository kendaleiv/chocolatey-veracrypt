$ErrorActionPreference = 'Stop';

$packageName= 'veracrypt'
$toolsDir   = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url        = 'https://veracrypt.codeplex.com/downloads/get/1537178'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url

  silentArgs = "" # Silent installation discussion: https://veracrypt.codeplex.com/discussions/579539

  softwareName  = 'VeraCrypt*'
  checksum      = '3cf0101f1c0cb2a07bf1f7294470f7f16536a4bf2c79805f380c955172476d05'
  checksumType  = 'sha256'
}

#Thanks to dtgm and the GitHub package for ideas.
$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "veracryptInstall.ahk"
$ahkProc = Start-Process -FilePath $ahkExe `
                         -ArgumentList $ahkFile `
                         -PassThru

$ahkId = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"

Install-ChocolateyPackage @packageArgs
