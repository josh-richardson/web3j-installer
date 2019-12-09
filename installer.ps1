Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['*:ErrorAction']='Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

$web3j_version = $(Invoke-WebRequest -Uri https://internal.services.web3labs.com/api/versions/latest).content

New-Item -Force -ItemType directory -Path "${env:USERPROFILE}\.web3j" | Out-Null
$url = "https://github.com/web3j/web3j-cli/releases/download/v${web3j_version}/web3j-${web3j_version}.zip"
$output = "${env:USERPROFILE}\.web3j\web3j.zip"
Write-Output "Downloading Web3j version ${web3j_version}..."
Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Extracting Web3j..."
Expand-Archive -Path "${env:USERPROFILE}\.web3j\web3j.zip" -DestinationPath "${env:USERPROFILE}\.web3j\" -Force
$CurrentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::User)

if (!($CurrentPath -match $web3j_version)) {
    [Environment]::SetEnvironmentVariable(
            "Path",
            $CurrentPath + ";${env:USERPROFILE}\.web3j\web3j-${web3j_version}\bin",
            [EnvironmentVariableTarget]::User)
    Write-Output "Web3j has been added to your PATH variable. You will need to open a new CMD/PowerShell instance to use it."
}

Write-Output "Web3j has been successfully installed (assuming errors were printed to your console)."
