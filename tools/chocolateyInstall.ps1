$packageName = "veracrypt"
$fileType = "exe"
$silentArgs = "" # Silent installation is not supported by VeraCrypt, see https://veracrypt.codeplex.com/discussions/579539
$url = "https://veracrypt.codeplex.com/downloads/get/1372345"

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
