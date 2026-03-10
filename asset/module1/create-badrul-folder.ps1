$ErrorActionPreference = "Stop"

# Server list: name + IP
$servers = @(
    @{ Name = "AShvin";  IP = "192.168.1.21" }
    @{ Name = "Dina";    IP = "192.168.1.202" }
    @{ Name = "Salman";  IP = "192.168.1.160" }
    @{ Name = "Iqbal";   IP = "192.168.1.193" }
    @{ Name = "Adam";    IP = "192.168.1.48" }
    @{ Name = "Faiq";    IP = "192.168.1.201" }
    @{ Name = "YingChen"; IP = "192.168.1.15" }
)

$username = "trainee"
$password = "ebright123!"
$port = 2222
$remoteCommand = "mkdir -p FSKTM"

# Install Posh-SSH if missing (CurrentUser scope)
if (-not (Get-Module -ListAvailable -Name Posh-SSH)) {
    Write-Host "Posh-SSH module not found. Installing..." -ForegroundColor Yellow
    Install-Module -Name Posh-SSH -Scope CurrentUser -Force -AllowClobber
}

Import-Module Posh-SSH

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

foreach ($server in $servers) {
    $name = $server.Name
    $ip = $server.IP

    try {
        Write-Host ("[{0}] Connecting to {1} on port {2}..." -f $name, $ip, $port) -ForegroundColor Cyan

        $session = New-SSHSession -ComputerName $ip -Port $port -Credential $credential -AcceptKey -ErrorAction Stop
        $sessionId = $session.SessionId

        $result = Invoke-SSHCommand -SessionId $sessionId -Command $remoteCommand -ErrorAction Stop

        if ($result.ExitStatus -eq 0) {
            Write-Host "[$name] Success: folder 'FSKTM' ensured." -ForegroundColor Green
        }
        else {
            Write-Host "[$name] Command failed with exit code $($result.ExitStatus)." -ForegroundColor Red
            if ($result.Error) {
                Write-Host "[$name] Error: $($result.Error)" -ForegroundColor Red
            }
        }

        Remove-SSHSession -SessionId $sessionId | Out-Null
    }
    catch {
        Write-Host "[$name] Failed: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "Done." -ForegroundColor Cyan
