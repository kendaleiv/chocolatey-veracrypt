## Chocolatey Package: veracrypt
This is a [Chocolatey](https://chocolatey.org/) package to install [VeraCrypt](https://www.veracrypt.fr).

[![Chocolatey package version](https://img.shields.io/chocolatey/v/veracrypt.svg)](https://chocolatey.org/packages/veracrypt)
[![Chocolatey package download count](https://img.shields.io/chocolatey/dt/veracrypt.svg)](https://chocolatey.org/packages/veracrypt)

## Installation
1. Install [Chocolatey](https://chocolatey.org/) *(if not already installed)*.
2. `choco install veracrypt`.

## Automatic Updates
A GitHub Actions workflow runs daily to check for new stable VeraCrypt releases. When a new version is detected it automatically:
1. Updates the package version, download URL, and checksum via the [AU](https://github.com/majkinetor/au) module.
2. Builds the `.nupkg` package.
3. Pushes the package to the [Chocolatey](https://chocolatey.org/) registry.
4. Commits the version changes back to the repository.

The workflow can also be triggered manually from the **Actions** tab.

### Setup
Add a `CHOCO_API_KEY` repository secret containing your [Chocolatey API key](https://community.chocolatey.org/account).
