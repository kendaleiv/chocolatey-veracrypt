$ErrorActionPreference = 'Stop';

$packageName= 'veracrypt'
$toolsDir   = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url        = 'https://launchpad.net/veracrypt/trunk/1.24-update2/+download/VeraCrypt%20Setup%201.24-Update2.exe'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url

  silentArgs = "" # Silent installation discussion: https://veracrypt.codeplex.com/discussions/579539

  softwareName  = 'VeraCrypt*'
  checksum      = '8633E3EA7382F2CB2370B0BECCBB815D96D4C232CB61E08A1DB82544B21BF51C'
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
