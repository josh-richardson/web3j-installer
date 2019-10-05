$web3j_version="4.5.5"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

New-Item -Force -ItemType directory -Path "${env:USERPROFILE}\.web3j" | Out-Null
$url = "https://github.com/web3j/web3j-cli/releases/download/v${web3j_version}/web3j-${web3j_version}.zip"
$output = "${env:USERPROFILE}\.web3j\web3j.zip"
Write-Output "Downloading Web3j version ${web3j_version}..."
Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Extracting Web3j..."
Expand-Archive -Path "${env:USERPROFILE}\.web3j\web3j.zip" -DestinationPath "${env:USERPROFILE}\.web3j\" -Force
[Environment]::SetEnvironmentVariable(
        "Path",
        [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::User) + ";${env:USERPROFILE}\.web3j\web3j-${web3j_version}\bin",
        [EnvironmentVariableTarget]::User)
Write-Output "Web3j has been successfully installed and added to your PATH variable. Open a new CMD/PowerShell instance to use the 'web3j' command."
