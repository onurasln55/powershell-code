$target = "192.168.1.10" # Hedef cihaz IP adresi
1..65535 | ForEach-Object {
    $port = $_
    if (Test-NetConnection -ComputerName $target -Port $port -InformationLevel Quiet) {
        Write-Host "Port $port is open on $target"
    }
}
