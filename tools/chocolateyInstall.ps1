$ErrorActionPreference = 'Stop';

$packageName= 'veracrypt'
$toolsDir   = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url        = 'https://veracrypt.codeplex.com/downloads/get/1614078'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url

  silentArgs = "" # Silent installation discussion: https://veracrypt.codeplex.com/discussions/579539

  softwareName  = 'VeraCrypt*'
  checksum      = '79a2112bfddd34fc8fb7117c28a90e4cbeceb182daf57347f574864da5c943b0'
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
