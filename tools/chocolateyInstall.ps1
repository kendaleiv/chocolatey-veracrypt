$ErrorActionPreference = 'Stop';

$packageName= 'veracrypt'
$toolsDir   = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url        = 'https://launchpad.net/veracrypt/trunk/1.25.9/+download/VeraCrypt%20Setup%201.25.9.exe'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url

  silentArgs = "" # Silent installation discussion: https://veracrypt.codeplex.com/discussions/579539

  softwareName  = 'VeraCrypt*'
  checksum      = '9328f69fe8cca3377b66783fbae4405d764e77eae75cc2b62ac082c551d93a0e'
  checksumType  = 'sha256'
}

#Thanks to dtgm and the GitHub package for ideas.
$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "veracryptInstall.ahk"
$ahkProc = Start-Process -FilePath $ahkExe `
                         -ArgumentList "`"$ahkFile`"" `
                         -PassThru

$ahkId = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"

Install-ChocolateyPackage @packageArgs
