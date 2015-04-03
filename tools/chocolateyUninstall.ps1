$packageName = "veracrypt"
$fileType = "exe"
$args = "/u"

$is64bit = Get-ProcessorBits 64

if ($is64bit) {
  $setupExePath = (Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\VeraCrypt).UninstallString.split('"')[1]
}
else {
  $setupExePath = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\VeraCrypt).UninstallString.split('"')[1]
}

Uninstall-ChocolateyPackage $packageName $fileType $args $setupExePath
