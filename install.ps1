$PyReleases = Invoke-RestMethod 'https://github.com/python/cpython/releases.atom'
$PyLatestVersion = ($PyReleases.title) -replace "^v" -notmatch "[a-z]" | Sort-Object { [version] $_ } -Descending | Select-Object -First 1
$PyLatestBaseUrl = "https://www.python.org/ftp/python/${PyLatestVersion}/"
$PyUrl = "${PyLatestBaseUrl}/python-${PyLatestVersion}-amd64.exe"
$PyPkg = $PyUrl | Split-Path -Leaf
Write-Host "############################## Dowloading python ##############################"

Invoke-WebRequest -UseBasicParsing -Uri $PyUrl -OutFile "C:\Users\cloudadmin\Downloads\${PyPkg}"

Write-Host "############################## Dowloaded python ##############################"

Write-Host "############################## Installing python ##############################"

Start-Process C:\Users\cloudadmin\Downloads\${PyPkg} '/quiet InstallAllUsers=1 PrependPath=1 Include_test=0' -wait -NoNewWindow

Write-Host "############################## python installation completed successfully ##############################"

Write-Host "############################## Reload environment variables ##############################"

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host "############################## Reloaded environment variables ##############################"
