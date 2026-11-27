Import-Module au

function global:au_SearchReplace {
	@{
		'veracrypt.nuspec' = @{
			"<version>[^<]*</version>" = "<version>$($Latest.Version)</version>"
		}
		'tools\chocolateyInstall.ps1' = @{
			"(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.Url64)'"
			"(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
		}
	}
}

function global:au_GetLatest {
	$release = Invoke-RestMethod -Method Get -Uri 'https://api.github.com/repos/veracrypt/VeraCrypt/releases/latest'
	$version = [Version] ($release.tag_name -replace '^VeraCrypt_', '')
	$assetName = "VeraCrypt_Setup_x64_$version.msi"
	$asset = $release.assets | Where-Object { $_.name -eq $assetName } | Select-Object -First 1

	if (-not $asset) {
		throw "Could not find release asset '$assetName'."
	}

	return @{ Url64 = $asset.browser_download_url; Version = $version }
}

Update-Package -NoReadme -ChecksumFor 64
