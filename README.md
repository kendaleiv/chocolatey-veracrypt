## Chocolatey Package: veracrypt
This is a [Chocolatey](https://chocolatey.org/) package to install [VeraCrypt](https://www.veracrypt.fr).

[![Chocolatey package version](https://img.shields.io/chocolatey/v/veracrypt.svg)](https://chocolatey.org/packages/veracrypt)
[![Chocolatey package download count](https://img.shields.io/chocolatey/dt/veracrypt.svg)](https://chocolatey.org/packages/veracrypt)

## Installation
1. Install [Chocolatey](https://chocolatey.org/) *(if not already installed)*.
2. `choco install veracrypt`.

## Automatic Updates
A GitHub Actions workflow checks the latest stable VeraCrypt release daily at 06:00 UTC. When a newer version is available, it updates the package version, x64 MSI download URL and SHA-256 checksum, builds and publishes the package to Chocolatey, then commits the changes back to the repository. It uses PowerShell directly, with no AU dependency.

The workflow can also be triggered manually from the **Actions** tab. Pushes to `main` that change the package or workflow continue to build and publish the checked-in version.

### Setup
Add a `CHOCO_API_KEY` repository secret containing your [Chocolatey API key](https://community.chocolatey.org/account). The workflow also needs permission to push commits to the repository.

To update the package locally without publishing, run `.\update.ps1` in PowerShell.
